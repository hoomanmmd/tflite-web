import 'dart:js_util' as util;

import 'package:tflite_web/src/models/js_promise.dart';

/// Extensions on JavaScript Promise
extension JsPromiseExtensions<T> on JsPromise<T> {
  /// Convert Js Promise to Future
  Future<T> toFuture() => util.promiseToFuture<T>(this);
}
