import 'package:flutter/material.dart';
import 'package:pst1/Screens/InboxPage.dart';
import 'package:pst1/Screens/selectServer.dart';
import 'package:pst1/Screens/textFieldBuilder.dart';

import 'package:pst1/Styles/app_colors.dart';
import 'package:pst1/Widgets/ButtonClass.dart';
import 'package:pst1/providers/Db.dart';

class AdvanceSetting extends StatefulWidget {
  const AdvanceSetting({Key? key}) : super(key: key);

  @override
  State<AdvanceSetting> createState() => _AdvanceSettingState();
}

class _AdvanceSettingState extends State<AdvanceSetting> {
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pswdController = TextEditingController();
  TextEditingController cnfrmController = TextEditingController();
  String selectedValue = "IMAP";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/Images/login.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Advance Settings"),
          centerTitle: true,
          backgroundColor: AppColors.lightblueshade,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                buildTextField(
                    Icons.email, "Incoming Port", false, true, emailController),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 0, 0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 200,
                        child: Text(
                          "Select Incoming Encryption ",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      DropdownButton(
                          value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          items: dropdownItems)
                    ],
                  ),
                ),
                buildTextField(
                    Icons.email, "Outgoing Port", false, true, emailController),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 0, 0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 200,
                        child: Text(
                          "Select Outcoming Encryption ",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      DropdownButton(
                          value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          items: dropdownItems)
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 250,
                        child: ButtonClass(
                            title: "OK ",
                            background: AppColors.blue,
                            onTap: () async {
                              await DBHandler.getInstnace();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const InboxPage()));
                            })),
                    SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 210,
                        child: ButtonClass(
                            title: "Cancel",
                            background: AppColors.blue,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SelectServer()));
                            })),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("IMAP"), value: "IMAP"),
      const DropdownMenuItem(child: Text("POP3"), value: "POP3"),
    ];
    return menuItems;
  }
}
