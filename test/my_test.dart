import 'dart:typed_data';
import 'dart:io';

import 'package:dart_db/src/object_id.dart';

main(List<String> args) {
  final id = ObjectID.now();
  print(id.bytes());
  print(id.hex());
  print(id.hex().length);

  print('=====================');
  final id2 = ObjectID.fromHex(id.hex());
  print(id2.bytes());
  print(id2.hex()==id.hex());
}
