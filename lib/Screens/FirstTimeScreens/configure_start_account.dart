import 'package:flutter/material.dart';
import 'package:pst1/Screens/FirstTimeScreens/registered_account.dart';
import '../../Styles/app_colors.dart';
import '../../Widgets/ButtonClass.dart';
import '../../providers/Db.dart';
import '../global_accounts.dart';

class ConfigureMyAccount extends StatefulWidget {
  const ConfigureMyAccount({Key? key}) : super(key: key);

  @override
  State<ConfigureMyAccount> createState() => _ConfigureMyAccountState();
}

class _ConfigureMyAccountState extends State<ConfigureMyAccount> {
  late DBHandler db;
  @override
  void initState() {
    DBHandler.getInstnace().then((value) {
      // ignore: unnecessary_null_comparison
      if (value == null) {
        print('Object not created...');
      } else {
        print('object created successfuly...');
        db = value;
        //     fetchAccountData();
        setState(() {
          if (db.getDB() == null) {
            print('returning... ');
            return;
          }
        });
        fetchAccountData();
      }
    });

    super.initState();
  }

  void fetchAccountData() async {
    DBHandler db = await DBHandler.getInstnace();
    GlobalList.accountsList = await db.selectAccountData();

    print('account list is in home ${GlobalList.accountsList}');

    print('Printing..Accounts..');
    GlobalList.accountsList!.forEach(
        ((element) => print('${element.acc_mail}  ${element.acc_type}')));

    setState(() {});
  }

  // addBoolToSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('boolValue', true);
  // }

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
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegisteredAccounts()));
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
