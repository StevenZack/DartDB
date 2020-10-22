import 'dart:mirrors';

import 'package:dart_db/src/object_id.dart';

class Document {
  ObjectID objectID;
  dynamic value;
  InstanceMirror _mirror;
  Document(this.value) {
    _mirror = reflect(this.value);
    // objectId check;
    
  }

}
