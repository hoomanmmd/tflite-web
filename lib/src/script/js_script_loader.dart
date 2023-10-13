import 'dart:async';
import 'dart:html' as html;

import 'package:tflite_web/src/models/tflite_web_exception.dart';

/// Load JavaScript Script
Future<void> loadScript(List<String> urls) async {
  final head = html.querySelector('head')!;

  for (final url in urls) {
    final scriptTag = _createScriptTag(url);
    head.append(scriptTag);

    final loadEvent = scriptTag.onLoad.first;
    final errorEvent = scriptTag.onError.first;

    final success = await _waitForFirst(loadEvent, errorEvent);
    if (!success) {
      throw TFLiteWebException('Error Loading Scripts');
    }
  }
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
