import 'package:flutter/material.dart';
import 'package:pst1/Screens/splashScreen.dart';
import 'dart:io';
import 'FirstTimeScreens/client.dart';
import 'FirstTimeScreens/flutter_mails_sender.dart';

void main() async {
  //Socket sock = await Socket.connect('192.168.163.177', 46460);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Splash()
      // SocketClient()
        );
  }
}
