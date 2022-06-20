import 'package:flutter/material.dart';

import '../HelperClasses/folder_details.dart';

class PopupDislpay extends StatefulWidget {
  List<FolderDetail> fdetail = [];
  PopupDislpay({Key? key, required this.fdetail}) : super(key: key);

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
          child: Expanded(
            child: Column(
              children: [
                for (int i = 0; i < widget.fdetail.length; i++)
                  ExpansionTile(
                    leading: const Icon(Icons.folder),
                    title: Text(widget.fdetail[i].name),
                    children:
                        getChildHirerachy(widget.fdetail[i].childrens, context),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getChildHirerachy(
      List<FolderDetail> children, BuildContext context) {
    List<Widget> exp = [];
    List<Widget> emplist = [];
    if (children.isEmpty) return emplist;

    for (int i = 0; i < children.length; i++) {
      print('Printintig....' + children[i].name);
      exp.add(
        ExpansionTile(
          leading: const Icon(Icons.folder_copy_outlined),
          title: Text(children[i].name),
          children: getChildHirerachy(children[i].childrens, context),
          trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                print("before alert");
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (cnt) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () {
                                //  Navigator.of(context).pop();
                                print("Inside pop create");
                              },
                              child: const Text("create")),
                          TextButton(
                              onPressed: () {
                                print("Inside pop Move");
                              },
                              child: const Text("Move")),
                          TextButton(
                              onPressed: () {
                                print("Inside pop delete");
                              
                              },
                              child: const Text("Delete")),
                        ],
                      );
                    });
              }),
        ),
      );
    }
    print('exp:::');
    print(exp);
    List<Widget> ep = [];
    ep.addAll(exp);
    exp.clear();
    return ep;
  }

  ////
}
