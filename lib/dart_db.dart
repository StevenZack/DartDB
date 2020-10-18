library dart_db;

import 'dart:io';

class DartDB {
  final String location;
  Directory _dir;
  DartDB({this.location}) {
    _dir = Directory(location);
    if (!_dir.existsSync()) {
      _dir.createSync(recursive: true);
    }
  }
}
