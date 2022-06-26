// ignore_for_file: prefer_collection_literals, deprecated_member_use, prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SocketClientState pageState;

class SocketClient extends StatefulWidget {
  //544283
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
  TextEditingController msgCon = TextEditingController();
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
            submitArea(),
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
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide: const BorderSide(color: Colors.grey),
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

  Widget submitArea() {
    return Card(
      child: ListTile(
        title: TextField(
          controller: msgCon,
          // ignore: prefer_const_constructors
          decoration: InputDecoration(
              hintText: "Enter Message", border: const UnderlineInputBorder()),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.send_rounded),
          color: Colors.deepPurple,
          disabledColor: Colors.grey,
          onPressed: (clientSocket != null) ? submitMessage : null,
        ),
      ),
    );
  }

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
        socket.listen(
          (onData) {
            String str = onData.length.toString();
            print("length of str is " +
                str); //String.fromCharCode(onData).trim();

            RegExp r = RegExp('');

            String result = String.fromCharCodes(onData).trim();
            result = result.split("_XXX_")[1];
            print(result);
            setState(() {
              result = String.fromCharCodes(onData).trim();
              // if (result1.contains('_XXX_')) {
              String result1 = result.split('_XXX_')[1];
              if (result.contains('_XXX_')) {
                items.insert(0,
                    MessageItem(clientSocket.remoteAddress.address, result1));
              }
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
    clientSocket.write("$message\n");
  }

  void submitMessage() {
    if (msgCon.text.isEmpty) return;
    setState(() {
      items.insert(0, MessageItem(localIP, msgCon.text));
    });
    sendMessage(msgCon.text);
    msgCon.clear();
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
}

class MessageItem {
  String owner;
  String content;

  MessageItem(this.owner, this.content);
}
