import 'dart:convert';
import 'dart:mirrors';

import 'package:dart_db/src/object_id.dart';

class Document {
  dynamic value;

  InstanceMirror _mirror;
  Symbol _id;
  final fields = Map<String, dynamic>();

  Document() {}

  factory Document.fromValue(dynamic value) {
    final doc = Document();
    doc._mirror = reflect(value);
    for (var key in doc._mirror.type.declarations.keys) {
      // variableMirror check
      if (!(doc._mirror.type.declarations[key] is VariableMirror)) {
        continue;
      }

      var value = doc._mirror.getField(key);
      var type = doc._mirror.type.declarations[key] as VariableMirror;

      // objectId check;
      if (type.type.qualifiedName == ObjectId.symbol) {
        if (MirrorSystem.getName(key) != "id") {
          throw Exception('ObjectId field must be named "id"');
        }
        doc._id = key;
      }
      // k v
      doc.fields[MirrorSystem.getName(key)] = value.reflectee;
    }

    if (doc._id == null) {
      throw Exception('no ObjectId field in ${doc._mirror.type.simpleName}');
    }

    // generate object id
    if (doc.objectId() == null || doc.objectId() == ObjectId.zero) {
      doc.fields[MirrorSystem.getName(doc._id)] = ObjectId.now();
    }
    return doc;
  }

  ObjectId objectId() {
    return fields[MirrorSystem.getName(_id)];
  }

  // json
  factory Document.fromJson(Map<String, dynamic> v) {
    final doc = Document();
    v.forEach((key, value) {
      doc.fields[key] = value;
    });
    return doc;
  }
  Map<String, dynamic> toJson() {
    return fields;
  }

  // marshal
  String marshal() {
    return jsonEncode(this);
  }
}
