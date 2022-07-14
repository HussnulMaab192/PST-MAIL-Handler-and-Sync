// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:pst1/Screens/textFieldBuilder.dart';
import '../Styles/app_colors.dart';
import '../models/mail.dart';
import '../providers/db.dart';
import 'compose.dart';

class ReplyMail extends StatefulWidget {
  final mid;
  final fid;
  final subject;
  final body;
  final sender;

  dynamic portNo;
  dynamic smtpServer;
  dynamic pswd;
  dynamic accMail;
  dynamic accId;
  ReplyMail({
    required this.mid,
    required this.fid,
    required this.subject,
    required this.body,
    required this.sender,
    required this.portNo,
    required this.smtpServer,
    required this.pswd,
    required this.accMail,
    required this.accId,
    Key? key,
  }) : super(key: key);

  @override
  State<ReplyMail> createState() => _ReplyMailState();
}

List<Email> mails = [];
bool menu = false;
String selection = "Select All";

class _ReplyMailState extends State<ReplyMail> {
  TextEditingController replyController = TextEditingController();
  late DBHandler db;
  int c = 0;
  TextEditingController folderController = TextEditingController();
  // void _printData(int fid) async {
  //   mails = await db.getData(fid);
  //   print(mails);
  //   print('Printing..Mails..');

  //   mails.forEach(((element) => print('${element.body}  ${element.fid}')));
  //   setState(() {});
  // }

  void moveEmails(String fid) async {
    List<Email> selectEmail =
        mails.where((element) => element.Selected).toList();
    mails.removeWhere((element) => element.Selected);
    for (var element in selectEmail) {
      db.UpdateEmail(int.parse(fid), element.mid);
      // db.insertActionData(1, "mail", "move", "${element.fid.toString()}",
      //     "$fid", DateTime.now(), element.mid);

      //     EAction a = EAction(1, "mail", "move", "${element.fid.toString()}", "$fid",
      //     DateTime.now(), element.mid);
      // await db.insertActionData(a);
    }

    setState(() {});
  }

  void delete() async {
    List<Email> selectEmail =
        mails.where((element) => element.Selected).toList();
    mails.removeWhere((element) => element.Selected);
    for (var element in selectEmail) {
      db.deleteMail(element.mid);
      // db.insertActionData(1, "mail", "delete", element.fid.toString(), "",
      //     DateTime.now(), element.mid);

      // EAction a = EAction(1, "mail", "delete", "${element.fid.toString()}", "",
      //     DateTime.now(), element.mid);
      // await db.insertActionData(a);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          SizedBox(
            height: 20,
          ),
        ],
        title: const Text('Inbox'),
        backgroundColor: AppColors.lightblueshade,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                title: Text(
                  widget.subject.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            // // the container for subject
            const SizedBox(
              height: 5,
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(widget.sender[0].toString()),
                ),
                title: Text(
                  widget.sender.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: const Text("mabimalik192@gmail.com"),
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            Card(
              child: ListTile(
                title: Text(
                  widget.body.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),

            // Container(
            //   height: MediaQuery.of(context).size.height * 0.6,
            //   width: MediaQuery.of(context).size.width * 0.97,
            //   decoration: BoxDecoration(
            //     borderRadius: const BorderRadius.all(
            //       Radius.circular(15),
            //     ),
            //     border: Border.all(
            //       color: Colors.blue,
            //       width: 1.0,
            //       style: BorderStyle.solid,
            //     ),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: Text(
            //       widget.body.toString(),
            //       style: const TextStyle(fontSize: 20),
            //     ),
            //   ),
            // ),

            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Compose(
                            sender: widget.accId,
                            portNo: widget.portNo,
                            smtpServer: widget.smtpServer,
                            pswd: widget.pswd,
                            accMail: widget.accMail,
                            accId: widget.accId,
                          )));
                },
                child: const Text("Reply")),
            // // the container for sender anme
            // Container()
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 280.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        InkWell(
          onTap: () {
            moveEmails("1");
          },
          child: const ListTile(
            leading: Icon(Icons.drafts_outlined),
            title: Text("Drafts"),
          ),
        ),
        InkWell(
          onTap: () {
            moveEmails("2");
          },
          child: const ListTile(
              leading: Icon(Icons.archive_outlined), title: Text("Archive")),
        ),
        InkWell(
            onTap: () {
              moveEmails("3");
            },
            child: const ListTile(
                leading: Icon(Icons.send_outlined), title: Text("Send"))),
        InkWell(
          onTap: () {
            moveEmails("4");
          },
          child: const ListTile(
              leading: Icon(Icons.delete_outlined), title: Text("Delete")),
        ),
        InkWell(
          onTap: () {
            moveEmails("5");
          },
          child: const ListTile(
              leading: Icon(Icons.delete_forever_rounded), title: Text("junk")),
        ),
      ]),
    );
  }
}
