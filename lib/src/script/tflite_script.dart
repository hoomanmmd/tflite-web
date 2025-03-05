import 'dart:js_interop';
import 'dart:js_interop_unsafe';

/// TFLite script
class TFLiteScript {
  TFLiteScript._();

  /// Check if script loaded successfully
  static bool isInitialized() {
    final tflite = globalContext['tflite'];

    return tflite is JSObject && tflite.has('loadTFLiteModel');
  }
}
