import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';

/// Parses a stored board post body into a Quill [Document]. Rich posts store a
/// Delta JSON string; legacy/plain bodies are wrapped as plain text so old
/// posts still render.
Document boardBodyToDocument(String body) {
  final text = body.trim();
  if (text.isEmpty) return Document();
  try {
    final decoded = jsonDecode(text);
    if (decoded is List) return Document.fromJson(decoded);
  } catch (_) {
    // Not Delta JSON → treat as plain text below.
  }
  return Document()..insert(0, body);
}

/// Plain-text preview of a stored body (for list cards).
String boardBodyToPlainText(String body) {
  try {
    return boardBodyToDocument(body).toPlainText().trim();
  } catch (_) {
    return body.trim();
  }
}
