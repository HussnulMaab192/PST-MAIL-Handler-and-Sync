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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  // ListView.builder(
                  //     itemCount: widget.fdetail.length,
                  //     itemBuilder: ((context, index) {
                  //       return Expanded(
                  //         child: ExpansionTile(
                  //           title: Text(widget.fdetail[index].name),
                  //           children: getChildHirerachy(
                  //               widget.fdetail[index].childrens, context),
                  //         ),
                  //       );
                  //     }))
                  for (int i = 0; i < widget.fdetail.length; i++)
                    Expanded(
                      child: ExpansionTile(
                        title: Text(widget.fdetail[i].name),
                        children: getChildHirerachy(
                            widget.fdetail[i].childrens, context),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

////
  ///
  List<Widget> getChildHirerachy(
      List<FolderDetail> children, BuildContext context) {
    List<Widget> exp = [];
    List<Widget> emplist = [];
    if (children.isEmpty) return emplist;

    for (int i = 0; i < children.length; i++) {
      print('Printintig....' + children[i].name);
      exp.add(
        ExpansionTile(
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
                                Navigator.of(context).pop();
                              },
                              child: const Text("create")),
                          TextButton(
                              onPressed: () {}, child: const Text("Move")),
                          TextButton(
                              onPressed: () {}, child: const Text("Delete")),
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
