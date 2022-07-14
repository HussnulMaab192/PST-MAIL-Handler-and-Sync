import 'package:pst1/models/contact.dart';
import 'package:pst1/models/folder.dart';
import 'package:sqflite/sqflite.dart';
import '../HelperClasses/folder_details.dart';
import '../Screens/contacts_data.dart';
import '../models/account.dart';
import '../models/action.dart';
import '../models/mail.dart';

class DBHandler {
  int mid = 0;
  bool isDbNull() {
    if (_db == null) {
      return true;
    } else {
      return false;
    }
  }

  Database? GetDB() {
    return _db;
  }

  Database? _db;
  static DBHandler? _instance;
  int v = 20;
  DBHandler._Init() {
    _createDB();
  }
  static Future<DBHandler> getInstnace() async {
    _instance ??= DBHandler._Init();

    return _instance!;
  }

  Future<void> _createDB() async {
    if (_db == null) {
      print('getting db path');
      String dbpath = await getDatabasesPath();
      dbpath = dbpath + "test.db";
      print("DB Path " + dbpath);
      openDatabase(dbpath, version: 1,
          onCreate: (Database db, int version) async {
        print('Creating table');
        String query =
            "create table accounts(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,type Text,email Text, pass Text,confirm_password Text ,smtp_server Text, smtp_port integer,imap_server Text,imap_port integer )";

        await db.execute(query);
        print('accounts table created...');
        query =
            "create table folders(id integer primary key  ,name Text,account_id Text,folder_id Text default null)";
        await db.execute(query);
        print('folders table created....');
        query =
            "create table contacts(id integer primary key ,first_name Text,last_name Text, picture Text,account_id integer,email Text, number integer)";
        await db.execute(query);
        print('contacts table created....');
        query =
            "create table emails(id Text primary key ,folder_id Text ,sender Text ,subject Text, body Text,deleted_flag Text,account_id Text,folder_name Text)";
        await db.execute(query);
        print(
            'emails table created....'); //action type==mail pr ya folder pr laga?
        query =
            "create table actions(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,type Text ,value Text ,source Text,destination Text, TDatetime datetime, object_id integer )";
        await db.execute(query);
        _db = db;

        print('actions table created....');
       // await insertFolderData(db);
        await insertContactsData(db);
      }).then((value) {
        //  print('_db is intialized... ');
        _db = value;
      });
    }
  }

  Future<void> insertData(int id, String name, int accId, int folderId) async {
    getNextid("folders").then((value) async {
      {
        print('Executing insertion command in folders Table...');
        await _db!.rawInsert(
            "insert into folders values ('$value', '$name', '$accId','$folderId')");
        print('Command executed');
      }
    });
  }

  // Future<void> insertFolderData(Database db) async {
  //   print('Executing insertion command in Folder Table...');

  //   await db.rawInsert("insert into folders values (0, 'inbox', '1', -1)");
  //   await db
  //       .rawInsert("insert into folders values (9, 'sub inbox 2 ', '1', 0)");
  //   await db
  //       .rawInsert("insert into folders values (10, 'sub inbox 3 ', '1', 0)");
  //   await db.rawInsert("insert into folders values (1, 'drafts', '1', -1)");
  //   await db.rawInsert("insert into folders values (2, 'Archieve', '1', -1)");
  //   await db.rawInsert("insert into folders values (3, 'sent', '1', -1)");
  //   await db.rawInsert("insert into folders values (4, 'deleted', '1', -1)");
  //   await db.rawInsert("insert into folders values (5, 'junk', '1', -1)");
  //   await db.rawInsert("insert into folders values (6, 'sub inbox 1', '1', 0)");
  //   await db
  //       .rawInsert("insert into folders values (7, 'sub drafts 1 ', '1', 1)");
  //   await db
  //       .rawInsert("insert into folders values (11, 'sub draft 2 ', '1', 1)");
  //   await db
  //       .rawInsert("insert into folders values (8, 'sub junks 1 ', '1', 5)");

  //   await db
  //       .rawInsert("insert into folders values (12, 'sub draft 3 ', '1', 11)");
  //   await db.rawInsert(
  //       "insert into folders values (13, 'sub draft 3.3 ', '1', 12)");

  //   print('Command executed');
  // }

  Future<void> insertContactsData(Database db) async {
    print('Executing insertion command in Contact Table...');
    await db.rawInsert(
        "insert into contacts values ('0', 'Hussnul', 'Maab', 'pic0', '1','hussnul32@gmail.com','03072198063')");
    await db.rawInsert(
        "insert into contacts values ('1', 'M', 'Saqib', 'pic1', '1','sajjaddsaqib12@gmail.com','02302030')");
    await db.rawInsert(
        "insert into contacts values ('2', 'M', 'Sohaib', 'pic2', '1','Sohaib32@outlook.com','000120130411')");
    await db.rawInsert(
        "insert into contacts values ('3', 'M', 'Umer', 'pic3', '1','umer542@gmail.com','1930131931')");
    await db.rawInsert(
        "insert into contacts values ('4', 'M', 'Kazim', 'pic4', '1','kazim67@yahoo.com','13134114')");
    await db.rawInsert(
        "insert into contacts values ('5', 'M', 'Nouman', 'pic5', '1','nouman12@gmail.com','13414141')");
    await db.rawInsert(
        "insert into contacts values ('6', 'M', 'Zubair', 'pic6', '1','sohaib43@gmail.com','14141434')");
    await db.rawInsert(
        "insert into contacts values ('7', 'Maryam', 'said', 'pic7', '1','nabeel45@gmail.com','023423423')");
    await db.rawInsert(
        "insert into contacts values ('8', 'Noreen', 'kausar', 'pic8', '1','asad12@gmail.com','030567338')");
    await db.rawInsert(
        "insert into contacts values ('9', 'M', 'Sajjad', 'pic9', '1','abc12@yahoo.com','03076533782')");

    print('Command executed');
  }
//  ,folder_id int ,sender Text ,subject Text,mData Text, body Text,deleted_flag Text,
//account_id integer)";

  // Future<void> insertIntoOriginalMails(
  //     dynamic fid,
  //     String sender,
  //     String subject,
  //     String mData,
  //     String body,
  //     String deletedFlag,
  //     dynamic accountId) async {
  //   getNextid("emails").then((value) async {
  //     {
  //       print('Executing insertion command in original Emails Table...');
  //       await _db!.rawInsert(
  //           "insert into emails values ('$value','$fid','$sender', '$subject','$mData', '$body','$deletedFlag','$accountId')");
  //       print('Command executed in original Emails table   ');
  //     }
  //   });
  // }

  Future<void> insertIntoOriginalMails(Email a) async {
    print("Executing insertion commonds in into Original Emails table ");
    int t = await _db!.insert('Emails', a.toMap());
    print('Command executed in Emails table ');
    print("The value of t in emails by client table  is :" + t.toString());
  }

    Future<void> insertIntoFolderOriginal(FolderDetail a) async {
    print("Executing insertion commonds in into Original Folders table ");
    int t = await _db!.insert('Folders', a.toMap());
    print('Command executed in Folders table ');
    print("The value of t in Folders by client table  is :" + t.toString());
  }

  Future<void> insertActionData(EAction a) async {
    print("Executing insertion commonds in Actions table ");
    int t = await _db!.insert('actions', a.toMap());
    print('Command executed in Actions table ');
    print(t);
  }

  Future<void> insertIntoAccountData(
      String type,
      String email,
      String password,
      String confirmPassword,
      String smtpServer,
      int smtpPortNo,
      String imapServer,
      int imapPortNo) async {
    getNextid("accounts").then((value) async {
      print('Executing insertion command in Accounts Table...');
      await _db!.rawInsert(
          "insert into accounts values ('$value','$type', '$email', '$password', '$confirmPassword','$smtpServer','$smtpPortNo','$imapServer','$imapPortNo')");
      print('data inserted in Accounts table ');
    });
  }

  Future<List<Contact>> selectContactData() async {
    print('\n\n\nExecuting select command...in SelectAccount Data\n\n\n');
    var result = await _db!.rawQuery("select * from contacts");
    List<Contact> contactList = [];
    // result.forEach((element) =>
    // contactList.add(Contact.fromMap(element)));
    for (var res in result) {
      contactList.add(Contact.fromMap(res));
    }
    print("after adding data in account list in db $contactList");
    return contactList;
  }

  Future<List<Account>> selectAccountData() async {
    print('\n\n\nExecuting select command...in SelectAccount Data\n\n\n');
    var result = await _db!.rawQuery("select * from accounts");
    //print("result in select AccountData :$result");
    List<Account> accountList = [];
    result.forEach((element) => accountList.add(Account.fromMap(element)));
    print("after adding data in account list in db\n\n\n $accountList");
    return accountList;
  }

  Future<List<Email>> getData(String fname, int accId) async {
    print('Executing select command...');
    var result = await _db!.rawQuery(
        "select * from emails where folder_name=$fname and  account_id = $accId");
    List<Email> elist = [];
    result.forEach((element) => elist.add(Email.fromMap(element)));
    return elist;
  }

  Future<List<Map<String, dynamic>>> deleteMail(int eid) async {
    print('Executing delete command...');
    // var result = await _db!
    //     .rawQuery("update Email set deleted_flag = true where mid=$eid");
    var result = await _db!.rawQuery("DELETE FROM emails WHERE id=$eid");
    print('Delete command executed...');
    return result;
  }

  Future<List<Map<String, dynamic>>> deleteFolder(int fid) async {
    print('Executing delete command...');
    // var result = await _db!
    //     .rawQuery("update Email set deleted_flag = true where mid=$eid");
    var result = await _db!.rawQuery("DELETE FROM folders WHERE id=$fid");
    print('Delete command executed...');
    return result;
  }

  Database? getDB() {
    return _db;
  }

  void UpdateEmail(int fid, int eid) async {
    print('folder_id: $fid');
    print('mail_id : $eid');

    String query = "Update emails set folder_id=$fid where id =$eid";
    await _db!.rawUpdate(query);
  }

  void UpdateFolder(int id, int pid) async {
    print('folder_id: $id');
    print('parent_id : $pid');

    String query = "Update folders set folder_id=$pid where id =$id";
    await _db!.rawUpdate(query);
  }

  Future<int> getNextid(String tablename) async {
    var result = await _db!.rawQuery("select * from $tablename");//id =50
    int id = 1;

    result.forEach((element) {
      print('ID in $tablename =' + id.toString());
      id++;
    });
    return id;
  }

  Future<List<FolderDetail>> GetFoldersDetail() async {
    List<FolderDetail> folders = [];
    print('fetching data.... ');
    var result = await _db!.rawQuery("select * from folders");
    print('Result ::');
    print(result);
    result.forEach((element) {
      FolderDetail dbf = FolderDetail();
      dbf.name = element["name"].toString();
      dbf.id = element["id"] as int;
      dbf.fid = element["folder_id"] ;
      folders.add(dbf);

      print("name is :::" + dbf.name.toString());
      print("id is :::" + dbf.id.toString());
    });

    print(folders);
    return folders;
  }
}
