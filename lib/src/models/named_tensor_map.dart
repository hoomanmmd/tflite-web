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
  dynamic operator [](String name) => (this as JSObject).getProperty(name.toJS);

  /// set Tensor
  void operator []=(String name, Object value) {
    if (value is Tensor) {
      (this as JSObject).setProperty(name.toJS, value as JSAny);
    }

    (this as JSObject).setProperty(name.toJS, value.jsify());
  }

  /// get Tensor from Map
  T get<T>(String name) => (this as JSObject).getProperty(name.toJS) as T;
}
