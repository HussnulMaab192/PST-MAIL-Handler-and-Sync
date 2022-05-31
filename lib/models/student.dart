class Student {
  late int id;
  late String name;
  Student(this.id, this.name);
  // int getId()
  // {
  //   return id;
  // }
  int getId() => id;
  String getName() => name;
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = Map<String, dynamic>();
    mp['id'] = id;
    mp['name'] = name;
    return mp;
  }

  Student.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
