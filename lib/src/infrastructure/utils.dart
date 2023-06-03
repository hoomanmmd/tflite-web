import 'dart:js';

/// Check if script loaded successfully
bool isTFLiteLoaded() {
  final tflite = context['tflite'];

  return tflite is JsObject && tflite.hasProperty('loadTFLiteModel');
}
