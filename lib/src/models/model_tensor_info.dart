import 'dart:js_interop';

import 'package:tflite_web/src/models/tflite_data_type.dart';

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
      (i) => jsInputs[i].toDartInt,
      growable: false,
    );

    return inputs;
  }

  /// Data type of the tensor
  TFLiteDataType get dataType => TFLiteDataType.fromName(_dtype.toDart);

  /// Data type of the tensor.
  String get dtype => _dtype.toDart;

  @JS('name')
  external JSString get _name;

  @JS('shape')
  external JSArray<JSNumber>? get _shape;

  @JS('dtype')
  external JSString get _dtype;
}
