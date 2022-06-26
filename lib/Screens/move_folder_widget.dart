// import 'package:flutter/material.dart';
// import 'package:pst1/Screens/inbox_page.dart';
// import 'package:pst1/Screens/popup.dart';
// import 'package:pst1/providers/Db.dart';

// import '../HelperClasses/folder_details.dart';
// import '../HelperClasses/my_widget_drawer.dart';

// class MoveFolderWidget extends StatefulWidget {
//   FolderDetail folder;
//   List<FolderDetail> children;
//   int index;
//   MoveFolderWidget({
//     Key? key,
//     required this.folder,
//     required this.index,
//     required this.children,
//   }) : super(key: key);

//   @override
//   State<MoveFolderWidget> createState() => _MoveFolderWidgetState();
// }

// class _MoveFolderWidgetState extends State<MoveFolderWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       leading: const Icon(Icons.folder),
//       title: Text(widget.children[widget.index].name),
//       children:
//           getChildHirerachy(widget.children[widget.index].childrens, context),
//       trailing: IconButton(
//           icon: const Icon(Icons.more_vert),
//           onPressed: () {
//             print("before alert");
//             showDialog(
//                 barrierDismissible: false,
//                 context: context,
//                 builder: (cnt) {
//                   return AlertDialog(
//                     actions: [
//                       TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             showDialog(
//                                 context: context,
//                                 builder: (cont) {
//                                   TextEditingController controller =
//                                       TextEditingController();
//                                   return AlertDialog(
//                                     actions: [
//                                       const Center(child: Text("Enter name ")),
//                                       TextField(
//                                         controller: controller,
//                                       ),
//                                       TextButton(
//                                           onPressed: () async {
//                                             // yaha db main first time  null ata hai !
//                                             DBHandler db =
//                                                 await DBHandler.getInstnace();
//                                             await db.insertData(
//                                                 //    Sdab
//                                                 // yahan agr id auto ki jaay tu error resolve ho jay ga but
//                                                 // getNextId is not working for any other folder except accounts
//                                                 105,
//                                                 controller.text,
//                                                 1,
//                                                 widget
//                                                     .children[widget.index].id);
//                                             // await db.insertActionData(
//                                             //     "Folder",
//                                             //     "Create",
//                                             //     " ",//source field
//                                             //     "",// destination field
//                                             //     DateTime.now(),
//                                             //     //konsa folder create hoa hai?

//                                             //);
//                                             Navigator.of(context).pop();

//                                             showDialog(
//                                                 context: context,
//                                                 builder: (con) {
//                                                   return AlertDialog(
//                                                     title: const Text(
//                                                         'Data is inserted..'),
//                                                     actions: [
//                                                       TextButton(
//                                                           onPressed: () {
//                                                             FolderDetail fd =
//                                                                 FolderDetail();
//                                                             fd.name =
//                                                                 controller.text;
//                                                             widget
//                                                                 .children[widget
//                                                                     .index]
//                                                                 .childrens
//                                                                 .add(fd);

//                                                             Navigator.of(
//                                                                     context)
//                                                                 .pop();
//                                                           },
//                                                           child:
//                                                               const Text('OK'))
//                                                     ],
//                                                   );
//                                                 });
//                                           },
//                                           child: const Text("Create"))
//                                     ],
//                                   );
//                                 });
//                           },
//                           child: const Text("create")),
//                       TextButton(
//                           onPressed: () {
//                             //Navigator.of(context).pop();
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => PopupDislpay.con(
//                                       fdetail: InboxPage.finfo,
//                                       index: widget.index,
//                                     )));
//                             // showDialog(
//                             //     context: context,
//                             //     builder: (cont) {
//                             //       return StatefulBuilder(
//                             //           builder: (context, setState) {
//                             //         return

//                             //         //  PopupDislpay(
//                             //         //     fdetail: InboxPage.finfo);
//                             //         //  AlertDialog(
//                             //         //   title: PopupDislpay(fdetail: InboxPage.finfo),
//                             //         // );
//                             //       });
//                             //     });
//                           },
//                           child: const Text("Move")),
//                       TextButton(
//                           onPressed: () async {
//                             Navigator.of(context).pop();
//                             DBHandler db = await DBHandler.getInstnace();
//                             await db
//                                 .deleteFolder(widget.children[widget.index].id);
//                             Navigator.of(context).pop();
//                             showDialog(
//                                 context: context,
//                                 builder: (cont) {
//                                   return AlertDialog(
//                                     title: const Text('Folder Deleted..'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.of(context).pop();
//                                           },
//                                           child: const Text("ok"))
//                                     ],
//                                   );
//                                 });
//                           },
//                           child: const Text("Delete")),
//                     ],
//                   );
//                 });
//           }),
//     );
  
//   }
// }
