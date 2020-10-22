library dart_db;

import 'dart:typed_data';
import 'dart:io';
import 'dart:math';

class ObjectID {
  static final _random = Random();
  static const _trippleUint8 = 256 * 256 * 256;

  Uint8List _data = Uint8List(12);

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
    bytes[1] = (s >> 8 * 2) % 256;
    bytes[2] = (s >> 8) % 256;
    bytes[3] = s % 256;

    // random id 3
    final randomId = _random.nextInt(_trippleUint8);
    bytes[4] = (randomId >> 8 * 2) % 256;
    bytes[5] = (randomId >> 8) % 256;
    bytes[6] = randomId % 256;

    // pid 3
    bytes[7] = pid >> 8 & 256;
    bytes[8] = pid % 256;
    
    // rand 3
    final counter = _random.nextInt(_trippleUint8);
    bytes[9] = (counter >> 8 * 2) % 256;
    bytes[10] = (counter >> 8) % 256;
    bytes[11] = counter % 256;

    return ObjectID(bytes);
  }

  Uint8List bytes() {
    return _data;
  }
}
