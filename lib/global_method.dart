import 'package:pst1/providers/Db.dart';

import 'Screens/reply_mail.dart';

void printData(int fid, int accId) async {
  DBHandler db = await DBHandler.getInstnace();
  mails = await db.getData(fid, accId);
  print(mails);
  print('Printing..Mails..');
  mails.forEach(((element) =>
      print('${element.body}  ${element.fid} ${element.accountId}')));
  // setState(() {});
}
