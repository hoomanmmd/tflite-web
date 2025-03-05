import 'dart:js_interop';

/// Model input/output tensor info
@staticInterop
@JS('ModelTensorInfo')
class ModelTensorInfo {}

/// ModelTensorInfo Extensions
extension ModelTensorInfoExtensions on ModelTensorInfo {
  /// Name of the tensor
  String get name => _name.toDart;

  /// Tensor shape information
  List<int>? get shape {
    final jsInputs = _shape;
    if (jsInputs == null) {
      return null;
    }
    final inputs = List<int>.generate(
      jsInputs.length,
      (i) => jsInputs[i] as int,
    );

    return inputs;
  }

  /// Data type of the tensor.
  String get dtype => _dtype.toDart;

  @JS('name')
  external JSString get _name;

  @JS('shape')
  external JSArray<JSAny>? get _shape;

  @JS('dtype')
  external JSString get _dtype;
}
