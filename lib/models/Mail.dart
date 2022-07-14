// ignore_for_file: non_constant_identifier_names

class Email {
  dynamic mid;
  dynamic fid;
  late dynamic accountId;
  late String sender;
  late String subject;
  late String deletedFlag;
  late String body;
  late String fName;

  bool Selected = false;
  bool favourite = false;
  bool color = true;

  Email(
      {this.mid,
      required this.fid,
      required this.sender,
      required this.subject,
      required this.body,
      required this.deletedFlag,
      required this.accountId,
      required this.fName});
  // int getId()
  // {
  //   return id;
  // }
  int getId() => mid;
  String getSender() => sender;
  String getSubject() => subject;
  String getBody() => body;
  bool isfavourite() => favourite;
  bool isSelected() => Selected;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = <String, dynamic>{};

    mp['id'] = mid;
    mp['folder_id'] = fid;
    mp['sender'] = sender;
    mp['subject'] = subject;
    mp['body'] = body;
    mp['account_id'] = accountId;
    mp['folder_name'] = fName;
    return mp;
  }

// 192.168.176.177
  Email.fromMap(Map<String, dynamic> map) {
    mid = map['id'];
    // accountId = map['account_id'];
    fid = map['folder_id'];
    sender = map['sender'];
    subject = map['subject'];
    body = map['body'];
    fName = map['folder_name'];
  }

  Email.fromJsonMap(Map<String, dynamic> map) {
    mid = map['mid'];
    // accountId = map['accId'];
    fid = map['fid'];
    sender = map['sender'];
    subject = map['subject'];
    body = map['body'];
    fName = map['fname'];
  }

  Email.jsonMap(Map<String, dynamic> map) {
    mid = map['mid'];
    accountId = map['accId'];
    fid = map['fid'];

    sender = map['sender'];
    subject = map['subject'];
    body = map['body'];
    fName = map['fName'];
  }
  contains(String value) {}
}
