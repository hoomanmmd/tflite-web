import 'dart:js_util' as util;

import 'package:js/js.dart';
import 'package:tflite_web/src/infrastructure/js_script_loader.dart';
import 'package:tflite_web/src/infrastructure/utils.dart';
import 'package:tflite_web/src/models/model_tensor_info.dart';
import 'package:tflite_web/src/models/named_tensor_map.dart';
import 'package:tflite_web/src/models/tensor.dart';
import 'package:tflite_web/src/models/tflite_web_exception.dart';

part 'models/tflite_model.dart';

/// TFLite Web
class TFLiteWeb {
  TFLiteWeb._();

  /// Initialize TFLite package
  ///
  /// Throws TFLiteWebException if fetching script fails
  static Future<void> initialize({
    String tfJsScriptUrl = '/tflite/tf-core.js',
    List<String> tfBackendScriptUrls = const [
      '/tflite/tf-backend-cpu.js',
    ],
    String tfliteScriptUrl = '/tflite/tf-tflite.min.js',
  }) async {
    if (isTFLiteLoaded()) {
      return;
    }

    await loadScript([
      tfJsScriptUrl,
      ...tfBackendScriptUrls,
      tfliteScriptUrl,
    ]);
  }
}
