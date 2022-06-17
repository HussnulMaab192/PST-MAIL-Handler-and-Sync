// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

import '../models/account.dart';

import '../models/mail.dart';
import '../providers/db.dart';

class GlobalList extends StatefulWidget {
  static List<Account>? accountsList;
  static List<Email> mails = [];
  static late DBHandler db;

  // static void printData(int fid) async {
  //   GlobalList.mails = await GlobalList.db.getData(fid);

  //   print('Printing..Mails..');

  //   // setState(() {});
  // }

  const GlobalList({Key? key}) : super(key: key);

  @override
  State<GlobalList> createState() => _GlobalListState();
}

class _GlobalListState extends State<GlobalList> {
  @override

//  List<Account> accountsList = [];
  // void initState() {
  //   DBHandler.getInstnace().then((value) {
  //     if (value == null) {
  //       print('Object not created...');
  //     } else {
  //       print('object created successfuly...');
  //       GlobalList.db = value;
  //       setState(() {
  //         if (GlobalList.db.getDB() == null) {
  //           print('returning... ');
  //           return;
  //         }
  //       });
  //     }
  //   });

  //   super.initState();
  // }

  Widget build(BuildContext context) {
    return Scaffold();
  }
}
