import 'package:js/js.dart';
import 'package:tflite_web/src/models/tensor.dart';
import 'package:tflite_web/src/models/tflite_data_type.dart';
import 'package:tflite_web/src/tflite_web_exception.dart';

/// Creates a tf.Tensor with the provided values, shape and dtype.
Tensor createTensor(
  Object data, {
  List<int>? shape,
  TFLiteDataType? type,
}) {
  try {
    return _createTensor(data, shape, type?.name);
  } catch (e) {
    throw TFLiteWebException(e);
  }
}

@JS('tf.tensor')
external Tensor _createTensor(Object data, List<int>? shape, String? type);
