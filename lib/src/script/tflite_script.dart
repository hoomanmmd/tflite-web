import 'dart:js';

/// TFLite script
class TFLiteScript {
  TFLiteScript._();

  /// Check if script loaded successfully
  static bool isLoaded() {
    final tflite = context['tflite'];

    return tflite is JsObject && tflite.hasProperty('loadTFLiteModel');
  }
}
