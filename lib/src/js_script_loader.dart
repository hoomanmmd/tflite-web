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

    final loadEvent = scriptTag.onLoad.first;
    final errorEvent = scriptTag.onError.first;
    tasks.add(loadEvent);
    unawaited(
      errorEvent.then((value) {
        if (!completer.isCompleted) {
          completer.completeError(TFLiteWebException('Error Loading Scripts'));
        }
      }),
    );

    final success = await _waitForFirst(loadEvent, errorEvent);
    if (!success) {
      return completer.future;
    }
  }

  unawaited(
    Future.wait(tasks).then((value) => completer.complete()),
  );

  return completer.future;
}

Future<bool> _waitForFirst(
  Future<html.Event> onLoad,
  Future<html.Event> onError,
) {
  final completer = Completer<bool>();

  onLoad.then((value) => completer.complete(true));
  onError.then((value) => completer.complete(false));

  return completer.future;
}

html.ScriptElement _createScriptTag(String url) => html.ScriptElement()
  ..src = url
  ..type = 'application/javascript'
  ..async = true;
