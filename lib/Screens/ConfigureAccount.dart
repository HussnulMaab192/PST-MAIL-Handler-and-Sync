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
  var selectedAccountType;
  TextEditingController mailAddressController = TextEditingController();
  TextEditingController IncomingMailServerController = TextEditingController();
  TextEditingController OutgoingMailServerController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  String selectedValue = "IMAP";
  @override
  Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage("lib/assets/Images/login.png"),
//               fit: BoxFit.cover)),
//       child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           appBar: AppBar(
//             title: const Text("Configure Account"),
//             centerTitle: true,
//             backgroundColor: AppColors.lightblueshade,
//           ),
//           body: Stack(
//             children: [
//               Column(children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 15),
//                   child: Form(
//                     //   key: formKey,
//                     child: Column(
//                       children: [
//                         buildTextField(Icons.email, "Enter Your Mail", false,
//                             true, emailController),
//                         Container(
//                           margin: const EdgeInsets.only(left: 0),
//                           child: const Text(
//                             "Server Information ",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         buildTextField(Icons.computer_outlined, "Account Type",
//                             false, false, pswdController),
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //   children: [
//                         //     buildTextField(Icons.email, "Account Type", false, true,
//                         //         emailController),
//                         //     DropdownButton(
//                         //       items: ["Account 1", "Account 2", "Account 3"]
//                         //           .map((e) => DropdownMenuItem(
//                         //                 child: Text('$e'),
//                         //                 value: e,
//                         //               ))
//                         //           .toList(),
//                         //       onChanged: (value) {
//                         //         setState(() {
//                         //           selectedAccountType = value.toString();
//                         //         });
//                         //       },
//                         //       value: selectedAccountType,
//                         //     ),
//                         //   ],
//                         // ),
//                         // const SizedBox(
//                         //   height: 10,
//                         // ),
//                         buildTextField(
//                             Icons.computer_outlined,
//                             "Incoming Mail Server",
//                             true,
//                             false,
//                             pswdController),
//                         //Outgoing Mail Server   Username
//                         buildTextField(
//                             Icons.computer_outlined,
//                             "Outgoing Mail Server",
//                             true,
//                             false,
//                             cnfrmController),
//                         buildTextField(Icons.lock, "Username", true, false,
//                             cnfrmController),
//                         buildTextField(Icons.lock, "Password", true, false,
//                             cnfrmController),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             SizedBox(
//                                 height: 50,
//                                 width: MediaQuery.of(context).size.width - 210,
//                                 child: ButtonClass(
//                                   title: "Advance Setting ",
//                                   background: AppColors.blue,
//                                   onTap: () => Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const AdvanceSetting())),
//                                 )),
//                             SizedBox(
//                                 height: 50,
//                                 width: MediaQuery.of(context).size.width - 250,
//                                 child: ButtonClass(
//                                   title: "Next",
//                                   background: AppColors.blue,
//                                   onTap: () => Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const InboxPage())),
//                                 ))
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ]),
//             ],
//           )),
//     );
//  }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Configure Account"),
        centerTitle: true,
        backgroundColor: AppColors.lightblueshade,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Stack(
          children: [
            Column(
              children: [
                buildTextField(Icons.email, "Mail Adress", false, true,
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
                            });
                          },
                          items: dropdownItems)
                    ],
                  ),
                ),
                buildTextField(Icons.email, "Incoming Mail Server", false, true,
                    IncomingMailServerController),
                buildTextField(Icons.email, "Outgoing Mail Server", false, true,
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
                                await DBHandler.getInstnace();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const InboxPage()));
                              })),
                    )
                  ],
                ),
              ],
            ),
          ],
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
