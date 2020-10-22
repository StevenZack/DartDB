library dart_db;

import 'dart:io';

import 'package:dart_db/src/object_id.dart';
class Collection {
  // static
  // vars
  String _location;
  Directory _directory;
  Collection(String location) {
    _location = location;
    _directory = Directory(_location);
    if (!_directory.existsSync()) {
      _directory.createSync(recursive: true);
    }
  }

  InsertResult insert(dynamic object) {
    
  }
}

class InsertResult {
  ObjectID insertedID;
}
