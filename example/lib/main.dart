import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tflite_web/tflite_web.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TFLiteModel? _tfLieModel;
  String? _modelOutput;

  @override
  void initState() {
    super.initState();
    TFLiteWeb.initialize().then((value) async {
      _tfLieModel = await TFLiteWeb.loadModelFromUrl(
        '/models/face_detection.tflite',
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              onPressed: _tfLieModel == null ? null : _runModel,
              child: const Text('Run Model'),
            ),
            const SizedBox(height: 16),
            if (_modelOutput != null) Text(_modelOutput!),
          ],
        ),
      ),
    );
  }

  void _runModel() async {
    final tensor = createTensor(
      Float32List(128 * 128 * 3),
      shape: [1, 128, 128, 3],
      type: TFLiteDataType.float32,
    );

    final result = _tfLieModel!.predict<NamedTensorMap>(tensor);
    print((result['regressors'] as Tensor).size);
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

void main() {
  runApp(const App());
}
