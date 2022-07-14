import 'package:flutter/material.dart';
import 'package:pst1/Screens/popup.dart';
import 'package:pst1/Screens/textFieldBuilder.dart';
import '../Styles/app_colors.dart';
import '../models/action.dart';
import '../models/mail.dart';
import '../providers/Db.dart';
import 'FirstTimeScreens/registered_account.dart';
import 'inbox_page.dart';

class GeneralScreen extends StatefulWidget {
  int id;
  String name;
  GeneralScreen({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  TextEditingController folderController = TextEditingController();
  bool menu = false;
  List<Email> mails = [];
  String selection = "Select All";

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
                                  10000, folderController.text, 1, -1);
                              EAction a = EAction(
                                  action_type: "Folder",
                                  action_value: "create",
                                  source_field: "",
                                  destination_field: "destination_field",
                                  TDatetime: DateTime.now(),
                                  object_id: 0);
                              // not known;
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
          menu == true ? showMenubutton() : Container(),
        ],
        title: Text(widget.name),
        backgroundColor: AppColors.lightblueshade,
      ),
    );
  }

  Widget showMenubutton() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: PopupMenuButton(
          itemBuilder: (context) => [
                PopupMenuItem(
                    child: GestureDetector(
                  onTap: (() {
                    List<Email> selectEmail =
                        mails.where((element) => element.Selected).toList();
                    mails.removeWhere((element) => element.Selected);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PopupDislpay.con(
                              fdetail: InboxPage.finfo,
                              index: -1,
                              isMail: true,
                              selected: selectEmail,
                            )));

                    for (var element in selectEmail) {
                      print("selected mail id is:${element.mid}");

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PopupDislpay.con(
                                fdetail: InboxPage.finfo,
                                index: element.mid,
                                isMail: true,
                                selected: [],
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
                    // moveEmails("4");
                    // delete();
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
                            for (int i = 0; i < mails.length; i++) {
                              mails[i].Selected = true;
                              mails[i].color = false;
                            }
                            selection = "Unselect All";
                          })
                        : setState(() {
                            for (int i = 0; i < mails.length; i++) {
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
    );
  }
}
