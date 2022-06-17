import 'package:flutter/material.dart';
import 'package:pst1/Screens/FirstTimeScreens/registered_account.dart';
import 'package:pst1/Screens/selectServer.dart';
import '../../Styles/app_colors.dart';
import '../../Widgets/ButtonClass.dart';

class ConfigureMyAccount extends StatefulWidget {
  const ConfigureMyAccount({Key? key}) : super(key: key);

  @override
  State<ConfigureMyAccount> createState() => _ConfigureMyAccountState();
}

class _ConfigureMyAccountState extends State<ConfigureMyAccount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/Images/register.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Configure Account"),
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
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 200,
                        child: ButtonClass(
                            title: "Add Account ",
                            background: AppColors.lightblueshade,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const RegisteredAccounts(
                                 
                                      )));
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
}
