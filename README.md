# TFLite Web
Run TFLite models on Dart JS. It is packaged in a WebAssembly binary that runs in a browser

## Getting Started
+ Unpack tflite ([link](https://github.com/hoomanmmd/tflite-web/releases/download/0.0.1/tflite.zip)) into your web folder. \
  Result structure:\
  -- Web\
  &#8197; &emsp14;&#8197; &emsp14;├── tflite\
  &#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;├── tf-backend-cpu.js\
  &#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;├── tf-core.js\
  &#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;├── tf-tflite.min.js\
  &#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;├── tflite_web_api_cc_simd.js\
  &#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;├── tflite_web_api_cc_simd.wasm

+ Sample Code:
```
await TFLiteWeb.initialize();
final loadedModel = await TFLiteModel.fromUrl(modelUrl);
final input = createTensor(data, shape, dataType);
final outputs = loadedModel.predict(input);
```

## Current Version:
+ TF-JS: 4.2.0
+ TF-JS TFLite: 0.0.1-alpha.9
