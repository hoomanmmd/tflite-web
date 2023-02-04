part of '../tflite_web.dart';

/// TFLite model
class TFLiteModel {
  TFLiteModel._(this._tfLiteModel);

  final _TFLiteModel _tfLiteModel;

  /// Loads a TFLiteModel from the given model url
  ///
  /// Throws TFLiteWebException if loading model fails
  static Future<TFLiteModel> fromUrl(String url) => _load(url);

  /// Loads a TFLiteModel from the given model data
  ///
  /// Throws TFLiteWebException if loading model fails
  static Future<TFLiteModel> fromMemory(List<int> data) => _load(data);

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
      return _tfLiteModel.predict(inputs, null) as T;
    } catch (e) {
      throw TFLiteWebException(e);
    }
  }

  /// Tensor inputs info
  List<ModelTensorInfo> get inputs => _tfLiteModel.inputs;

  /// Tensor output info
  List<ModelTensorInfo> get outputs => _tfLiteModel.outputs;
}

Future<TFLiteModel> _load(dynamic data) async {
  assert(isTFLiteLoaded(), 'Package must be initialized');

  try {
    final promise = _loadTFLiteModel(data);

    final model = await util.promiseToFuture<_TFLiteModel>(promise);

    return TFLiteModel._(model);
  } catch (e) {
    throw TFLiteWebException(e);
  }
}

@JS('tflite.loadTFLiteModel')
external Object _loadTFLiteModel(dynamic url);

@JS('TFLiteModel')
class _TFLiteModel {
  external List<ModelTensorInfo> inputs;
  external List<ModelTensorInfo> outputs;
  external Object predict(Object inputs, Object? config);
}
