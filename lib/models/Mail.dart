import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Email {
  // "insert into Email values ('$mid','$fid','$sender','$Msubject','$mData','$body',)"
  late int mid;
  late int fid;
  late String sender;
  late String subject;
  late String mData;
  late String body;
  bool Selected = false;
  bool favourite = false;
  bool color = true;

  Email(this.mid, this.fid, this.sender, this.subject, this.mData, this.body);
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
    mp['mid'] = mid;
    mp['fid'] = fid;
    mp['sender'] = sender;
    mp['subject'] = subject;
    mp['mData'] = mData;
    mp['body'] = body;

    return mp;
  }

  Email.fromMap(Map<String, dynamic> map) {
    mid = map['mid'];
    fid = map['fid'];
    sender = map['sender'];
    subject = map['subject'];
    mData = map['mData'];
    body = map['body'];
  }

  contains(String value) {}
}
