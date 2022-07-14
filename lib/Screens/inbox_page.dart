// ignore_for_file: unnecessary_string_interpolations

import 'dart:async';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pst1/Screens/compose.dart';
import 'package:pst1/Screens/globalVariables.dart';
import 'package:pst1/Screens/reply_mail.dart';
import 'package:pst1/Screens/textFieldBuilder.dart';
import 'package:pst1/Styles/app_colors.dart';
import 'package:pst1/Widgets/widgets_drawer_coding.dart';
import 'package:pst1/models/action.dart';
import 'package:pst1/models/folder.dart';
import 'package:pst1/models/folder_details.dart';
import '../HelperClasses/folder_details.dart';
import '../models/mail.dart';
import '../providers/db.dart';
import 'FirstTimeScreens/registered_account.dart';
import 'SearchPage.dart';
import 'global_accounts.dart';
import 'popup.dart';

class InboxPage extends StatefulWidget {
  DBHandler? db;
  static List<FolderDetail> finfo = [];
  List<FolderDetails> currentFinfo = [];
  dynamic accId;
  dynamic portNo;
  dynamic accmail;
  dynamic pswd;
  dynamic smtp;
  dynamic accType;
  InboxPage(
      {Key? key,
      this.db,
      required this.accId,
      this.accmail,
      this.pswd,
      this.smtp,
      this.portNo,
      //is waly  port no ki zroorat ni hai...iski jagah neechay mainy smtpPortNo adjust kr lya hai
      // yh sirf othersServers main kam aay ga!!!!
      this.accType})
      : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  TextEditingController folderController = TextEditingController();

  late int smtpPort;
  late int accId;
  late int folderId;
  late String folderName;
  late int parentFolder;
  String selection = "Select All";
  bool menu = false;
  List<Email> mails = [];
  List<Email> selectedMails = [];
  List<DropBoxFolders> dbf = [];

  late DBHandler db;
  int c = 0;
  Color starColor = Colors.white;
  Timer? t;

  void handleTimeout() {
    // callback function
    print('Inside handle time out.... ');
    DBHandler.getInstnace().then((value) {
      // ignore: unnecessary_null_comparison
      if (value == null) {
        print('Object not created...');
      } else {
        print('object created successfuly...');
        db = value;
        setState(() {
          if (db.getDB() == null) {
            print('returning... ');
            return;
          }
          print('Ini...');
          _printData('"Inbox"', widget.accId ?? 1);
          // fetchAccountData();
          // print(db);
          // print('Outside loop');
          // db.GetFolder().then((value) {
          //   mainFolders = value;
          //   dbf = mainFolders.where((e) => e.fid == -1).toList();
          //   print('Length ' + dbf.length.toString());
          //   setState(() {});
          // });
          // db.GetFoldersDetail().then((value) {
          //   foldersinfo = value;
          //   FolderDetail fdet = FolderDetail();
          //   List<FolderDetail> herichaywisefolders =
          //       fdet.getFolderHirerachy(foldersinfo);
          //   print(herichaywisefolders);
          // });
          //  initData();
        });
      }

      t!.cancel();
    });
  }

  List<DropBoxFolders> mainFolders = [];
  @override
  void initState() {
    print('Inside init state...');
    if (widget.db != null) {
      widget.db!.GetFoldersDetail().then((value) {
        foldersinfo = value;
        FolderDetail fdet = FolderDetail();
        List<FolderDetail> herichaywisefolders =
            fdet.getFolderHirerachy(foldersinfo);
        foldersinfo.clear();
        foldersinfo = herichaywisefolders;

        setState(() {
          InboxPage.finfo.clear();
          InboxPage.finfo.addAll(foldersinfo);
        });
      });
      // _printData(0, widget.accId ?? 1);
      fetchAccountData();
      initData();
      if (widget.accType == "gmail") {
        widget.smtp = 'smtp.gmail.com';
        smtpPort = 465;
      } else if (widget.accType == "outlook") {
        widget.smtp = 'smtp-mail.outlook.com';
        smtpPort = 587;
      } else if (widget.accType == "yahoo") {
        widget.smtp = 'smtp.mail.yahoo.com';
        smtpPort = 465;
      } else if (widget.accType == "others") {
        widget.smtp = 'smtp.${widget.accType}.com';
      }
      setState(() {});
      super.initState();
    }

    t = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      handleTimeout();
    });
  }

  void _printData(String fname, int accId) async {
    mails = await widget.db!.getData(fname, accId);
    print(mails);
    print('Printing..Mails..');
    mails.forEach(((element) {
      print('${element.body} ');
    }));
    setState(() {});
  }

  void fetchAccountData() async {
    GlobalList.accountsList = await widget.db!.selectAccountData();

    print('account list is in home ${GlobalList.accountsList}');

    print('Printing..Accounts..');
    GlobalList.accountsList!.forEach(
        ((element) => print('${element.acc_mail}  ${element.acc_type}')));

    setState(() {});
  }

  Future<String> initData() async {
    folderId = (await db.getNextid("folders"));
    return folderId.toString();
  }

  void moveEmails(String fid) async {
    List<Email> selectEmail =
        mails.where((element) => element.Selected).toList();
    mails.removeWhere((element) => element.Selected);
    for (var element in selectEmail) {
      db.UpdateEmail(int.parse(fid), element.mid);
      print("before action constructor  in inbox");
      EAction a = EAction(
          action_type: "mail",
          action_value: "move",
          source_field: "${element.fid.toString()}",
          destination_field: "$fid",
          TDatetime: DateTime.now(),
          object_id: element.mid);
      print("before action table in inbox for move table ");
      await db.insertActionData(a);
      print("after action table in inbox ");

      print("Done moveEmail in inbox ");
    }

    setState(() {});
  }

  void delete() async {
    List<Email> selectEmail =
        mails.where((element) => element.Selected).toList();
    mails.removeWhere((element) => element.Selected);
    for (var element in selectEmail) {
      db.deleteMail(element.mid);
      print("action cosntructor in delete table ");
      EAction a = EAction(
          action_type: "mail",
          action_value: "delete",
          source_field: "",
          destination_field: "",
          TDatetime: DateTime.now(),
          object_id: element.mid);
      await db.insertActionData(a);
      print("action after in delete table ");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            const SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegisteredAccounts()));
              },
              icon: const Icon(Icons.admin_panel_settings_outlined),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (cont) {
                      return AlertDialog(
                        title: const Text("Create Folder "),
                        actions: [
                          buildTextField(Icons.create_new_folder, "enter name",
                              false, false, folderController),
                          TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                DBHandler db = await DBHandler.getInstnace();
                                await db.insertData(
                                    107, folderController.text, 1, -1);
                                Navigator.of(context).pop();
                                showDialog(
                                    context: context,
                                    builder: (con) {
                                      return AlertDialog(
                                        title: Text(
                                            "${folderController.text} Folder created!"),
                                      );
                                    });
                              },
                              child: const Text("Create"))
                        ],
                      );
                    });

                EAction a = EAction(
                    action_type: "folder",
                    action_value: "create",
                    source_field: "source_field",
                    destination_field: "destination_field",
                    TDatetime: DateTime.now(),
                    object_id: 107);
              },
              icon: const Icon(Icons.create_new_folder),
            ),
            menu == true
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  child: GestureDetector(
                                onTap: (() {
                                  List<Email> selectEmail = mails
                                      .where((element) => element.Selected)
                                      .toList();
                                  mails.removeWhere(
                                      (element) => element.Selected);

                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => PopupDislpay.con(
                                  //           fdetail: InboxPage.finfo,
                                  //           index: -1,
                                  //           isMail: true,
                                  //           selected: selectEmail,
                                  //         )));

                                  for (var element in selectEmail) {
                                    print("selected mail id is:${element.mid}");

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PopupDislpay.con(
                                                  fdetail: InboxPage.finfo,
                                                  index: element.mid,
                                                  isMail: true,
                                                  selected: const [],
                                                )));
                                    setState(() {});
                                  }
                                }
                                    //192.168.176.177
                                    //  showModalBottomSheet(
                                    //       context: context,
                                    //       builder: ((builder) =>
                                    //      // bottomSheet()
                                    //       ),
                                    //     )

                                    ),
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
                                          selection = "Unselect All";
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
          title: const Text('Inbox'),
          backgroundColor: AppColors.lightblueshade,
        ),
        onDrawerChanged: (val) async {
          if (val) {
            //     await db.GetFolder();
          }
        },
        drawer: myDrawer(context, widget.accId ?? 1, widget.accmail),
        floatingActionButton: FloatingActionButton.extended(
            heroTag: "btn2",
            label: Row(
              children: const [
                Icon(
                  Icons.edit,
                ),
                Text('Compose')
              ],
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Compose(
                        sender: widget.accId,
                        portNo: smtpPort,
                        smtpServer: widget.smtp,
                        pswd: widget.pswd,
                        accMail: widget.accmail,
                        accId: widget.accId,
                      )));
          
            }),
        bottomNavigationBar: ConvexAppBar(
            items: const [
              TabItem(icon: Icons.email),
              TabItem(
                icon: Icons.search,
              ),
            ],
            initialActiveIndex: 0, //optional, default as 0
            elevation: 10,
            onTap: (int i) {
              if (i == 0) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InboxPage(
                              db: widget.db,
                              accId: widget.accId,
                            )));
              } else if (i == 1) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(
                              accId: widget.accId,
                              accMail: widget.accmail,
                              smtp: widget.smtp,
                              pswd: widget.pswd,
                              portNo: widget.portNo,
                            )));
              
              }
            }),
        body: FutureBuilder(
            future: initData(),
            builder: (
              BuildContext context,
              AsyncSnapshot<String> snapshot,
            ) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: mails.length,
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
                                        accMail: widget.accmail,
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
                              //  menu = false;
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
                                title: Text('${mails[index].subject} } '),
                                // subtitle: Text(
                                //   mails[index].body,
                                //   style: const TextStyle(
                                //     fontSize: 12,
                                //   ),
                                // ),
                                trailing: const Icon(
                                  Icons.star_border_outlined,
                                ),
                              ),
                            ),
                          );
                        })),
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }));
  }

  // Widget bottomSheet() {
  //   return Container(
  //     height: 280.0,
  //     width: MediaQuery.of(context).size.width,
  //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
  //     child:
  //         Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
  //       InkWell(
  //         onTap: () {
  //           moveEmails("1");
  //         },
  //         child: const ListTile(
  //           leading: Icon(Icons.drafts_outlined),
  //           title: Text("Drafts"),
  //         ),
  //       ),
  //       InkWell(
  //         onTap: () {
  //           moveEmails("2");
  //         },
  //         child: const ListTile(
  //             leading: Icon(Icons.archive_outlined), title: Text("Archive")),
  //       ),
  //       InkWell(
  //           onTap: () {
  //             moveEmails("3");
  //           },
  //           child: const ListTile(
  //               leading: Icon(Icons.send_outlined), title: Text("Send"))),
  //       InkWell(
  //         onTap: () {
  //           moveEmails("4");
  //         },
  //         child: const ListTile(
  //             leading: Icon(Icons.delete_outlined), title: Text("Delete")),
  //       ),
  //       InkWell(
  //         onTap: () {
  //           moveEmails("5");
  //         },
  //         child: const ListTile(
  //             leading: Icon(Icons.delete_forever_rounded), title: Text("junk")),
  //       ),
  //     ]),
  //   );
  // }

}
