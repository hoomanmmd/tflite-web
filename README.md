# TFLite Web
Run TFLite models on Dart. It is packaged in a WebAssembly binary that runs in a browser

## Getting Started
+ Unpack tflite ([link](https://github.com/hoomanmmd/tflite-web/releases/download/0.2.0/tflite.zip)) into your web folder. \
  Result structure:\
  -- Web\
  &#8197; &emsp14;&#8197; &emsp14;├── tflite\
  &#8197; &emsp14;&#8197; &emsp14;──────├── tf-backend-cpu.js\
  &#8197; &emsp14;&#8197; &emsp14;──────├── tf-core.js\
  &#8197; &emsp14;&#8197; &emsp14;──────├── tf-tflite.min.js\
  &#8197; &emsp14;&#8197; &emsp14;──────├── tflite_web_...

+ Initialize TFLite:
```
await TFLiteWeb.initialize();
```
This may take a couple of seconds
+ Either Load Model from Url:
```
final model = await TFLiteModel.fromUrl(modelUrl);
```
+ Or load from memory:
```
final model = await TFLiteModel.fromMemory(modelBytes);
```
+ Create a tensor:
```
final input = Tensor(data, shape, dataType);
```
+ Run the model:
```
final outputs = model.predict(input);
```
Depending on the model, the input can be a Tensor, a list of Tensors, or a Tensor map


## Current Version:
+ TF-JS: 4.11.0
+ TF-JS TFLite: 0.0.1-alpha.10
