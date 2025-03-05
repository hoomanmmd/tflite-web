@Timeout(Duration(seconds: 1))
@TestOn('browser')

import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:tflite_web/src/script/tflite_script.dart';
import 'package:tflite_web/tflite_web.dart';

void main() {
  setUp(() async {
    await TFLiteWeb.initialize(
      tfJsScriptUrl: '../example/web/tflite/tf-core.js',
      tfBackendScriptUrls: ['../example/web/tflite/tf-backend-cpu.js'],
      tfliteScriptUrl: '../example/web/tflite/tf-tflite.min.js',
    );
  });

  test('Package is initialized', () async {
    expect(TFLiteScript.isInitialized(), isTrue);
  });

  test('Load TFLite Model from Url', () async {
    final model = await TFLiteModel.fromUrl(
      '../example/web/models/face_detection.tflite',
    );
    expect(model.inputs[0].name, 'input');
    expect(model.inputs[0].shape, [1, 128, 128, 3]);
    expect(model.inputs[0].dtype, 'float32');

    expect(model.outputs[0].name, 'regressors');
    expect(model.outputs[0].dtype, 'float32');
    expect(model.outputs[0].shape, [1, 896, 16]);

    expect(model.outputs[1].name, 'classificators');
    expect(model.outputs[1].dtype, 'float32');
    expect(model.outputs[1].shape, [1, 896, 1]);
  });

  test('Wrong TFLite Model url', () async {
    expect(
      () => TFLiteModel.fromUrl(
        '../example/web/models/non_existing_url.tflite',
      ),
      throwsA(isA<TFLiteWebException>()),
    );
  });

  test('Load TFLite Model from Byte Array', () async {
    final data = await get(
      Uri.parse('../example/web/models/face_detection.tflite'),
    );
    final model = await TFLiteModel.fromMemory(data.bodyBytes);

    expect(model.inputs.length, 1);
    expect(model.outputs.length, 2);
  });

  test('Wrong TFLite Model Byte Array', () async {
    expect(
      () => TFLiteModel.fromMemory([0, 0]),
      throwsA(isA<TFLiteWebException>()),
    );
  });

  test('Run Model', () async {
    final model = await TFLiteModel.fromUrl(
      '../example/web/models/face_detection.tflite',
    );

    final tensor = Tensor(
      Float32List(128 * 128 * 3),
      shape: [1, 128, 128, 3],
      type: TFLiteDataType.float32,
    );

    expect(model.predict<NamedTensorMap>(tensor), isA<NamedTensorMap>());
  });

  test('Wrong shape', () async {
    final model = await TFLiteModel.fromUrl(
      '../example/web/models/face_detection.tflite',
    );

    final tensor = Tensor(
      Float32List(127 * 127 * 3),
      shape: [1, 127, 127, 3],
      type: TFLiteDataType.float32,
    );

    await expectLater(
      () => model.predict<NamedTensorMap>(tensor),
      throwsA(isA<TFLiteWebException>()),
    );

    await expectLater(
      () => model.predict<NamedTensorMap>([tensor, tensor]),
      throwsA(
        predicate(
          (e) =>
              e is TFLiteWebException &&
              e
                  .toString()
                  .contains('does not match the size of the input tensors'),
        ),
      ),
    );

    final namedTensorMap = NamedTensorMap();
    namedTensorMap['test1'] = tensor;
    namedTensorMap['test2'] = tensor;

    await expectLater(
      () => model.predict<NamedTensorMap>(namedTensorMap),
      throwsA(
        predicate(
          (e) =>
              e is TFLiteWebException &&
              e.toString().contains(
                    "The model input names don't match the model input names",
                  ),
        ),
      ),
    );
  });

  test('Create NamedTensorMap', () async {
    final tensor = Tensor([0]);

    final tensorMap = NamedTensorMap();
    tensorMap['test'] = tensor;

    expect(tensorMap['test'], tensor);
    expect(tensorMap.get<Tensor>('test'), tensor);
  });

  test('Tensor Data', () async {
    final tensor = Tensor([0]);

    expect(tensor.dtype, TFLiteDataType.float32.name);
    expect(tensor.strides.length, 0);
    expect(tensor.isDisposed, false);
    expect(tensor.size, 1);

    expect(tensor.dataSync<List<double>>(), [0]);

    await expectLater(
      tensor.dataAsync<List<double>>(),
      completion(<double>[0]),
    );
  });

  test('Wrong Tensor Data', () async {
    expect(() => Tensor({'a': 0}), throwsA(isA<TFLiteWebException>()));
  });

  test('Tensor Disposing', () async {
    final tensor = Tensor([0]);

    expect(tensor.isDisposed, isFalse);
    tensor.dispose();
    expect(tensor.isDisposed, isTrue);
  });
}
