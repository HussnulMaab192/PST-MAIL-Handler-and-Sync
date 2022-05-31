import 'package:flutter/material.dart';
import 'package:pst1/Screens/ConfigureAccount.dart';
import 'package:pst1/Screens/DrawerPage.dart';
import 'package:pst1/Screens/InboxPage.dart';

class Temporary extends StatefulWidget {
  const Temporary({Key? key, required String title}) : super(key: key);

  @override
  State<Temporary> createState() => _TemporaryState();
}

class _TemporaryState extends State<Temporary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Testing Screen")),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ConfigureAccount(),
                  ),
                );
              },
              child: const Text("Configure Account"),
            ),
            // Drawer Page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const DrawerPage(),
                  ),
                );
              },
              child: const Text("DrawerPage"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const InboxPage(),
                  ),
                );
              },
              child: const Text("Inbox "),
            ),
          ],
        ));
  }
}
