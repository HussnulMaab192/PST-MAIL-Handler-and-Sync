import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/src/widgets/framework.dart';

class SendMail extends StatefulWidget {
  const SendMail({Key? key}) : super(key: key);

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("send "),
          onPressed: () {
            _sendMail();
          },
        ),
      ),
    );
  }

  _sendMail() async {
    final Email send_email = Email(
      body: 'body of email',
      subject: 'subject of email',
      recipients: ['example1@ex.com'],
      cc: ['example_cc@ex.com'],
      bcc: ['example_bcc@ex.com'],
      //  attachmentPaths: ['/path/to/email_attachment.zip'],
      isHTML: false,
    );
    await FlutterEmailSender.send(send_email);
    print("sent");
  }
}
