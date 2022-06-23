// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pst1/Screens/configure_account.dart';
import 'package:pst1/Screens/advanceSetting.dart';

class SelectServer extends StatefulWidget {
  const SelectServer({Key? key}) : super(key: key);

  @override
  State<SelectServer> createState() => _SelectServerState();
}

class _SelectServerState extends State<SelectServer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/Images/register.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 25, top: 55),
              child: const Text(
                "Select\nServer",
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.28,
                      right: 35,
                      left: 35),
                  child: Column(
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: Colors.white),
                              minimumSize: const Size(205, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              primary: Colors.white,
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ConfigureAccount(
                                      type: "gmail",
                                    )));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              SizedBox(
                                height: 40,
                                child: Image(
                                    image: ExactAssetImage(
                                        "lib/assets/Images/google.png")),
                              ),
                              Text(
                                "Gmail",
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: Colors.white),
                              minimumSize: const Size(205, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              primary: Colors.white,
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ConfigureAccount(type: "yahoo")));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              SizedBox(
                                height: 40,
                                child: Image(
                                    image: ExactAssetImage(
                                        "lib/assets/Images/Yahoo.png")),
                              ),
                              Text(
                                "Yahoo",
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          )), // ignore: prefer_const_constructors
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: Colors.white),
                              minimumSize: const Size(205, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              primary: Colors.white,
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ConfigureAccount(type: "Outlook")));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              SizedBox(
                                height: 40,
                                child: Image(
                                    image: ExactAssetImage(
                                        "lib/assets/Images/outlook1.png")),
                              ),
                              Text(
                                "Outlook",
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          )), // ignore: prefer_const_constructors
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              side: const BorderSide(
                                  width: 1, color: Colors.white),
                              minimumSize: const Size(205, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              primary: Colors.white,
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const AdvanceSetting()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              SizedBox(
                                height: 40,
                                child: Image(
                                    image: ExactAssetImage(
                                        "lib/assets/Images/otherServers.png")),
                              ),
                              Text(
                                "Others",
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          )), // ignore: prefer_const_constructors
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
