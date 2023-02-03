import 'dart:js_util' as util;

import 'package:js/js.dart';
import 'package:tflite_web/src/js_script_loader.dart';
import 'package:tflite_web/src/models/model_tensor_info.dart';
import 'package:tflite_web/src/models/named_tensor_map.dart';
import 'package:tflite_web/src/models/tensor.dart';
import 'package:tflite_web/src/tflite_web_exception.dart';
import 'package:tflite_web/src/utils.dart';

part 'models/tflite_model.dart';

/// TFLite Web
class TFLiteWeb {
  TFLiteWeb._();

  /// Initialize TFLite package
  ///
  /// Throws TFLiteWebException if fetching script fails
  static Future<void> initialize({
    String tfJsScriptUrl = '/tflite/tf-core.js',
    List<String> tfBackendScriptUrl = const [
      '/tflite/tf-backend-cpu.js',
    ],
    String tfliteScriptUrl = '/tflite/tf-tflite.min.js',
  }) async {
    if (isTFLiteLoaded()) {
      return;
    }

    await loadScript([
      tfJsScriptUrl,
      ...tfBackendScriptUrl,
      tfliteScriptUrl,
    ]);
  }

  /// Loads a TFLiteModel from the given model url
  ///
  /// Throws TFLiteWebException if loading model fails
  static Future<TFLiteModel> loadModelFromUrl(String url) => _load(url);

  /// Loads a TFLiteModel from the given model data
  ///
  /// Throws TFLiteWebException if loading model fails
  static Future<TFLiteModel> loadModelFromMemory(List<int> data) => _load(data);
}
