library dart_db;

import 'dart:convert';
import 'dart:io';

void saveFile(String path, dynamic data) async {
  final file = File(path);
  if (!file.existsSync()) {
    file.createSync(recursive: true);
  }
  final sink = file.openWrite(mode: FileMode.writeOnly);
  sink.write(jsonEncode(data));
  await sink.close();
}
