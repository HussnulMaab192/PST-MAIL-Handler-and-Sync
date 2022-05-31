import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pst1/Screens/InboxPage.dart';
import 'package:pst1/Styles/app_colors.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../models/Mail.dart';
import '../providers/Db.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController? _searchController = TextEditingController();
  List<Map<String, dynamic>> _foundUsers = [];
  String selection = "Select All";
  int c = 0;
  bool menu = false;
  late DBHandler db;
  void _printData(int fid) async {
    mails = await db.getData(fid);
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
          _printData(0);
          print(db);
          print('Outside loop');
          setState(() {});
        });
      }
    });
  }

  void initState() {
    _foundUsers = mails.cast<Map<String, dynamic>>();

    final timer = Timer(
      const Duration(milliseconds: 300),
      () {
        // Navigate to your favorite place
        handleTimeout();
      },
    );
  }

  // void runFilter(String enteredKeyword) {
  //   List<Map<String, dynamic>> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     results = mails.cast<Map<String, dynamic>>();
  //   } else {
  //     results = mails
  //         .where((mails) => mails.subject
  //             .toLowerCase()
  //             .contains(enteredKeyword.toLowerCase()))
  //         .cast<Map<String, dynamic>>()
  //         .toList();
  //   }
  //   setState(() {
  //     _foundUsers = results;
  //   });
  // }

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
                                  children: [
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
                                  children: [
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
                                children: [
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
                                    Icon(
                                      Icons.move_to_inbox,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(selection)
                                  ],
                                ),
                              )),
                            ],
                        child: Icon(Icons.more_vert)),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const InboxPage()));
              } else if (i == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
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
                      mails = mails
                          .where((element) => element.subject.contains(value))
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

              ListView.builder(
                  scrollDirection: Axis.vertical,
                  // scrollDirection: Axis.vertical,
                  shrinkWrap: true,
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
                          trailing: Icon(Icons.star_border_outlined),
                        ),
                      ),
                    );
                  })),

              // body: Center(
              //   child: Stack(
              //     children: [
              //       Container(
              //         padding: const EdgeInsets.all(10),
              //         child: TextFormField(
              //           onChanged: (value) => runFilter(value),
              //           decoration: InputDecoration(
              //             prefixIcon: const Icon(Icons.search),
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(15),
              //             ),
              //             hintText: 'Mails,Events,Contacts',
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: _foundUsers.isNotEmpty
              //             ? ListView.builder(
              //                 scrollDirection: Axis.vertical,
              //                 // scrollDirection: Axis.vertical,
              //                 // shrinkWrap: true,
              //                 // physics: const NeverScrollableScrollPhysics(),
              //                 itemCount: _foundUsers.length,
              //                 itemBuilder: ((context, index) {
              //                   return InkWell(
              //                     key: ValueKey(_foundUsers[index]["mid"]),
              //                     splashColor: Colors.blue,
              //                     onLongPress: () {
              //                       setState(() {
              //                         // mails[index].color = !mails[index].color;
              //                         // mails[index].Selected =
              //                         //     !mails[index].Selected;
              //                         // if (mails[index].Selected == true) {
              //                         //   menu = true;
              //                         // } else {
              //                         //   menu = false;
              //                         // }
              //                       });
              //                       //  menu = false;
              //                     },
              //                     child: Card(
              //                       color: mails[index].color
              //                           ? Colors.white
              //                           : Colors.blueAccent,
              //                       elevation: 1,
              //                       child: ListTile(
              //                         leading: CircleAvatar(
              //                           child: _foundUsers[index]["Selected"]
              //                               ? const Icon(Icons.done)
              //                               : Text(_foundUsers[index]["subject"][0]),
              //                         ),
              //                         title: Text(
              //                             '${_foundUsers[index]["subject"]}   ${_foundUsers[index]["fid"]}'),
              //                         subtitle: Text(
              //                           _foundUsers[index]["body"],
              //                           style: const TextStyle(
              //                             fontSize: 12,
              //                           ),
              //                         ),
              //                         trailing: Icon(Icons.star_border_outlined),
              //                       ),
              //                     ),
              //                   );
              //                 }))
              //             : const Text(
              //                 'No results found',
              //                 style: TextStyle(fontSize: 24),
              //               ),
              //       )
              //     ],
              //   ),
              // )
            ]),
          ),
        ));
  }

  Widget bottomSheet() {
    return Container(
      height: 280.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        InkWell(
          onTap: () {
            moveEmails("1");
            //    db.insertActionData(db, "mail", "move", "Drafts", , TDatetime);
          },
          child: ListTile(
            leading: Icon(Icons.drafts_outlined),
            title: Text("Drafts"),
          ),
        ),
        InkWell(
          onTap: () {
            moveEmails("2");
          },
          child: ListTile(
              leading: Icon(Icons.archive_outlined), title: Text("Archive")),
        ),
        InkWell(
            onTap: () {
              moveEmails("3");
            },
            child: ListTile(
                leading: Icon(Icons.send_outlined), title: Text("Send"))),
        InkWell(
          onTap: () {
            moveEmails("4");
          },
          child: ListTile(
              leading: Icon(Icons.delete_outlined), title: Text("Delete")),
        ),
        InkWell(
          onTap: () {
            moveEmails("5");
          },
          child: ListTile(
              leading: Icon(Icons.delete_forever_rounded), title: Text("junk")),
        ),
      ]),
    );
  }
}
