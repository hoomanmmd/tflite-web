import 'package:test/test.dart';
import 'package:tflite_web/src/script/tflite_script.dart';
import 'package:tflite_web/tflite_web.dart';

void main() {
  test('Wrong initialize path', () async {
    expect(
      TFLiteWeb.initialize,
      throwsA(isA<TFLiteWebException>()),
    );

    expect(TFLiteScript.isInitialized(), isFalse);

    await TFLiteWeb.initialize(
      tfJsScriptUrl: '../example/web/tflite/tf-core.js',
      tfBackendScriptUrls: ['../example/web/tflite/tf-backend-cpu.js'],
      tfliteScriptUrl: '../example/web/tflite/tf-tflite.min.js',
    );

    expect(TFLiteScript.isInitialized(), isTrue);
  });
}
