import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pst1/Screens/inbox_page.dart';
import 'package:pst1/Screens/textFieldBuilder.dart';
import 'package:pst1/Styles/app_colors.dart';
import 'package:pst1/models/file_pages.dart';

import 'app_theme.dart';
import 'contacts_data.dart';

class Compose extends StatefulWidget {
  dynamic sender;
  dynamic portNo;
  dynamic smtpServer;
  dynamic pswd;
  dynamic accMail;
  dynamic accId;
  String? receipetMail;
  Compose({
    Key? key,
    required this.sender,
    required this.portNo,
    required this.smtpServer,
    required this.pswd,
    required this.accMail,
    required this.accId,
  }) : super(key: key);
  Compose.con({
    Key? key,
    required this.receipetMail,
    required this.accMail,
  }) : super(key: key);
  @override
  State<Compose> createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  bool showToCcBcc = false;
  //object creation for FilePages
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController ccController = TextEditingController();
  TextEditingController bccController = TextEditingController();
  TextEditingController subController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();

    final newFile = File('${appStorage.path}/ ${file.name}');
    return File(file.path!).copy(newFile.path);
  }

  void openFiles(List<PlatformFile> files) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FilePages(files: files, onOpenedFile: openFile),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Compose"),
        backgroundColor: AppColors.lightblueshade,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.attach_file,
              color: Colors.white,
            ),
            // onPressed: () {},

            onPressed: () async {
              final result = await FilePicker.platform
                  .pickFiles(allowMultiple: true, type: FileType.any);

              if (result == null) return;
              openFiles(result.files);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              // send_email(sender, spass, recipientsEmail, subject, body, smptpServer, smtpPortNo)

              sendEmail(
                  fromController.text,
                  "ysbsnhgziqxqtfsx",
                  toController.text,
                  subController.text,
                  bodyController.text,
                  widget.smtpServer,
                  widget.portNo);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: InkWell(
                        onTap: (() {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => Contacts(
                              accId: widget.accId,
                              accMail: widget.accMail,
                            ),
                          ));
                        }),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.contact_page_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Add from contacts")
                          ],
                        ),
                      )),
                      PopupMenuItem(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => InboxPage(
                                        accId: widget.accId,
                                        accmail: widget.accMail,
                                        portNo: widget.smtpServer,
                                      )));
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.stop,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Discard")
                          ],
                        ),
                      )),
                      PopupMenuItem(
                          child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: const [
                            Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Setting")
                          ],
                        ),
                      )),
                    ],
                child: const Icon(Icons.expand_circle_down)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: buildTextField(
                      Icons.assignment_ind_outlined,
                      "${widget.accMail ?? "From"}",
                      false,
                      true,
                      fromController),
                ),
                IconButton(
                    onPressed: () {
                      showToCcBcc = !showToCcBcc;
                      setState(() {});
                    },
                    icon: const Icon(Icons.abc))
              ],
            ),
            buildTextField(Icons.assignment_ind_outlined,
                widget.receipetMail ?? "to", false, true, toController),
            showToCcBcc == true
                ? Column(
                    children: [
                      buildTextField(Icons.assignment_ind_outlined, "Cc", false,
                          true, ccController),
                      buildTextField(Icons.assignment_ind_outlined, "Bcc",
                          false, true, bccController),
                    ],
                  )
                : const Text(" "),
            buildTextField(
                Icons.subject_outlined, "Subject", false, true, subController),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: bodyController,
                  decoration: InputDecoration(
                    hintText: "Compose Email",
                    hintStyle: AppTheme.searchTextStyle,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendEmail(var sender, var spass, var recipientsEmail, var subject,
      var body, var smptpServer, var smtpPortNo) async {
    String smtpServerName = smptpServer;
    var smtpPort = smtpPortNo;

    var smtpUserName = sender;
    String smtpPassword = spass;

    final smtpServer = SmtpServer(
      smtpServerName,
      port: smtpPort,
      ssl: true,
      ignoreBadCertificate: true,
      allowInsecure: true,
      username: smtpUserName,
      password: smtpPassword,
    );

    final message = Message()
      ..from = Address(smtpUserName)
      ..recipients.add(recipientsEmail)
      ..subject = subject
      ..text = body;

    // await send(message, sender)
    //     .then((value) {
    //        showDialog(
    //       context: context,
    //       builder: (cont) {
    //         return AlertDialog(title: Text("Email has sent!"));
    //       });

    // })
    // .onError((error, stackTrace) {
    //   showDialog(
    //   context: context,
    //   builder: (cont) {
    //     return AlertDialog(title: Text("Failed to snet!"));
    //   });

    // });

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Email has been sent successfully"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("ok")),
              ],
            );
          });
      print('ENCODE String' + body.length.toString());
    } on MailerException catch (e) {
      print('Message not sent.' + e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(" Email Not sent"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("ok")),
              ],
            );
          });

      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

// Future<String?> ReceiveMail(String userName, String password) async {
//     final email = '$userName';
//     print('discovering settings for  $email...');
//     final config = await Discover.discover(email);
//     if (config == null) {
//       // note that you can also directly create an account when
//       // you cannot autodiscover the settings:
//       // Compare [MailAccount.fromManualSettings] and [MailAccount.fromManualSettingsWithAuth]
//       // methods for details
//       print('Unable to autodiscover settings for $email');
//       return email;
//     }
//     print('connecting to ${config.displayName}.');
//     final account = MailAccount.fromDiscoveredSettings(
//         'my account', email, password, config);
//     final mailClient = MailClient(account, isLogEnabled: true);
//     try {
//       await mailClient.connect();
//       print('connected');
//       final mailboxes =
//           await mailClient.listMailboxesAsTree(createIntermediate: false);
//       print('mailbox +$mailboxes');
//       await mailClient.selectInbox();
//       final messages = await mailClient.fetchMessages(count: 20);
//       for (final msg in messages) {
//         var subject = msg.decodeSubject();
//         if (subject!.startsWith('Snapchat-Message-')) {
//           print('Subject  + $subject');
//           mbody = msg.decodeTextPlainPart();
//           print('body + $mbody');
//           print('total' + mbody.trim().length.toString());
//           break;
//         }
//       }

//       return mbody!;
//       mailClient.eventBus.on<MailLoadEvent>().listen((event) {
//         print('New message at ${DateTime.now()}:');
//         print('Message.....+ $event.message');
//       });
//       await mailClient.startPolling();
//     } on MailException catch (e) {
//       print('High level API failed with $e');
//     }
//   }

}
