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
      final JSAny jsInput;
      if (inputs is List) {
        jsInput = JSArray();
        for (final input in inputs) {
          jsInput.add(input as JSAny);
        }
      } else {
        jsInput = inputs as JSAny;
      }
      final output = _tfLiteModel.predict(jsInput, null);

      if (output is JSArray) {
        final outputs = List<Tensor>.generate(
          output.length,
          (i) => (output[i] as Tensor?)!,
          growable: false,
        );

        return outputs as T;
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
      growable: false,
    );

    return inputs;
  }

  List<ModelTensorInfo> get outputs {
    final jsOutputs = _outputs;
    final outputs = List<ModelTensorInfo>.generate(
      jsOutputs.length,
      (i) => jsOutputs[i] as ModelTensorInfo,
      growable: false,
    );

    return outputs;
  }
}
