import 'dart:convert';
import 'dart:mirrors';

import 'package:dart_db/src/object_id.dart';

class Student {
  String name;
  int age;
  Student({this.name, this.age});
}

main(List<String> args) {
  var s = '{"name":"asd","age":17}';
  Map<String, dynamic> d = jsonDecode(s);
  d.forEach((key, value) {
    print('$key:$value');
  });
}
