import 'dart:convert';

String toBase64(String value) {
  return base64.encode(utf8.encode(value));
}
