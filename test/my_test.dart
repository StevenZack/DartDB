import 'package:dart_db/src/collection.dart';
import 'package:dart_db/src/document.dart';
import 'package:dart_db/src/object_id.dart';

class Student {
  ObjectId id;
  String name;
  int age;
  Student(this.name, this.age);
}

main(List<String> args) {
  final col = Collection('./user');
  final r = col.insert(Student('asd2', 17));
  print(r.insertedID.hex());
}
