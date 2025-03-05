import 'dart:js_interop';

import 'package:tflite_web/src/models/tflite_data_type.dart';
import 'package:tflite_web/src/models/tflite_web_exception.dart';

/// A Tensor object represents an immutable, multidimensional array of
/// numbers that has a shape and a data type.
@staticInterop
@JS('tf.Tensor')
class Tensor {
  /// Creates a tf.Tensor with the provided values, shape and dtype.
  factory Tensor(
    Object data, {
    List<int>? shape,
    TFLiteDataType? type,
  }) {
    try {
      return _createTensor(data.jsify()!, shape?.jsify(), type?.name.toJS)
          as Tensor;
    } catch (e) {
      throw TFLiteWebException(e);
    }
  }
}

/// Tensor Extension
extension TensorExtensions on Tensor {
  /// Synchronously downloads the values from the tf.Tensor.
  /// This blocks the UI thread until the values are ready, which
  /// can cause performance issues.
  T dataSync<T>() => _dataSync().dartify() as T;

  /// Tensor Data Type
  String get dtype => _dtype.toDart;

  /// Tensor id
  int get id => _id.toDartInt;

  /// Whether Tensor is Disposed
  bool get isDisposed => _isDisposed.toDart;

  /// Number of elements to skip in each dimension when indexing
  List<int> get strides {
    final jsStrides = _strides;
    final strides = List<int>.generate(
      jsStrides.length,
      (i) => jsStrides[i] as int,
    );

    return strides;
  }

  /// Number of elements in the tensor
  int get size => _size.toDartInt;

  @JS('dtype')
  external JSString get _dtype;

  @JS('id')
  external JSNumber get _id;

  @JS('isDisposed')
  external JSBoolean get _isDisposed;

  @JS('strides')
  external JSArray<JSAny> get _strides;

  @JS('size')
  external JSNumber get _size;

  @JS('dataSync')
  external JSAny _dataSync();

  @JS('data')
  external JSPromise _data<JSAny>();

  /// Dispose Tensor from memory
  external void dispose();

  /// Asynchronously downloads the values from the tf.Tensor.
  /// Returns a Future of TypedArray that resolves when
  /// the computation has finished.
  Future<T> dataAsync<T>() async {
    final output = await _data<T>().toDart;
    return output.dartify() as T;
  }
}

/// Creates a tf.Tensor with the provided values, shape and dtype.
@Deprecated('Use Tensor() instead')
Tensor createTensor(
  Object data, {
  List<int>? shape,
  TFLiteDataType? type,
}) =>
    Tensor(data, shape: shape, type: type);

@staticInterop
@JS('tf.tensor')
external JSAny _createTensor(JSAny data, JSAny? shape, JSAny? type);
