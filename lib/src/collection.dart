library dart_db;

import 'dart:io';

import 'package:dart_db/src/document.dart';
import 'package:dart_db/src/object_id.dart';
import 'package:path/path.dart' as path;

class Collection {
  // static
  // vars
  String _location;
  Directory _directory;
  String name;

  Collection(String location) {
    _location = location;
    _directory = Directory(_location);
    if (!_directory.existsSync()) {
      _directory.createSync(recursive: true);
    }
    name = path.basename(_location);
  }

  InsertResult insert(dynamic object) {
    final doc = Document.fromValue(object);

    // insert
    final file = File(path.join(_location, doc.objectId().hex()));
    if (file.existsSync()) {
      throw Exception(
          'create document ${doc.objectId().hex()} for collection $name: file exists');
    }

    file.openWrite().write(doc.marshal());
    return InsertResult(doc.objectId());
  }
}

class InsertResult {
  ObjectId insertedID;
  InsertResult(this.insertedID);
}
