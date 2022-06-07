import 'dart:async';
import 'dart:ffi';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pst1/Screens/Compose.dart';
import 'package:pst1/Screens/Tree.dart';
import 'package:pst1/Screens/reply_mail.dart';
import 'package:pst1/Screens/selectServer.dart';
import 'package:pst1/Styles/app_colors.dart';
import 'package:pst1/Widgets/ButtonClass.dart';
import 'package:pst1/Widgets/Drawer/DrawerScreens/Archive.dart';
import 'package:pst1/Widgets/Drawer/DrawerScreens/Drafts.dart';
import 'package:pst1/Widgets/Drawer/DrawerScreens/Junk.dart';
import 'package:pst1/Widgets/Drawer/DrawerScreens/Settings.dart';
import 'package:pst1/Widgets/Drawer/DrawerScreens/deleted.dart';
import 'package:pst1/Widgets/Drawer/DrawerScreens/sent.dart';
import 'package:pst1/models/folder.dart';
import '../Widgets/Drawer/DrawerScreens/Settings.dart';
import '../models/Mail.dart';
import '../providers/Db.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'SearchPage.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  TextEditingController folderController = TextEditingController();
  late int accId;
  late int folderId;
  late String folderName;

  late String parentFolder;
  String selection = "Select All";
  bool menu = false;
  List<Email> mails = [];
  List<Email> selectedMails = [];
  List<DropBoxFolders> dbf = [];
  // List<Map<String, dynamic>> _foundUsers = [];
  late DBHandler db;
  int c = 0;
  Color starColor = Colors.white;
  Timer? t;
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
          if (db.getDB() == null) {
            print('returning... ');
            return;
          }
          print('Ini...');
          _printData(0);
          print(db);
          print('Outside loop');
          db.GetFolder().then((value) {
            dbf = value;
            print('Folders ;;;;');
            print(dbf);
            print('Length ' + dbf.length.toString());
            dbf.forEach((element) {
              print(element.name);
              print(element.childfodlers);
            });
            setState(() {});
          });
          initData();
        });
      }

      t!.cancel();
    });
  }

  void initState() {
    t = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      handleTimeout();
    });
    // final timer = Timer(
    //   const Duration(milliseconds: 300),
    //   () {
    //     // Navigate to your favorite place
    //     handleTimeout();
    //   },
    // );
  }

  void _printData(int fid) async {
    mails = await db.getData(fid);
    print(mails);
    print('Printing..Mails..');
    mails.forEach(((element) => print('${element.body}  ${element.fid}')));
    setState(() {});
  }

  Future<String> initData() async {
    folderId = (await db.getNextid("folder"));
    return folderId.toString();
  }

  void moveEmails(String fid) {
    List<Email> selectEmail =
        mails.where((element) => element.Selected).toList();
    mails.removeWhere((element) => element.Selected);
    for (var element in selectEmail) {
      db.UpdateEmail(int.parse(fid), element.mid);
      db.insertActionData(
          "mail", "move", "${element.fid.toString()}", "$fid", DateTime.now());
    }

    //db.insertAccountData("mail","mail","move","$fid");
    setState(() {});
  }

  void delete() {
    List<Email> selectEmail =
        mails.where((element) => element.Selected).toList();
    mails.removeWhere((element) => element.Selected);
    for (var element in selectEmail) {
      db.deleteMail(element.mid);
      db.insertActionData(
          "mail", "delete", "${element.fid.toString()}", "", DateTime.now());
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
                {
                  //parentFolder = dbf[i].name!;
                  createNewFolder(context, parentFolder, folderId);
                }
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
          title: const Text('Inbox'),
          backgroundColor: AppColors.lightblueshade,
          // leading: IconButton(icon: Icon(Icons.fiber_new,),onPressed: (){},),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.amberAccent,
                    child: Text('PST'),
                  ),
                  accountName: Text("PST MAIL HANDLER"),
                  accountEmail: Text("pst@gmail.com")),
              /* ExpansionTile(
              title: Text("Folder"),
              children: [
                ExpansionTile(
                  title: Text("Folder 1.1"),
                  children: [
                    ExpansionTile(
                      title: Text("Folder 1.1"),
                      children: [],
                    )
                  ],
                )
              ],
            ),*/
              for (int i = 0; i < dbf.length; i++)
                Row(
                  children: [
                    Expanded(child: Folders(dbf[i])),
                    IconButton(
                      //    onPressed: () {},
                      onPressed: () {
                        // folderId = 77777;
                        folderName = folderController.text.toString();
                        //   folderName = "My friendz";

                        //  accId = 1;
                        parentFolder = dbf[i].name!;
                        createNewFolder(context, parentFolder, folderId);
                        //errorlenz
                        //   db.insertData(777, folderName, accId, parentFolder);
                        //Pop up Folder
                        // insert DB
                        // Parent folder dbf[i].name
                        // folder name extract from popup menu
                        // insert into fodler table
                        print(dbf[i].name);
                      },

                      icon: const Icon(Icons.create_new_folder),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ],
                ),
              GestureDetector(
                // child: treee,
                child: const ListTile(
                  title: Text('Folders'),
                  leading: Icon(
                    Icons.folder_copy,
                    color: AppColors.lightblue,
                  ),
                ),
              ),
              ListTile(
                  title: const Text('Inbox'),
                  leading: IconButton(
                    // Icons.move_to_inbox_sharp,
                    color: AppColors.lightblueshade,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const InboxPage()));
                    },
                    icon: const Icon(Icons.move_to_inbox),
                  )),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Drafts())),
                child: ListTile(
                  title: const Text('Drafts'),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Drafts()));
                    },
                    icon: const Icon(
                      Icons.drive_file_rename_outline_outlined,
                    ),
                    color: AppColors.lightblue,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Archive())),
                child: ListTile(
                  title: const Text('Archive'),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Archive()));
                    },
                    icon: const Icon(
                      Icons.archive_outlined,
                    ),
                    color: AppColors.lightblue,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Sent())),
                child: ListTile(
                  title: const Text('Sent'),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Sent()));
                    },
                    icon: const Icon(
                      Icons.send,
                    ),
                    color: AppColors.lightblue,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Delete())),
                child: ListTile(
                  title: const Text('Deleted'),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Delete()));
                    },
                    icon: const Icon(
                      Icons.delete_sweep_outlined,
                    ),
                    color: AppColors.lightblue,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Junk())),
                child: ListTile(
                    title: const Text('Junk'),
                    leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Junk()));
                      },
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                      ),
                      color: AppColors.lightblue,
                    )),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Settings())),
                child: ListTile(
                  title: const Text('Settings'),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Settings()));
                    },
                    icon: const Icon(
                      Icons.settings,
                    ),
                    color: AppColors.lightblue,
                  ),
                ),
              ),
            ],
          ),
        ),
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
              // TabItem(icon: Icons.map, title: 'Discovery'),
              TabItem(
                icon: Icons.search,
              ),
              // TabItem(icon: Icons.message, title: 'Message'),
            ],
            initialActiveIndex: 0, //optional, default as 0
            elevation: 10,
            onTap: (int i) {
              if (i == 0) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const InboxPage()));
              } else if (i == 1) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
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
                        // scrollDirection: Axis.vertical,
                        //shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
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
                                trailing: Icon(
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

  createNewFolder(
    BuildContext context,
    String parent,
    int folderid,
  ) {
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
                        folderid, folderController.text.toString(), 1, parent);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InboxPage()));
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

  // Widget folderM(DropBoxFolders folder) {
  //   return ExpansionTile(
  //     title: Text(folder.name ?? ""),
  //     children: [
  //       for (int i = 0; i < folder.childfodlers.length; i++) folderM(folder)
  //     ],
  //   );
  // }

  //   Widget folderWidget(List<DropBoxFolders> folder,int index) {
  //   return ExpansionTile(
  //     title: Text(folder[index].name ?? ""),

  //     children: [
  //       for (int i = 0; i < folder[index].childfodlers.length;i++)
  //              ExpansionTile(title:Text( folder[index].childfodlers[i]. ?? ""),)

  //     ],
  //   );
  // }

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
            leading: const Icon(Icons.drafts_outlined),
            title: const Text("Drafts"),
          ),
        ),
        InkWell(
          onTap: () {
            moveEmails("2");
          },
          child: const ListTile(
              leading: const Icon(Icons.archive_outlined),
              title: const Text("Archive")),
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
              leading: const Icon(Icons.delete_outlined),
              title: const Text("Delete")),
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

  Widget Folders(DropBoxFolders f) {
    return ExpansionTile(
      title: Text(f.name ?? ""),
      children: [
        for (int i = 0; i < f.childfodlers.length; i++)
          Row(
            children: [
              Expanded(child: ExpansionTile(title: Text(f.childfodlers[i]))),
              Expanded(
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.create_new_folder)),
              ),
            ],
          ),
      ],
    );
  }
}
