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
      var value = doc._mirror.getField(key);

      // objectId check;
      if (value.reflectee is ObjectId) {
        if (MirrorSystem.getName(key) != "id") {
          throw Exception('ObjectId field must be named "id"');
        }
        doc._id = key;
      }

      if (!(doc._mirror.type.declarations[key] is VariableMirror)) {
        continue;
      }
      // k v
      doc.fields[MirrorSystem.getName(key)] = value.reflectee;
    }

    if (doc._id == null) {
      throw Exception('no ObjectId field in ${doc._mirror.type.simpleName}');
    }
    return doc;
  }

  ObjectId objectId() {
    return _mirror.getField(_id).reflectee;
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
