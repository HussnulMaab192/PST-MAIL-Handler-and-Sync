import 'package:flutter/material.dart';
import 'package:pst1/providers/db.dart';

import '../HelperClasses/folder_details.dart';
import '../HelperClasses/my_widget_drawer.dart';

class PopupDislpay extends StatefulWidget {
  List<FolderDetail> fdetail = [];
  int? index;
  PopupDislpay({Key? key, required this.fdetail}) : super(key: key);
  PopupDislpay.con({Key? key, required this.fdetail, required this.index})
      : super(key: key);

  @override
  State<PopupDislpay> createState() => _PopupDislpayState();
}

class _PopupDislpayState extends State<PopupDislpay> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                        print('to :' + widget.fdetail[i].id.toString());
                        DBHandler db = await DBHandler.getInstnace();
                        db.UpdateFolder(widget.index!, widget.fdetail[i].id);
                        // print(
                        //     "Folder ${InboxPage.finfo[widget.index!].name}  moved to  ${InboxPage.finfo[i].name}");

                        // print(
                        //     "Folder ${widget.fdetail[widget.index!].name}  moved to  ${widget.fdetail[i].name}");
                        // EAction a = EAction("folder", "move", widget.index, widget.fdetail[i].id, DateTime.now(), object_id)
                        //  await db.insertActionData
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Folder moved "),
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
                  children: getChildHirerachy(
                      widget.fdetail[i].childrens, context, widget.index!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
