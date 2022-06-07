import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:pst1/Screens/reply_mail.dart';

import '../models/Mail.dart';
import '../providers/Db.dart';
import 'globalVariables.dart';

// import 'package:read_json_file/weekcontent.dart';
//import 'package:read_json_file/mailsmodel.dart';
// import 'ProductDataModel.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReadMailFromApi(),
    );
  }
}

class ReadMailFromApi extends StatefulWidget {
  @override
  _ReadMailFromApiState createState() => _ReadMailFromApiState();
}
 late DBHandler db;
int c = 0;
int i = 0;
int? ind;
var items;

class _ReadMailFromApiState extends State<ReadMailFromApi> {
  Future<List<Email>> ReadJsonData() async {
    //List<WeekModels> getCoursesList = [];
    var mails = <Email>[];
    String url = "http://$ip/api/pst/GetEmails";

    var list2;
    var response = await http.get(Uri.parse(url));
    print("mails Response  is :" + response.body);

    if (response.statusCode == 200) {
      mails.clear();
      list2 = json.decode(response.body.toString());
      for (var i in list2) {
        mails.add(Email.fromMap(i));
      }

      for (var tree in mails) {
        print(tree.subject);
      }

      print("mails length " + list2.length.toString());
      return mails;
    } else {
      print(response.statusCode);
    }

    return mails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Read Api",
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 241, 237, 237),
                fontFamily: "Times new roman"),
          ),
        ),
        body: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
              items = snapshot.data as List<Email>;
              return ListView.builder(
                  itemCount: items == null ? 0 : items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          // scrollDirection: Axis.vertical,
                          //shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: mails.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ReplyMail(
                                          mid: mails[index].mid,
                                          fid: mails[index].fid,
                                          subject: mails[index].subject,
                                          body: mails[index].body,
                                          sender: mails[index].sender,
                                        )));
                              },
                              key: Key(mails[index].mid.toString()),
                              splashColor: Colors.blue,
                              onLongPress: () {
                                setState(() {
                                  mails[index].color = !mails[index].color;
                                  mails[index].Selected =
                                      !mails[index].Selected;
                                  if (mails[index].Selected == true) {
                                    c++;
                                    menu = true;
                                  } else {
                                    c--;
                                    if (c == 0) menu = false;
                                  }
                                });
                                //  menu = false;
                              },
                              child: Card(
                                color: mails[index].color
                                    ? Colors.white
                                    : Colors.blueAccent,
                                elevation: 1,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: mails[index].Selected
                                        ? const Icon(Icons.done)
                                        : Text(mails[index].subject[0]),
                                  ),
                                  title: Text(
                                      '${mails[index].subject}   ${mails[index].fid} '),
                                  subtitle: Text(
                                    mails[index].body,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.star_border_outlined,
                                  ),
                                ),
                              ),
                            );
                          })),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
 
      
}
