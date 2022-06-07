// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pst1/Screens/InboxPage.dart';
import 'package:pst1/Screens/advanceSetting.dart';
import 'package:pst1/Screens/selectServer.dart';
import 'package:pst1/Screens/textFieldBuilder.dart';
import 'package:pst1/Styles/app_colors.dart';
import 'package:pst1/Widgets/ButtonClass.dart';

import '../providers/Db.dart';

class ConfigureAccount extends StatefulWidget {
  const ConfigureAccount({Key? key}) : super(key: key);

  @override
  State<ConfigureAccount> createState() => _ConfigureAccountState();
}

class _ConfigureAccountState extends State<ConfigureAccount> {
  String incomingServer = "123";
  String outgoingServer = "555";
  var selectedAccountType;
  TextEditingController mailAddressController = TextEditingController();
  TextEditingController IncomingMailServerController = TextEditingController();
  TextEditingController OutgoingMailServerController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String selectedValue = "IMAP";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Configure Account"),
        centerTitle: true,
        backgroundColor: AppColors.lightblueshade,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              buildTextField(Icons.email, "Enter Your Mail", false, true,
                  mailAddressController),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 0, 0),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 200,
                      child: Text(
                        "Server Information ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 0, 0),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 200,
                      child: Text(
                        "Account Type ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                    DropdownButton(
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            if (selectedValue == "IMAP") {
                              incomingServer = "123";
                              outgoingServer = "555";
                            } else {
                              incomingServer = "456";
                              outgoingServer = "999";
                            }
                          });
                        },
                        items: dropdownItems)
                  ],
                ),
              ),
              buildTextField(Icons.email, incomingServer, false, true,
                  IncomingMailServerController),
              buildTextField(Icons.email, outgoingServer, false, true,
                  OutgoingMailServerController),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 0, 0),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 200,
                      child: Text(
                        "Logon Information ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildTextField(
                  Icons.email, "User Name", false, true, userNameController),
              // buildTextField(
              //     Icons.email, "Password  ", false, true, emailController),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 205.0, top: 10),
                    child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 250,
                        child: ButtonClass(
                            title: "Next",
                            background: AppColors.blue,
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                await DBHandler.getInstnace();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const InboxPage()));
                              }
                            })),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("IMAP"), value: "IMAP"),
      const DropdownMenuItem(child: Text("POP3"), value: "POP3"),
    ];
    return menuItems;
  }
}
