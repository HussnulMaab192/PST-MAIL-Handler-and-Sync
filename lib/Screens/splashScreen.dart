import 'package:flutter/material.dart';
import 'package:pst1/Screens/selectServer.dart';

import 'browseForPstFile.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateHome();
  }

  _navigateHome() async {
    await Future.delayed(const Duration(milliseconds: 3500), () {});
    // ignore: prefer_const_constructors
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SelectServer()));
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
