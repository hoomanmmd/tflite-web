part of '../tflite_web.dart';

/// TFLite model
class TFLiteModel {
  TFLiteModel._(this._tfLiteModel);

  final _TFLiteModel _tfLiteModel;

  /// Loads a TFLiteModel from the given model url
  ///
  /// Throws TFLiteWebException if loading model fails
  static Future<TFLiteModel> fromUrl(String url) => _load(url.toJS);

  /// Loads a TFLiteModel from the given model data
  ///
  /// Throws TFLiteWebException if loading model fails
  static Future<TFLiteModel> fromMemory(List<int> data) {
    if (data is Uint8List) {
      return _load(data.toJS);
    }

    return _load(data.jsify()!);
  }

  /// Execute the inference for the input tensors.
  ///
  ///  The [inputs] tensors, when there is single input for the model,
  ///  inputs param should be a Tensor. For models with multiple inputs,
  ///  inputs params should be in either Tensor[] if the input order is fixed,
  ///  or otherwise NamedTensorMap format.
  T predict<T>(Object inputs) {
    assert(
      inputs is Tensor || inputs is List<Tensor> || inputs is NamedTensorMap,
      'Input must be Tensor or Tensor[] or NamedTensorMap',
    );

    try {
      final dynamic output;
      if (inputs is List) {
        final jsArray = JSArray();
        for (final input in inputs) {
          jsArray.add(input as JSAny);
        }
        output = _tfLiteModel.predict(jsArray, null);
      } else {
        output = _tfLiteModel.predict(inputs as JSAny, null);
      }

      if (output is JSArray) {
        try {
          final outputs = List<Tensor>.generate(
            output.length,
            (i) => (output[i] as Tensor?)!,
          );

          return outputs as T;
        } catch (e) {
          return output as T;
        }
      }

      return output as T;
    } catch (e) {
      throw TFLiteWebException(e);
    }
  }

  /// Tensor inputs info
  List<ModelTensorInfo> get inputs => _tfLiteModel.inputs;

  /// Tensor output info
  List<ModelTensorInfo> get outputs => _tfLiteModel.outputs;
}

Future<TFLiteModel> _load(JSAny data) async {
  assert(TFLiteScript.isInitialized(), 'Package must be initialized');

  try {
    final promise = _loadTFLiteModel(data);

    final model = await promise.toDart;

    return TFLiteModel._(model as _TFLiteModel);
  } catch (e) {
    throw TFLiteWebException(e);
  }
}

@staticInterop
@JS('tflite.loadTFLiteModel')
external JSPromise<JSObject> _loadTFLiteModel(JSAny url);

@staticInterop
@JS('TFLiteModel')
class _TFLiteModel {}

extension _TFLiteModelExtensions on _TFLiteModel {
  @JS('inputs')
  external JSArray<JSAny> get _inputs;

  @JS('outputs')
  external JSArray<JSAny> get _outputs;

  external JSObject predict(JSAny inputs, JSAny? config);

  List<ModelTensorInfo> get inputs {
    final jsInputs = _inputs;
    final inputs = List<ModelTensorInfo>.generate(
      jsInputs.length,
      (i) => jsInputs[i] as ModelTensorInfo,
    );

    return inputs;
  }

  List<ModelTensorInfo> get outputs {
    final jsOutputs = _outputs;
    final outputs = List<ModelTensorInfo>.generate(
      jsOutputs.length,
      (i) => jsOutputs[i] as ModelTensorInfo,
    );

    return outputs;
  }
}
