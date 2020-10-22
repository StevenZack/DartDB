import 'dart:typed_data';
import 'dart:io';

import 'package:dart_db/src/object_id.dart';

main(List<String> args) {
  print(ObjectID.now().bytes());
}
