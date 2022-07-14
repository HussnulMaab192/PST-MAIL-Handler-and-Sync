import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pst1/Screens/inbox_page.dart';
import 'package:pst1/Screens/reply_mail.dart';
import 'package:pst1/Styles/app_colors.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../models/mail.dart';
import '../providers/db.dart';

class SearchPage extends StatefulWidget {
  dynamic accId;
  dynamic portNo;
  dynamic smtp;
  dynamic pswd;
  dynamic accMail;
  SearchPage(
      {Key? key,
      required this.accId,
      required this.accMail,
      required this.portNo,
      required this.smtp,
      required this.pswd})
      : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController? _searchController = TextEditingController();

  String selection = "Select All";
  int c = 0;
  bool menu = false;
  late DBHandler db;
  void _printData(String fname, int accId) async {
    mails = await db.getData(fname, accId);
    print(mails);
    print('Printing..Mails..');
    mails.forEach(((element) => print('${element.body}  ${element.fid}')));
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

  void moveEmails(String fid) {
    List<Email> selectEmail =
        mails.where((element) => element.Selected).toList();
    mails.removeWhere((element) => element.Selected);
    for (var element in selectEmail) {
      db.UpdateEmail(int.parse(fid), element.mid);
    }
    setState(() {});
  }

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
          _printData('"Inbox"', widget.accId);
          print(db);
          print('Outside loop');
          setState(() {});
        });
      }
    });
  }

  @override
  void initState() {
    final timer = Timer(
      const Duration(milliseconds: 300),
      () {
        // Navigate to your favorite place
        handleTimeout();
        super.initState();
      },
    );
  }

  List<Email> mailsOnSearch = [];
  List<Email> mails = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search Page'),
          centerTitle: true,
          backgroundColor: AppColors.lightblueshade,
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
                                  moveEmails("4");
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
                                  child: GestureDetector(
                                onTap: () {
                                  selection == "Select All"
                                      ? setState(() {
                                          for (int i = 0;
                                              i < mails.length;
                                              i++) {
                                            mails[i].Selected = true;
                                            mails[i].color = false;
                                          }
                                          selection = "Deselect All";
                                        })
                                      : setState(() {
                                          for (int i = 0;
                                              i < mails.length;
                                              i++) {
                                            mails[i].Selected = false;
                                            mails[i].color = true;
                                          }
                                          selection = "Select All";
                                        });
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.move_to_inbox,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(selection)
                                  ],
                                ),
                              )),
                            ],
                        child: const Icon(Icons.more_vert)),
                  )
                : Container(),
          ],
          // leading: IconButton(icon: Icon(Icons.fiber_new,),onPressed: (){},),
        ),
        bottomNavigationBar: ConvexAppBar(
            items: const [
              TabItem(icon: Icons.email),

              TabItem(
                icon: Icons.search,
              ),
              // TabItem(icon: Icons.message, title: 'Message'),
            ],
            initialActiveIndex: 1, //optional, default as 0
            elevation: 10,
            onTap: (int i) {
              if (i == 0) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InboxPage(
                              db: db,
                              accId: widget.accId,
                              accmail: widget.accMail,
                              portNo: widget.portNo,
                              smtp: widget.smtp,
                              pswd: widget.pswd,
                            )));
              } else if (i == 1) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(
                              accId: widget.accId,
                              accMail: widget.accMail,
                              smtp: widget.smtp,
                              portNo: widget.portNo,
                              pswd: widget.pswd,
                            )));
              }
            }),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      mailsOnSearch = mails
                          .where((element) =>
                              element.subject.contains(value) ||
                              element.subject
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element.body.contains(value) ||
                              element.body
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element.sender
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  controller: _searchController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: "Search Mail",
                  ),
                ),
              ),
              if (_searchController!.text.isNotEmpty && mailsOnSearch.isEmpty)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.search_off_outlined,
                        size: 50,
                        color: AppColors.blue,
                      ),
                      Text("no result found!"),
                    ],
                  ),
                )
              else
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _searchController!.text.isNotEmpty
                        ? mailsOnSearch.length
                        : mails.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReplyMail(
                                    mid: mails[index].mid,
                                    fid: mails[index].fid,
                                    subject: mails[index].subject,
                                    body: mails[index].body,
                                    sender: mails[index].sender,
                                    accId: widget.accId,
                                    accMail: widget.accMail,
                                    portNo: widget.portNo,
                                    smtpServer: widget.smtp,
                                    pswd: widget.pswd,
                                  )));
                        },
                        key: Key(mails[index].mid.toString()),
                        splashColor: Colors.blue,
                        onLongPress: () {
                          setState(() {
                            mails[index].color = !mails[index].color;
                            mails[index].Selected = !mails[index].Selected;
                            if (mails[index].Selected == true) {
                              c++;
                              menu = true;
                            } else {
                              c--;
                              if (c == 0) menu = false;
                            }
                          });
                        },
                        child: Card(
                          color: mails[index].color
                              ? Colors.white
                              : Colors.blueAccent,
                          elevation: 1,
                          child: ListTile(
                            leading: CircleAvatar(
                              child: mails[index].Selected
                                  ? const Icon(Icons.done)
                                  : Text(mails[index].subject[0]),
                            ),
                            title: Text(_searchController!.text.isNotEmpty
                                ? '${mailsOnSearch[index].subject}  } '
                                : '${mails[index].subject}    ${mails[index].accountId} '),
                            // subtitle: Text(
                            //   _searchController!.text.isNotEmpty
                            //       ? mailsOnSearch[index].body
                            //       : mails[index].body,
                            //   style: const TextStyle(
                            //     fontSize: 12,
                            //   ),
                            // ),
                            trailing: const Icon(Icons.star_border_outlined),
                          ),
                        ),
                      );
                    })),
            ]),
          ),
        ));
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
            //    db.insertActionData(db, "mail", "move", "Drafts", , TDatetime);
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
