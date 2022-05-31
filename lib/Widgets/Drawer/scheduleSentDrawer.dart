import 'package:flutter/material.dart';

Widget sceduleSentDrawer() {
  return Drawer(
    child: Column(children: const [
      ListTile(
        title: Text('Schedule Sent'),
        leading: Icon(Icons.move_to_inbox_outlined),
      ),
      ListTile(title: Text('Add from Contacts'), leading: Icon(Icons.contacts)),
      ListTile(title: Text('Save As Drafts'), leading: Icon(Icons.save_as)),
      ListTile(title: Text('Discard'), leading: Icon(Icons.discord)),
      ListTile(title: Text('Setting'), leading: Icon(Icons.settings)),
      ListTile(
          title: Text('Help and Feedback'),
          leading: Icon(Icons.feedback_outlined)),
      ListTile(title: Text('Flag'), leading: Icon(Icons.flag)),
      ListTile(title: Text('Pin'), leading: Icon(Icons.pin)),
      ListTile(title: Text('Snooze'), leading: Icon(Icons.snooze)),
      ListTile(title: Text('Select All'), leading: Icon(Icons.select_all)),
    ]),
  );
}
