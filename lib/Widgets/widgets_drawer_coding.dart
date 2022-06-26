import 'package:flutter/material.dart';
import 'package:pst1/Widgets/Drawer/DrawerScreens/Drafts.dart';
import 'package:pst1/providers/db.dart';

import '../HelperClasses/folder_details.dart';
import '../HelperClasses/my_widget_drawer.dart';
import '../Screens/globalVariables.dart';
import '../Screens/inbox_page.dart';
import '../Screens/popup.dart';
import '../Styles/app_colors.dart';
import 'Drawer/DrawerScreens/Archive.dart';
import 'Drawer/DrawerScreens/Junk.dart';
import 'Drawer/DrawerScreens/Settings.dart';
import 'Drawer/DrawerScreens/deleted.dart';
import 'Drawer/DrawerScreens/sent.dart';

Widget myDrawer(BuildContext context, int accId, final accmMail) {
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.amberAccent,
              child: Text('PST'),
            ),
            accountName: const Text("PST MAIL HANDLER"),
            accountEmail: Text("$accmMail")),
        for (int i = 0; i < foldersinfo.length; i++)
          foldersinfo[i].name == "inbox" ||
                  foldersinfo[i].name == "drafts" ||
                  foldersinfo[i].name == "Archieve" ||
                  foldersinfo[i].name == "sent" ||
                  foldersinfo[i].name == "deleted" ||
                  foldersinfo[i].name == "junk"
              ? Container()
              : Row(
                  children: [
                    Expanded(
                      child: ExpansionTile(
                          leading: const Icon(Icons.folder_special),
                          title: Text(foldersinfo[i].name),
                          children: getChildHirerachy(foldersinfo[i].childrens,
                              context, foldersinfo[i].id),
                          trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (cnt) {
                                      return AlertDialog(
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                showDialog(
                                                    context: context,
                                                    builder: (cont) {
                                                      TextEditingController
                                                          controller =
                                                          TextEditingController();
                                                      return AlertDialog(
                                                        actions: [
                                                          const Center(
                                                              child: Text(
                                                                  "Enter name ")),
                                                          TextField(
                                                            controller:
                                                                controller,
                                                          ),
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                DBHandler db =
                                                                    await DBHandler
                                                                        .getInstnace();
                                                                await db.insertData(
                                                                    //    Sdab
                                                                    // yahan agr id auto ki jaay tu error resolve ho jay ga but
                                                                    // getNextId is not working for any other folder except accounts
                                                                    105,
                                                                    controller.text,
                                                                    1,
                                                                    foldersinfo[i].id);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();

                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (con) {
                                                                      return AlertDialog(
                                                                        title: const Text(
                                                                            'Data is inserted..'),
                                                                        actions: [
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                FolderDetail fd = FolderDetail();
                                                                                fd.name = controller.text;
                                                                                foldersinfo[i].childrens.add(fd);

                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: const Text('OK'))
                                                                        ],
                                                                      );
                                                                    });
                                                              },
                                                              child: const Text(
                                                                  "Create"))
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: const Text("create")),
                                          TextButton(
                                              onPressed: () {
                                                //Navigator.of(context).pop();
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            // PopupDislpay(
                                                            //     fdetail: InboxPage
                                                            //         .finfo)

                                                            PopupDislpay.con(
                                                                fdetail:
                                                                    InboxPage
                                                                        .finfo,
                                                                index:
                                                                    foldersinfo[
                                                                            i]
                                                                        .id)));
                                              },
                                              child: const Text("Move")),
                                          TextButton(
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                                DBHandler db = await DBHandler
                                                    .getInstnace();
                                                await db.deleteFolder(
                                                    foldersinfo[i].id);
                                                Navigator.of(context).pop();
                                                showDialog(
                                                    context: context,
                                                    builder: (cont) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Folder Deleted..'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "ok"))
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: const Text("Delete")),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.more_vert))),
                    ),
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
              onPressed: () async {
                DBHandler db = await DBHandler.getInstnace();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => InboxPage(
                          db: db,
                          accId: accId,
                        )));
              },
              icon: const Icon(Icons.move_to_inbox),
            )),
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Drafts(
                    accId: accId,
                  ))),
          child: ListTile(
            title: const Text('Drafts'),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Drafts(
                          accId: accId,
                        )));
              },
              icon: const Icon(
                Icons.drive_file_rename_outline_outlined,
              ),
              color: AppColors.lightblue,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Archive(
                    accId: accId,
                  ))),
          child: ListTile(
            title: const Text('Archive'),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Archive(
                          accId: accId,
                        )));
              },
              icon: const Icon(
                Icons.archive_outlined,
              ),
              color: AppColors.lightblue,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Sent(
                    accId: accId,
                  ))),
          child: ListTile(
            title: const Text('Sent'),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Sent(
                          accId: accId,
                        )));
              },
              icon: const Icon(
                Icons.send,
              ),
              color: AppColors.lightblue,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Delete(
                    accId: accId,
                  ))),
          child: ListTile(
            title: const Text('Deleted'),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Delete(
                          accId: accId,
                        )));
              },
              icon: const Icon(
                Icons.delete_sweep_outlined,
              ),
              color: AppColors.lightblue,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Junk(
                    accId: accId,
                  ))),
          child: ListTile(
              title: const Text('Junk'),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Junk(
                            accId: accId,
                          )));
                },
                icon: const Icon(
                  Icons.delete_forever_rounded,
                ),
                color: AppColors.lightblue,
              )),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Settings())),
          child: ListTile(
            title: const Text('Settings'),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Settings()));
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
  );
}
