# TFLite Web
Run TFLite models on Dart. It is packaged in a WebAssembly binary that runs in a browser

## Getting Started
+ Initialize TFLite:
```
await TFLiteWeb.initializeUsingCDN();
```
This may take a couple of seconds.
You can load JS scripts from your own hosting solution using `TFLiteWeb.initialize()`.
+ Either Load Model from Url:
```
final model = await TFLiteModel.fromUrl(modelUrl);
```
+ Or load from memory:
```
final model = await TFLiteModel.fromMemory(modelBytes);
```
+ If you need to access the model from the assets in Flutter, you can either:
```
final url = AssetManager().getAssetUrl(asset);
final model = await TFLiteModel.fromUrl(url);
```
+ Or:
```
final byteData = await rootBundle.load(asset);
final bytes = byteData.buffer.asUint8List();
model = await TFLiteModel.fromMemory(bytes);
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

### Flutter
If you're wondering how to use this package with `tflite_flutter`, please refer to this article ([link](https://medium.com/@hoomanmmd/run-tflite-on-web-alongside-mobile-bdef67b36ea4))

## Current Version:
+ TF-JS: 4.11.0
+ TF-JS TFLite: 0.0.1-alpha.10
