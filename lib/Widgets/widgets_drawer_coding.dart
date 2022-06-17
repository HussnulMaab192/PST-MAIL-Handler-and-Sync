import 'package:flutter/material.dart';
import 'package:pst1/Widgets/Drawer/DrawerScreens/Drafts.dart';

import '../HelperClasses/my_widget_drawer.dart';
import '../Screens/globalVariables.dart';
import '../Screens/inbox_page.dart';
import '../Styles/app_colors.dart';
import 'Drawer/DrawerScreens/Archive.dart';
import 'Drawer/DrawerScreens/Junk.dart';
import 'Drawer/DrawerScreens/Settings.dart';
import 'Drawer/DrawerScreens/deleted.dart';
import 'Drawer/DrawerScreens/sent.dart';

Widget myDrawer( BuildContext context, int accId ) {

  return Drawer(
    child: ListView(
      children: [
        const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.amberAccent,
              child: Text('PST'),
            ),
            accountName: Text("PST MAIL HANDLER"),
            accountEmail: Text("pst@gmail.com")),
        for (int i = 0; i < foldersinfo.length; i++)
          Row(
            children: [
              Expanded(
                child: ExpansionTile(
                  title: Text(foldersinfo[i].name),
                  children:
                      getChildHirerachy(foldersinfo[i].childrens, context),
                ),
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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => InboxPage(
                          db: null,
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
                          accId: accId ,
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
