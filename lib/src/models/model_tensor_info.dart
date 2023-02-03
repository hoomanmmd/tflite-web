import 'package:js/js.dart';

/// Model input/output tensor info
@JS('ModelTensorInfo')
class ModelTensorInfo {
  /// Name of the tensor
  external String name;

  /// Tensor shape information
  external List<int>? shape;

  /// Data type of the tensor.
  external String dtype;
}
