import 'dart:async';

import 'package:tflite_web/src/models/tflite_web_exception.dart';
import 'package:web/web.dart' as web;

/// Load JavaScript Script
Future<void> loadScript(List<String> urls) async {
  final head = web.document.querySelector('head')!;

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
  Future<web.Event> onLoad,
  Future<web.Event> onError,
) {
  final completer = Completer<bool>();

  onLoad.then((value) => completer.complete(true));
  onError.then((value) => completer.complete(false));

  return completer.future;
}

web.HTMLScriptElement _createScriptTag(String url) => web.HTMLScriptElement()
  ..src = url
  ..type = 'application/javascript'
  ..async = true;
