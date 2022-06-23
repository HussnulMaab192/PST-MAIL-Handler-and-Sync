// ignore_for_file: unnecessary_string_interpolations

import 'dart:async';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pst1/Screens/compose.dart';
import 'package:pst1/Screens/globalVariables.dart';
import 'package:pst1/Screens/reply_mail.dart';
import 'package:pst1/Screens/textFieldBuilder.dart';
import 'package:pst1/Styles/app_colors.dart';
import 'package:pst1/Widgets/ButtonClass.dart';
import 'package:pst1/Widgets/widgets_drawer_coding.dart';
import 'package:pst1/models/folder.dart';
import 'package:pst1/models/folder_details.dart';
import '../HelperClasses/folder_details.dart';
import '../models/mail.dart';
import '../providers/db.dart';
import 'FirstTimeScreens/registered_account.dart';
import 'SearchPage.dart';
import 'global_accounts.dart';

class InboxPage extends StatefulWidget {
  DBHandler? db;
  static List<FolderDetail> finfo = [];
  List<FolderDetails> currentFinfo = [];
  dynamic accId;
  dynamic accmail;
  InboxPage({Key? key, this.db, required this.accId, this.accmail})
      : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  TextEditingController folderController = TextEditingController();
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
          _printData(0, widget.accId ?? 1);
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
      setState(() {});
      super.initState();
    }

    t = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      handleTimeout();
    });
  }

  void _printData(int fid, int accId) async {
    mails = await widget.db!.getData(fid, accId);
    print(mails);
    print('Printing..Mails..');
    mails.forEach(((element) {
      print('${element.body}  ${element.fid} ${element.accountId}');
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
      db.UpdateEmail(int.parse(fid), element.mid); // yh move ho raha hai
      await db.insertActionData(
          "mail", "move", "${element.fid.toString()}", "$fid", DateTime.now());
      print("Done moveEmail in inbox ");
    }

    setState(() {});
  }

  void delete() {
    List<Email> selectEmail =
        mails.where((element) => element.Selected).toList();
    mails.removeWhere((element) => element.Selected);
    for (var element in selectEmail) {
      db.deleteMail(element.mid);
      db.insertActionData(
          "mail", "delete", element.fid.toString(), "", DateTime.now());
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
                    builder: (context) => const RegisteredAccounts()));
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
                                //  showDialog(
                                //   context: context,
                                //   builder: (con) {
                                //     return AlertDialog(
                                //       title: const Text(
                                //           'Data is inserted...'),
                                //       actions: [
                                //         TextButton(
                                //             onPressed: () {
                                //               FolderDetail fd =
                                //                   FolderDetail();
                                //               fd.name =
                                //                   folderController
                                //                       .text;
                                //               children[i]
                                //                   .childrens
                                //                   .add(fd);

                                //               Navigator.of(
                                //                       context)
                                //                   .pop();
                                //             },
                                //             child: const Text(
                                //                 'OK'))
                                //       ],
                                //     );
                                //   });
                              },
                              child: const Text("Create"))
                        ],
                      );
                    });
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
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Compose()))),
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
                                title: Text(
                                    '${mails[index].subject}   ${mails[index].fid} '),
                                subtitle: Text(
                                  mails[index].body,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
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

  createNewFolder(BuildContext context, int parent, int folderid) {
    AlertDialog alert = AlertDialog(
        backgroundColor: AppColors.lightblueshade,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Container(
          child: Column(children: [
            const Text("Enter name of Folder"),
            TextFormField(
              controller: folderController,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 250,
              child: ButtonClass(
                  title: "Create",
                  background: AppColors.blue,
                  onTap: () {
                    db.insertData(
                        folderid, folderController.text.toString(), 2, parent);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InboxPage(
                                  db: widget.db,
                                  accId: widget.accId,
                                )));
                  }),
            )
          ]),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
