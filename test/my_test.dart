import 'dart:mirrors';

class Student {
  String name;
  int age;
  Student({this.name, this.age});
}

main(List<String> args) {
  var r = reflect(Student(name: 'asd', age: 17));
  for (var key in r.type.declarations.keys) {
    if (r.type.declarations[key] is VariableMirror) {
      var vm = r.type.declarations[key] as VariableMirror;
      var value = r.getField(key);
      print(value.reflectee is String);
      print(
          '${MirrorSystem.getName(key)}:${MirrorSystem.getName(vm.type.simpleName)} = ${value.reflectee}');
    }
  }
}
