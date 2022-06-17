// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pst1/Screens/inbox_page.dart';
import 'package:pst1/Screens/textFieldBuilder.dart';
import 'package:pst1/Styles/app_colors.dart';
import 'package:pst1/Widgets/ButtonClass.dart';
import '../providers/db.dart';

class ConfigureAccount extends StatefulWidget {
  const ConfigureAccount({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<ConfigureAccount> createState() => _ConfigureAccountState();
}

class _ConfigureAccountState extends State<ConfigureAccount> {
  String incomingServer = "123";
  String outgoingServer = "555";
  int aid = 0;
  var selectedAccountType;
  TextEditingController mailAddressController = TextEditingController();
  TextEditingController incomingMailServerController = TextEditingController();
  TextEditingController outgoingMailServerController = TextEditingController();
  TextEditingController confirmPswdController = TextEditingController();
  TextEditingController idController = TextEditingController();
  late DBHandler db;
  TextEditingController pswdController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String selectedValue = "IMAP";
  @override
  void initState() {
    DBHandler.getInstnace().then((value) {
      if (value == null) {
        print('Object not created...');
      } else {
        print('object created successfuly...');
        db = value;
        setState(() {
          if (db.getDB() == null) {
            print('returning... ');
            return;
          }
        });
      }
    });

    super.initState();
  }

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
              buildTextField(Icons.email, "Enterid", false, true, idController),
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
                  incomingMailServerController),
              buildTextField(Icons.email, outgoingServer, false, true,
                  outgoingMailServerController),
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
                  Icons.email, "Enter Password", false, true, pswdController),
              buildTextField(Icons.email, "Confirm Password", false, true,
                  confirmPswdController),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 205.0, top: 10),
                    child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 250,
                        child: ButtonClass(
                            title: "Register",
                            background: AppColors.blue,
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                     
                             DBHandler db=await   DBHandler.getInstnace();
 
                            await    db.insertIntoAccountData(
                                    int.parse(idController.text),
                                    widget.type,
                                    mailAddressController.text.toString(),
                                    pswdController.text.toString(),
                                    confirmPswdController.text.toString(),
                                    "smtpServer",
                                    123,
                                    "Imap",
                                    456);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => InboxPage(db:db)));
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
