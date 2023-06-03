import 'package:js/js.dart';
import 'package:tflite_web/src/infrastructure/extensions.dart';
import 'package:tflite_web/src/models/js_promise.dart';
import 'package:tflite_web/src/models/tflite_data_type.dart';
import 'package:tflite_web/src/models/tflite_web_exception.dart';

/// A Tensor object represents an immutable, multidimensional array of
/// numbers that has a shape and a data type.
@JS('tf.Tensor')
class Tensor {
  /// Synchronously downloads the values from the tf.Tensor.
  /// This blocks the UI thread until the values are ready, which
  /// can cause performance issues.
  external T dataSync<T>();

  /// Asynchronously downloads the values from the tf.Tensor.
  /// Returns a promise of TypedArray that resolves when
  /// the computation has finished.
  external JsPromise<T> data<T>();

  /// Tensor Data Type
  external String dtype;

  /// Tensor id
  external int id;

  /// Whether Tensor is Disposed
  external bool isDisposed;

  /// Number of elements to skip in each dimension when indexing
  external List<int> strides;

  /// Number of elements in the tensor
  external int size;

  /// Dispose Tensor from memory
  external void dispose();
}

/// Tensor Extension
extension TensorExtensions on Tensor {
  /// Asynchronously downloads the values from the tf.Tensor.
  /// Returns a Future of TypedArray that resolves when
  /// the computation has finished.
  Future<T> dataAsync<T>() => data<T>().toFuture();
}

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
