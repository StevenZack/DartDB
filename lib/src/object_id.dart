library dart_db;

import 'dart:mirrors';
import 'dart:typed_data';
import 'dart:io';
import 'dart:math';

class ObjectId {
  static final _random = Random();
  static const _trippleUint8 = 256 * 256 * 256;
  static final zero = ObjectId(Uint8List(12));
  static final symbol = MirrorSystem.getSymbol('dart_db.ObjectId');

  Uint8List _data = Uint8List(12);

  ObjectId(Uint8List data) {
    _data = data;
  }

  // factory
  factory ObjectId.now() {
    return ObjectId._fromTimestamp(DateTime.now());
  }
  factory ObjectId.fromHex(String hex) {
    if (hex.length != 24) {
      throw Exception('invalid hex for ObjectID:$hex');
    }
    final data = Uint8List(12);
    for (var i = 0; i < 12; i++) {
      final s = hex.substring(i * 2, i * 2 + 2);
      data[i] = int.parse(s, radix: 16, onError: (e) {
        throw Exception('invalid hex for ObjectID:$hex');
      });
    }
    return ObjectId(data);
  }
  factory ObjectId.fromJson(String s) {
    return ObjectId.fromHex(s);
  }
  factory ObjectId.fromTimestamp(DateTime dateTime) {
    final s = dateTime.millisecondsSinceEpoch ~/ 1000;
    final bytes = Uint8List(12);
    bytes[0] = s >> 8 * 3;
    bytes[1] = (s >> 8 * 2) % 256;
    bytes[2] = (s >> 8) % 256;
    bytes[3] = s % 256;
    return ObjectId(bytes);
  }
  factory ObjectId._fromTimestamp(DateTime dateTime) {
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

    return ObjectId(bytes);
  }

  // methods
  Uint8List bytes() {
    return _data;
  }

  DateTime toTimestamp() {
    var sec = _data[0] << 8 * 3;
    sec += _data[1] << 8 * 2;
    sec += _data[2] << 8;
    sec += _data[3];
    return DateTime.fromMillisecondsSinceEpoch(sec * 1000);
  }

  String hex() {
    final buf = StringBuffer();
    for (var i = 0; i < 12; i++) {
      var s = _data[i].toRadixString(16);
      if (s.length == 1) {
        s = '0' + s;
      }
      buf.write(s);
    }
    return buf.toString();
  }

  String toJson() {
    return hex();
  }
}
