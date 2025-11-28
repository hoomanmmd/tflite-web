import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:tflite_web/src/models/tensor.dart';

/// Named Tensor Map
@staticInterop
@JS('Map')
class NamedTensorMap {
  /// Create NamedTensorMap from Map
  external factory NamedTensorMap();
}

/// Named Tensor Map Extensions
extension NamedTensorMapExtensions on NamedTensorMap {
  /// get Tensor from Map
  Tensor operator [](String name) =>
      (this as JSObject).getProperty(name.toJS)! as Tensor;

  /// set Tensor
  void operator []=(String name, Tensor value) {
    (this as JSObject).setProperty(name.toJS, value as JSAny);
  }
}
