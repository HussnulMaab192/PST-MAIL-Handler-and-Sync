import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Drawer Page'),
        ),
        drawer: Drawer(
          child: Column(
            children: const [
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.amberAccent,
                    child: Text('PST'),
                  ),
                  accountName: Text("PST MAIL HANDLER"),
                  accountEmail: Text("pst@gmail.com")),
              ListTile(
                title: Text('Folders'),
                leading: Icon(Icons.folder_copy),
              ),
              ListTile(
                  title: Text('Inbox'),
                  leading: Icon(Icons.move_to_inbox_sharp)),
              ListTile(
                title: Text('Drafts'),
                leading: Icon(Icons.drive_file_rename_outline_outlined),
              ),
              ListTile(
                title: Text('Archieve'),
                leading: Icon(
                  Icons.archive_outlined,
                ),
              ),
              ListTile(
                title: Text('Sent'),
                leading: Icon(Icons.send),
              ),
              ListTile(
                title: Text('Deleted'),
                leading: Icon(Icons.delete_sweep_outlined),
              ),
              ListTile(
                  title: Text('Junk'),
                  leading: Icon(Icons.delete_forever_rounded)),
              ListTile(
                title: Text('Contacts'),
                leading: Icon(Icons.contacts_rounded),
              ),
              ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
              ),
            ],
          ),
        ));
  }
}
