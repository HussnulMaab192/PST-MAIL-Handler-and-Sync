import 'package:flutter/material.dart';
import 'package:pst1/Screens/ConfigureAccount.dart';
import 'package:pst1/Screens/InboxPage.dart';
import 'package:pst1/Screens/selectServer.dart';
import 'package:pst1/Styles/app_colors.dart';
import 'package:pst1/Widgets/ButtonClass.dart';

class BrowseForPst extends StatefulWidget {
  const BrowseForPst({Key? key, required String title}) : super(key: key);

  @override
  State<BrowseForPst> createState() => _BrowseForPstState();
}

class _BrowseForPstState extends State<BrowseForPst> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/Images/login.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 25, top: 145),
              child: const Text(
                "WELCOME\nUSER",
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5,
                      right: 35,
                      left: 35),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 20, 0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 180,
                        ),
                        const Text(
                          "Psssst...It's very lonely here..!",
                          style: TextStyle(
                            color: AppColors.blackshade,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 140,
                          child: ButtonClass(
                              title: "Search for Pst Files",
                              background: AppColors.blue,
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SelectServer()))),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
