import 'package:flutter/material.dart';
import 'package:pst1/Screens/inbox_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FirstTimeScreens/configure_start_account.dart';
import 'browseForPstFile.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool? boolValue;
  @override
  void initState() {
    super.initState();
    // getBoolValuesSF();
    _navigateHome();
  }

  // getBoolValuesSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Return bool
  //   boolValue = prefs.getBool('boolValue') ?? true;
  //   return boolValue;
  // }

  _navigateHome() async {
    await Future.delayed(const Duration(milliseconds: 3500), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    boolValue = prefs.getBool('boolValue');
    print("Bool Value in splash is " + boolValue.toString());

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => boolValue == null
                ? const ConfigureMyAccount()
                : InboxPage(accId: 1)));
    // ignore: prefer_const_constructors
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.asset("lib/assets/Images/logo.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                child: const Text(
              "PST Mail handler & Sync",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
    );
  }
}
