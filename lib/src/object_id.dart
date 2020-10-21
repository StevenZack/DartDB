library dart_db;

import 'dart:typed_data';
import 'dart:io';

class ObjectID {
  Uint8List _data = Uint8List(12);
  static int _counter = 0;
  ObjectID(Uint8List data) {
    _data = data;
  }
  factory ObjectID.now() {
    return ObjectID._fromTimestamp(DateTime.now());
  }
  factory ObjectID.fromTimestamp(DateTime dateTime) {
    return null;
  }
  factory ObjectID._fromTimestamp(DateTime dateTime) {
    final s = dateTime.millisecondsSinceEpoch ~/ 1000;
    final bytes = Uint8List(12);
    bytes[0] = s >> 8 * 3;
    bytes[1] = s >> 8 * 2 % 256;
    bytes[2] = s >> 8 % 256;
    bytes[3] = s % 256;

    // machine id 3

    // pid 3
    bytes[7] = pid >> 8 & 256;
    bytes[8] = pid % 256;
    // rand 3
    _counter++;
    bytes[9] = _counter >> 8 * 2 % 256;
    bytes[10] = _counter >> 8 % 256;
    bytes[11] = _counter % 256;
    
    return ObjectID(bytes);
  }
}
