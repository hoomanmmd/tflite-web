import 'dart:js_util' as util;

import 'package:js/js.dart';
import 'package:tflite_web/src/models/tensor.dart';

/// Named Tensor Map
@JS('Map')
class NamedTensorMap {
  /// Create NamedTensorMap from Map
  external NamedTensorMap();
}

/// Named Tensor Map Extensions
extension NamedTensorMapExtensions on NamedTensorMap {
  /// get Tensor from Map
  dynamic operator [](String name) => util.getProperty<dynamic>(this, name);

  /// set Tensor
  void operator []=(String name, Tensor tensor) => util.setProperty<Tensor>(
        this,
        name,
        tensor,
      );

  /// get Tensor from Map
  T get<T>(String name) => util.getProperty<T>(this, name);
}
