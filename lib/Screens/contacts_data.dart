import 'package:flutter/material.dart';
import 'package:pst1/Screens/global_accounts.dart';
import '../providers/db.dart';
import 'compose.dart';

class Contacts extends StatefulWidget {
  late String accMail;
  late int accId;
  Contacts({
    Key? key,
    required this.accMail,
    required this.accId,
  }) : super(
          key: key,
        );

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  void initState() {
    fetchContactData();
    super.initState();
  }

  void fetchContactData() async {
    DBHandler db = await DBHandler.getInstnace();
    GlobalList.contactsList = await db.selectContactData();

    print('account list is in home ${GlobalList.contactsList}');

    print('Printing..Accounts..');
    GlobalList.contactsList
        .forEach(((element) => print('${element.first_name}}')));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),
      body: ListView.builder(
          itemCount: GlobalList.contactsList.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.lightBlueAccent,
              elevation: 1,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Compose.con(
                            receipetMail: GlobalList.contactsList[index].email,
                            accMail: widget.accMail,
                          )));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(GlobalList.contactsList[index].first_name[0]),
                  ),
                  title: Text(GlobalList.contactsList[index].first_name +
                      GlobalList.contactsList[index].last_name),
                  subtitle:
                      Text(GlobalList.contactsList[index].number.toString()),
                ),
              ),
            );
          }),

      // body: Container(
      //   child: Container(
      //     color: Colors.amber,
      //     height: 200,
      //     width: 200,
      //   ),
      // ),
    );
  }
}
