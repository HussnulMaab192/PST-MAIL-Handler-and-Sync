import 'package:flutter/material.dart';
import 'package:pst1/Screens/inbox_page.dart';
import 'package:pst1/Screens/selectServer.dart';
import '../../Styles/app_colors.dart';
import '../global_accounts.dart';

class RegisteredAccounts extends StatefulWidget {
  const RegisteredAccounts({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisteredAccounts> createState() => _RegisteredAccountsState();
}

class _RegisteredAccountsState extends State<RegisteredAccounts> {
  @override
  void initState() {
    super.initState();
  }

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
            title: const Text("Registered Accounts"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SelectServer()));
                  },
                  icon: const Icon(Icons.add))
            ],
            centerTitle: true,
            backgroundColor: AppColors.lightblueshade,
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              GlobalList.accountsList == null
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.only(left: 5, top: 255),
                      child: ListView.builder(
                          itemCount: GlobalList.accountsList!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.lightBlueAccent,
                              elevation: 1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => InboxPage(accId:GlobalList
                                        .accountsList![index].acc_id)));
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(GlobalList
                                        .accountsList![index].acc_mail[0]),
                                  ),
                                  title: Text(
                                      GlobalList.accountsList![index].acc_mail),
                                  trailing: Text(GlobalList
                                      .accountsList![index].acc_id
                                      .toString()),
                                ),
                              ),
                            );
                          }),
                    )
            ],
          )),
    );
  }
}
