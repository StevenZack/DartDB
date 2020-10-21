library dart_db;

import 'dart:io';
import 'package:dart_db/src/collection.dart';
import 'package:path/path.dart' as path;

class Database {
  String _location;
  Directory _directory;
  Database(String location) {
    _location = location;
    _directory = Directory(location);
    if (!_directory.existsSync()) {
      _directory.createSync(recursive: true);
    }
  }
  Collection collection(String name) {
    return Collection(path.join(_location, name));
  }
}
