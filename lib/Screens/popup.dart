import 'package:flutter/material.dart';
import 'package:pst1/models/action.dart';
import 'package:pst1/models/mail.dart';
import 'package:pst1/providers/db.dart';

import '../HelperClasses/folder_details.dart';
import '../HelperClasses/my_widget_drawer.dart';

class PopupDislpay extends StatefulWidget {
  List<FolderDetail> fdetail = [];
  List<Email> selected = [];
  dynamic index;
  bool? isMail;
  PopupDislpay({Key? key, required this.fdetail}) : super(key: key);
  PopupDislpay.moveMails();
  PopupDislpay.con(
      {Key? key,
      required this.fdetail,
      required this.index,
      required this.isMail,
      required this.selected})
      : super(key: key);

  @override
  State<PopupDislpay> createState() => _PopupDislpayState();
}

class _PopupDislpayState extends State<PopupDislpay> {
  @override
  Widget build(BuildContext context) {
    print('Inside Pop Up Display');
    return MaterialApp(
      home: widget.isMail == false
          ? Scaffold(
              appBar: AppBar(
                title: const Text("Move Folder "),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < widget.fdetail.length; i++)
                      ExpansionTile(
                        leading: IconButton(
                            onPressed: () async {
                              // this is due
                              print('before calling ids are');
                              print('from :' + widget.index!.toString());
                              print('to :' +
                                  widget.fdetail[i].id.toString() +
                                  widget.fdetail[i].name.toString());
                              DBHandler db = await DBHandler.getInstnace();
                              db.UpdateFolder(
                                  widget.index!, widget.fdetail[i].id);

                              EAction a = EAction(
                                  action_type: "folder",
                                  action_value: "move",
                                  source_field:
                                      widget.fdetail[i].fid.toString(),
                                  destination_field:
                                      widget.fdetail[i].id.toString(),
                                  TDatetime: DateTime.now(),
                                  object_id: widget.index!);
                              await db.insertActionData(a);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Folder moved"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("ok"),
                                        ),
                                      ],
                                    );
                                  });

                              setState(() {});
                            },
                            icon: const Icon(Icons.folder_special)),
                        title: Text(widget.fdetail[i].name),
                        children: getChildHirerachy(widget.fdetail[i].childrens,
                            context, widget.index!),
                      ),
                  ],
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text("Move Mail "),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < widget.fdetail.length; i++)
                      ExpansionTile(
                        leading: IconButton(
                            onPressed: () async {
                              // this is due
                              print('before calling ids are');
                              print('to :' +
                                  widget.fdetail[i].id.toString() +
                                  widget.fdetail[i].name.toString());
                              if (widget.index == -1) {
                                for (int i = 0;
                                    i < widget.selected.length;
                                    i++) {
                                  DBHandler db = await DBHandler.getInstnace();
                                  db.UpdateEmail(
                                      widget.fdetail[i].id, widget.index!);
                                  EAction a = EAction(
                                      action_type: "Email",
                                      action_value: "move",
                                      source_field:
                                          widget.fdetail[i].fid.toString(),
                                      destination_field:
                                          widget.fdetail[i].id.toString(),
                                      TDatetime: DateTime.now(),
                                      object_id: widget.index!);

                                  await db.insertActionData(a);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Email has been moved"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("ok"),
                                            ),
                                          ],
                                        );
                                      });

                                  setState(() {});
                                }
                              }
                              DBHandler db = await DBHandler.getInstnace();
                              db.UpdateEmail(
                                  widget.fdetail[i].id, widget.index!);
                              EAction a = EAction(
                                  action_type: "Email",
                                  action_value: "move",
                                  source_field:
                                      widget.fdetail[i].fid.toString(),
                                  destination_field:
                                      widget.fdetail[i].id.toString(),
                                  TDatetime: DateTime.now(),
                                  object_id: widget.index!);

                              await db.insertActionData(a);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Email has been moved"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("ok"),
                                        ),
                                      ],
                                    );
                                  });

                              setState(() {});
                            },
                            icon: const Icon(Icons.folder_special)),
                        title: Text(widget.fdetail[i].name),
                        children: getChildHirerachy(widget.fdetail[i].childrens,
                            context, widget.index!),
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
