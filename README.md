# TFLite Web
Run TFLite models on Dart JS. It is packaged in a WebAssembly binary that runs in a browser

## Getting Started
+ Unpack tflite folder ([link](https://github.com/hoomanmmd/tflite-web/releases/download/0.0.1/tflite.zip)) to your web folder.
  Result structure:
  -- Web
  &#8197; &emsp14;&#8197; &emsp14;├── tflite
  &#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;├── tf-backend-cpu.js
  &#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;├── tf-core.js
  &#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;├── tf-tflite.min.js
  &#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;├── tflite_web_api_cc_simd.js
  &#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;&#8197; &emsp14;├── tflite_web_api_cc_simd.wasm

+ Initialize dependencies:
  ```TFLiteWeb.initialize()```

+ Load a model:
  By URL
  ```TFLiteWeb.loadModelFromUrl```
  By Data
  ```TFLiteWeb.loadModelFromMemory```

+ Create Tensor:
  ```createTensor(data, shape, dataType)```

+ Run model:
  ```loadedModel.predict(inputs)```

## Current Version:
+ TF JS: 4.2.0
+ TFLite: 0.0.1-alpha.9
