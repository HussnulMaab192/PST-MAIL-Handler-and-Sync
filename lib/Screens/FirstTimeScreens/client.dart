// ignore_for_file: prefer_collection_literals, deprecated_member_use, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pst1/HelperClasses/folder_details.dart';
import 'package:pst1/models/folder.dart';
import 'package:pst1/models/mail.dart';
import 'package:pst1/providers/db.dart';

late SocketClientState pageState;

class SocketClient extends StatefulWidget {
  String? mailId;
  SocketClient({
    Key? key,
    required this.mailId,
  }) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  SocketClientState createState() {
    pageState = SocketClientState();
    return pageState;
  }
}

class SocketClientState extends State<SocketClient> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String localIP = "";
  List<MessageItem> items = [];

  TextEditingController ipCon = TextEditingController();
  int port = 46460;

  var clientSocket;

  @override
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    disconnectFromServer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text("Client"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: <Widget>[
            connectArea(),
            messageListArea(),
            //  submitArea(),
          ],
        ));
  }

  Widget ipInfoArea() {
    return Card(
      child: ListTile(
        dense: true,
        leading: const Text("IP"),
        title: Text(localIP),
      ),
    );
  }

  Widget connectArea() {
    return Card(
      child: ListTile(
        dense: true,
        leading: const Text("Server IP"),
        title: TextField(
          controller: ipCon,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              isDense: true,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              filled: true,
              fillColor: Colors.grey[50]),
        ),
        trailing: RaisedButton(
          child: Text((clientSocket != null) ? "Disconnect" : "Connect"),
          onPressed:
              (clientSocket != null) ? disconnectFromServer : connectToServer,
        ),
      ),
    );
  }

  Widget messageListArea() {
    return Expanded(
      child: ListView.builder(
          reverse: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            MessageItem item = items[index];
            return Container(
              alignment: (item.owner == localIP)
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (item.owner == localIP)
                        ? Colors.deepPurple[100]
                        : Colors.deepPurple[200]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      (item.owner == localIP) ? "Client" : "Server",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item.content,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  // Widget submitArea() {
  //   return Card(
  //     child: ListTile(
  //       title: TextField(
  //         controller: msgCon,
  //         // ignore: prefer_const_constructors
  //         decoration: InputDecoration(
  //             hintText: "Enter Message", border: const UnderlineInputBorder()),
  //       ),
  //       trailing: IconButton(
  //         icon: const Icon(Icons.send_rounded),
  //         color: Colors.deepPurple,
  //         disabledColor: Colors.grey,
  //         onPressed: (clientSocket != null) ? submitMessage : null,
  //       ),
  //     ),
  //   );
  // }

  void connectToServer() async {
    if (ipCon.text == "") {
      showSnackBarWithKey("Fill all fields");
    } else {
      print("Destination Address: ${ipCon.text}");

      Socket.connect(ipCon.text, port, timeout: const Duration(seconds: 5))
          .then((socket) {
        setState(() {
          clientSocket = socket;
        });
        showSnackBarWithKey(
            "Connected to ${socket.remoteAddress.address}:${socket.remotePort}");
        submitMessage();
        socket.listen(
          (onData) {
            //     print("ondata ----->>>>>> $onData");
            //  String data = new String(onData,0,onData.length,);
            //  String str = onData.length.toString();
            //String.fromCharCode(onData).trim();

            var res = String.fromCharCodes(onData).trim();
            res = res.split("_yyy_")[1];
            print("Sting convrt ----->>>>>> $res");
            //  print(object)
            // print("Result----------> = : ${result} ");
            // List res = onData;

            // result = result.split("_XXX_")[1];
            setState(() {
              // result = String.fromCharCodes(onData).trim();
              //List l = res.split("}");
              // result
              //     .
              // if (result1.contains('_XXX_')) {
              //     String result1 = result.split('_XXX_')[1];
              //  var json = ;
              // var mailRes = ;
              // print("mails data is :" + mailRes);

              //  Email e = Email.fromJsonMap();
              //print("subject of e is :" + e.subject);
              Email e = Email.jsonMap(jsonDecode(res));
              print(e.subject);
  
              Email obj = Email(
                mid: e.mid,
                fid: e.fid,
                sender: e.sender,
                subject: e.subject,
                body: e.body,
                deletedFlag: "false",
                accountId: 1,
                fName: e.fName,
              );
              insertMailsIntoDb(obj);
              // var folderRes = jsonDecode(mailRes);
              // FolderDetail f = FolderDetail.jsonMap(folderRes);
              // print("body is :" + f.name + " " + "id is  " + f.name);
              // insertFoldersIntoDb(f);
              // items.insert(
              //     0, MessageItem(clientSocket.remoteAddress.address, result));

              // var updateObj = json.decode(result);
              //   Email mail = Email.jsonMap(jsonDecode(result));

              //  print("My mails in client are :" + mail.toString());
// / 192.168.0.120
              // if (!result1.contains('_XXX_')) {
              //   if (result1.startsWith('sender=')) {
              //     if (result1.contains("Pst File Not Found")) {
              //       items.insert(
              //           0,
              //           MessageItem(
              //               clientSocket.remoteAddress.address, result1));
              //     } else {
              //       final dummySender = result1.split("Subject=");
              //       final mysender = dummySender[0].split("sender=");
              //       final sender = mysender[1];
              //       final dummySubject = dummySender[1].split("body=");
              //       final subject = dummySubject[0];
              //       final body = dummySubject[1];
              //       Email e = Email(
              //           fid: 0,
              //           sender: sender,
              //           subject: subject,
              //           mData: "mData",
              //           body: body,
              //           deletedFlag: "false",
              //           accountId: 1);
              //       insertMailsIntoDb(e);
              //       //insertMailsInDb(0, 1, sender, subject, "mData", body);

              //       print("After mails inserted in db ");
              //       items.insert(
              //           0,
              //           MessageItem(
              //               clientSocket.remoteAddress.address, result1));
              //     }
              //   }
              //}
            });
          },
          onDone: onDone,
          onError: onError,
        );
      }).catchError((e) {
        showSnackBarWithKey(e.toString());
      });
    }
  }

  void onDone() {
    showSnackBarWithKey("Connection has terminated.");
    disconnectFromServer();
  }

  void onError(e) {
    print("onError: $e");
    showSnackBarWithKey(e.toString());
    disconnectFromServer();
  }

  void disconnectFromServer() {
    print("disconnectFromServer");
    clientSocket.close();
    setState(() {
      clientSocket = null;
    });
  }

  void sendMessage(String message) {
    var commond = utf8.encode(message);
    clientSocket.add(commond);
    clientSocket.write('');

    commond = utf8.encode('READ');
    clientSocket.add(commond);
    //clientSocket.send();
    clientSocket.write("");
  }

  void submitMessage() {
    setState(() {
      items.insert(0, MessageItem(localIP, widget.mailId!));
    });
    sendMessage(widget.mailId!);
  }

  showSnackBarWithKey(String message) {
    scaffoldKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Done',
          onPressed: () {},
        ),
      ));
  }

  void insertMailsIntoDb(Email a) async {
    DBHandler db = await DBHandler.getInstnace();
    db.insertIntoOriginalMails(a);
  }

  void insertFoldersIntoDb(FolderDetail f) async {
    DBHandler db = await DBHandler.getInstnace();
    db.insertIntoFolderOriginal(f);
  }

//   void insertMailsInDb(int fId, int accId, String sender, String subject,
//       String mData, String body) async {
//     DBHandler db = await DBHandler.getInstnace();
//     await db.insertIntoOriginalMails(
//         1, sender, subject, mData, body, "false", 1);
//     print("inside completion of insertmailsInDb ");
//   }
}

class MessageItem {
  String owner;
  String content;

  MessageItem(this.owner, this.content);
}
