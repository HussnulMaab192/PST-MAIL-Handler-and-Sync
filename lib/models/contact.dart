// ignore_for_file: non_constant_identifier_names

class Contact {
  late int contact_id;
  late String first_name;
  late String last_name;
  late String picture;
   int? acc_id;
  late String email;
  late int number;
  Contact(this.contact_id, this.first_name, this.last_name, this.picture,
      this.acc_id, this.email, this.number);

  int getContactId() => contact_id;
  String getFirstName() => first_name;
  String getLastName() => last_name;
  String getpic() => picture;
  int accId() => acc_id!;
  int getnumber() => number;
  String getEmail() => email;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = <String, dynamic>{};
    mp['id'] = acc_id;
    mp['first_name'] = first_name;
    mp['last_name'] = last_name;
    mp['picture'] = picture;
    mp['acc_id'] = acc_id;
    mp['email'] = email;
    mp['number'] = number;
    return mp;
  }

  Contact.fromMap(Map<String, dynamic> map) {
    contact_id = map['id'];
    first_name = map['first_name'];
    last_name = map['last_name'];
    picture = map['picture'];
    acc_id = map['acc_id'];
    email = map['email'];
    number = map['number'];
  }
}
