import 'package:dart_db/src/collection.dart';
import 'package:dart_db/src/document.dart';
import 'package:dart_db/src/object_id.dart';

class Student {
  ObjectId id;
  String name;
  int age;
  Student(this.name, this.age);
}

class Dog {
  ObjectId id;
}

main(List<String> args) {
  final col = Collection('./user', Dog);
  final doc = col.find("5f93e30748facb005b93505c");
  print(doc.marshal());
}
