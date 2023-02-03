import 'dart:async';
import 'dart:html' as html;

import 'package:tflite_web/src/tflite_web_exception.dart';

/// Load JavaScript Script
Future<void> loadScript(List<String> urls) async {
  final tasks = <Future<void>>[];
  final head = html.querySelector('head')!;

  final completer = Completer<void>();

  for (final url in urls) {
    final scriptTag = _createScriptTag(url);
    head.append(scriptTag);

    final task = scriptTag.onLoad.first;
    tasks.add(task);
    unawaited(
      scriptTag.onError.first.then((value) {
        if (!completer.isCompleted) {
          completer.completeError(TFLiteWebException('Error Loading Scripts'));
        }
      }),
    );
    await task;
  }

  unawaited(
    Future.wait(tasks).then((value) => completer.complete()),
  );

  return completer.future;
}

html.ScriptElement _createScriptTag(String url) => html.ScriptElement()
  ..src = url
  ..type = 'application/javascript'
  ..async = true;
