import 'dart:async';

import 'package:flutter/material.dart';

import '../../../Styles/app_colors.dart';
import '../../../models/Mail.dart';
import '../../../providers/Db.dart';

class Drafts extends StatefulWidget {
  const Drafts({Key? key}) : super(key: key);

  @override
  State<Drafts> createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  late DBHandler db;
  List<Email> mails = [];
  bool menu = false;
  void handleTimeout() {
    // callback function
    print('Inside handle time out.. ');
    DBHandler.getInstnace().then((value) {
      // ignore: unnecessary_null_comparison
      if (value == null) {
        print('Object not created...');
      } else {
        print('object created successfuly...');
        db = value;
        setState(() {
          while (db.getDB() == null) continue;
          print(db);
          _printData(1);
          setState(() {});
        });
      }
    });
  }

  void initState() {
    final timer = Timer(
      const Duration(milliseconds: 300),
      () {
        // Navigate to your favorite place
        handleTimeout();
      },
    );
  }

  void _printData(int fid) async {
    mails = await db.getData(fid);
    print('Printing..Mails..');
    mails.forEach(((element) => print('${element.body}  ${element.fid}')));
    setState(() {});
  }

  void moveEmails(String fid) {
    List<Email> selectEmail =
        mails.where((element) => element.Selected).toList();
    mails.removeWhere((element) => element.Selected);
    for (var element in selectEmail) {
      db.UpdateEmail(int.parse(fid), element.mid);
    }
    setState(() {});
  }

  void delete() {
    List<Email> selectEmail =
        mails.where((element) => element.Selected).toList();
    mails.removeWhere((element) => element.Selected);
    for (var element in selectEmail) {
      db.deleteMail(element.mid);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          menu == true
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: PopupMenuButton(
                      itemBuilder: (context) => [
                            PopupMenuItem(
                                child: GestureDetector(
                              onTap: (() => showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => bottomSheet()),
                                  )),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.move_to_inbox,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Move to ")
                                ],
                              ),
                            )),
                            PopupMenuItem(
                                child: GestureDetector(
                              onTap: () {
                                delete();
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Delete "),
                                ],
                              ),
                            )),
                            PopupMenuItem(
                                child: Row(
                              children: const [
                                Icon(
                                  Icons.mark_unread_chat_alt,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Mark as unread")
                              ],
                            )),
                            PopupMenuItem(
                                child: Row(
                              children: const [
                                Icon(
                                  Icons.move_to_inbox,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Select All ")
                              ],
                            )),
                          ],
                      child: Icon(Icons.more_vert)),
                )
              : Container(),
        ],
        title: const Text("Drafts"),
        backgroundColor: AppColors.lightblueshade,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            // scrollDirection: Axis.vertical,
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: mails.length,
            itemBuilder: ((context, index) {
              return InkWell(
                key: Key(mails[index].mid.toString()),
                splashColor: Colors.blue,
                onLongPress: () {
                  setState(() {
                    mails[index].color = !mails[index].color;
                    mails[index].Selected = !mails[index].Selected;
                    if (mails[index].Selected == true) {
                      menu = true;
                    } else {
                      menu = false;
                    }
                  });
                },
                child: Card(
                  color: mails[index].color ? Colors.white : Colors.blueAccent,
                  elevation: 1,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: mails[index].Selected
                          ? const Icon(Icons.done)
                          : Text(mails[index].subject[0]),
                    ),
                    title:
                        Text('${mails[index].subject}   ${mails[index].fid} '),
                    subtitle: Text(
                      mails[index].body,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: const Icon(Icons.star_border_outlined),
                  ),
                ),
              );
            })),
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
            moveEmails("0");
          },
          child: const ListTile(
            leading: Icon(Icons.inbox_outlined),
            title: Text("Inbox"),
          ),
        ),
        InkWell(
          onTap: () {
            moveEmails("2");
          },
          child: const ListTile(
              leading: Icon(Icons.archive_outlined), title: Text("Archieve")),
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
