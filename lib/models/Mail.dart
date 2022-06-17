// ignore_for_file: non_constant_identifier_names

class Email {
  // "insert into Email values ('$mid','$fid','$sender','$Msubject','$mData','$body',)"
  late dynamic mid;
  late dynamic fid;
  late dynamic accountId;
  late String sender;
  late String subject;
  late String mData;
  late String body;

  bool Selected = false;
  bool favourite = false;
  bool color = true;

  Email(this.mid, this.fid, this.sender, this.subject, this.mData, this.body,
      this.accountId);
  // int getId()
  // {
  //   return id;
  // }

  String getSender() => sender;
  String getSubject() => subject;
  String getmData() => mData;
  String getBody() => body;
  bool isfavourite() => favourite;
  bool isSelected() => Selected;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = <String, dynamic>{};
    mp['id'] = mid;
    mp['folder_id'] = fid;
    mp['sender'] = sender;
    mp['subject'] = subject;
    mp['mData'] = mData;
    mp['body'] = body;
    mp['body'] = body;
    mp['account_id'] = accountId;
    return mp;
  }

  Email.fromMap(Map<String, dynamic> map) {
    mid = map['id'];
    accountId = map['account_id'];
    fid = map['folder_id'];
    sender = map['sender'];
    subject = map['subject'];
    mData = map['mData'];
    body = map['body'];
  }

  contains(String value) {}
}
