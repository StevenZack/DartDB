library dart_db;

import 'dart:convert';
import 'dart:io';

import 'package:dart_db/src/document.dart';
import 'package:dart_db/src/object_id.dart';
import 'package:path/path.dart' as path;

class Collection {
  // static
  // vars
  String _location;
  String name;
  Type type;

  static const String _id = "id";

  Collection(String location, this.type) {
    _location = location;
    final dir = Directory(path.join(_location, _id));
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    name = path.basename(_location);
  }

  InsertResult insert(dynamic object) {
    // type check
    if (object.runtimeType != type) {
      throw Exception('miss match type $type - ${object.runtimeType}');
    }

    final doc = Document.fromValue(object);

    // insert by id
    final file = File(path.join(_location, _id, doc.objectId().hex()));
    if (file.existsSync()) {
      throw Exception(
          'create document ${doc.objectId().hex()} for collection $name: file exists');
    }

    // write
    file.openWrite().write(doc.marshal());
    return InsertResult(doc.objectId());
  }

  Document find(String id) {
    final file = File(path.join(_location, _id, id));
    if (!file.existsSync()) {
      return null;
    }
    final data = file.readAsStringSync();
    return Document.fromJson(jsonDecode(data));
  }
}

class InsertResult {
  ObjectId insertedID;
  InsertResult(this.insertedID);
}
