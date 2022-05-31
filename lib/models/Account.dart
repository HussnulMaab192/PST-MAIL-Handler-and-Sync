// ignore_for_file: non_constant_identifier_names

class Account {
  late int acc_id;
  late String acc_type;
  late String acc_mail;
  late String acc_pswd;

  Account(
    this.acc_id,
    this.acc_type,
    this.acc_mail,
    this.acc_pswd,
  );
  // int getId()
  // {
  //   return id;
  // }

  int getid() => acc_id;
  String getype() => acc_type;
  String getmail() => acc_mail;
  String getPswd() => acc_pswd;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = <String, dynamic>{};
    mp['acc_id'] = acc_id;
    mp['acc_type'] = acc_type;
    mp['acc_mail'] = acc_mail;
    mp['acc_pswd'] = acc_pswd;

    return mp;
  }

  Account.fromMap(Map<String, dynamic> map) {
    acc_id = map['acc_id'];
    acc_type = map['acc_type'];
    acc_mail = map['acc_mail'];
    acc_pswd = map['acc_pswd'];
  }
}
