// ignore: file_names
import 'package:pst1/Screens/inbox_page.dart';
import 'package:pst1/models/folder.dart';
import 'package:sqflite/sqflite.dart';

import '../HelperClasses/folder_details.dart';
import '../models/account.dart';
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
            "create table folders(id integer primary key  ,name Text,account_id int,folder_id integer default null)";
        await db.execute(query);
        print('folders table created....');
        query =
            "create table contacts(id integer primary key ,first_name Text,last_name Text, picture Text,account_id integer)";
        await db.execute(query);
        print('contacts table created....');

        query =
            " create table emails(id int primary key ,folder_id int ,sender Text ,subject Text,mData Text, body Text,deleted_flag Text,account_id integer)";
        await db.execute(query);
        print(
            'emails table created....'); //action type==mail pr ya folder pr laga?
        query =
            "create table actions(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,type Text ,value Text ,source Text,destination Text, TDatetime datetime)";
        await db.execute(query);
        _db = db;

        print('actions table created....');
        //await insertAccountData(db);
        await insertFolderData(db);
        await insertContactsData(db);
        await insertEmailData(db);
      }).then((value) {
        print('_db is intialized... ');
        _db = value;
      });
    }
  }

  Future<void> insertData(int id, String name, int accId, int folderId) async {
    getNextid("folders").then((value) async {
      {
        print('Executing insertion command in Action Table...');
        await _db!.rawInsert(
            "insert into folders values ('$value', '$name', '$accId','$folderId')");
        print('Command executed');
      }
    });
  }

  Future<void> insertFolderData(Database db) async {
    print('Executing insertion command in Folder Table...');

    await db.rawInsert("insert into folders values (0, 'inbox', '1', -1)");
    await db
        .rawInsert("insert into folders values (9, 'sub inbox 2 ', '1', 0)");
    await db
        .rawInsert("insert into folders values (10, 'sub inbox 3 ', '1', 0)");
    await db.rawInsert("insert into folders values (1, 'drafts', '1', -1)");
    await db.rawInsert("insert into folders values (2, 'Archieve', '1', -1)");
    await db.rawInsert("insert into folders values (3, 'sent', '1', -1)");
    await db.rawInsert("insert into folders values (4, 'deleted', '1', -1)");
    await db.rawInsert("insert into folders values (5, 'junk', '1', -1)");
    await db.rawInsert("insert into folders values (6, 'sub inbox 1', '1', 0)");
    await db
        .rawInsert("insert into folders values (7, 'sub drafts 1 ', '1', 1)");
    await db
        .rawInsert("insert into folders values (11, 'sub draft 2 ', '1', 1)");
    await db
        .rawInsert("insert into folders values (8, 'sub junks 1 ', '1', 5)");

    await db
        .rawInsert("insert into folders values (12, 'sub draft 3 ', '1', 11)");
    await db.rawInsert(
        "insert into folders values (13, 'sub draft 3.3 ', '1', 12)");

    print('Command executed');
  }

  Future<void> insertContactsData(Database db) async {
    print('Executing insertion command in Contact Table...');
    await db.rawInsert(
        "insert into contacts values ('0', 'Hussnul', 'Maab', 'pic0', '1')");
    await db.rawInsert(
        "insert into contacts values ('1', 'M', 'Saqib', 'pic1', '1')");
    await db.rawInsert(
        "insert into contacts values ('2', 'M', 'Sohaib', 'pic2', '1')");
    await db.rawInsert(
        "insert into contacts values ('3', 'M', 'Umer', 'pic3', '1')");
    await db.rawInsert(
        "insert into contacts values ('4', 'M', 'Kazim', 'pic4', '1')");
    await db.rawInsert(
        "insert into contacts values ('5', 'M', 'Nouman', 'pic5', '1')");
    await db.rawInsert(
        "insert into contacts values ('6', 'M', 'Zubair', 'pic6', '1')");
    await db.rawInsert(
        "insert into contacts values ('7', 'Maryam', 'said', 'pic7', '1')");
    await db.rawInsert(
        "insert into contacts values ('8', 'Noreen', 'kausar', 'pic8', '1')");
    await db.rawInsert(
        "insert into contacts values ('9', 'M', 'Sajjad', 'pic9', '1')");

    print('Command executed');
  }



  Future<void> insertIntoOriginalMails(
  
   dynamic fid,
   dynamic accountId,
   String sender,
   String subject,
   String mData,
   String body
      ) async {
    getNextid("emails").then((value) async {
      {
        print('Executing insertion command in original Emails Table...');
        await _db!.rawInsert(
            "insert into emails values ('$value','$fid','$accountId', '$sender', '$subject', '$body')");
        print('Command executed in original Emails table   ');
      }
    });
  }
  Future<void> insertEmailData(
    Database db,
  ) async {
    print('Executing insertion command in Email Table...');

    await db.rawInsert(
        "insert into emails values ('1','0','sohaib@gmail.com','Final year project','','Hello! Maab how is your Fyp going?...','false','1')");
    await db.rawInsert(
        "insert into emails values ('11','0','sohaib@gmail.com','Browsing Files','','Hello! Maab how is your Fyp going?...','false','2')");
    await db.rawInsert(
        "insert into emails values ('12','0','sohaib@gmail.com','Comosing','','Hello! Maab how is your Fyp going?...','false','1')");
    await db.rawInsert(
        "insert into emails values ('13','0','sohaib@gmail.com','Text Field initializing','','Hello! Maab how is your Fyp going?...','false','2')");
    await db.rawInsert(
        "insert into emails values ('14','0','sohaib@gmail.com','Search Data','','Hello! Maab how is your Fyp going?...','false','1')");
    await db.rawInsert(
        "insert into emails values ('7','0','sadaqah@mail.islamnet.com','New assignment:Pre mid  ','','Please submit your Q2 here','false','2')");

    await db.rawInsert(
        "insert into emails values ('2','1','saqib@gmail.com','Biit Trial 5 outing','','Hi! Are you going on trial 5?...','false','1')");

    await db.rawInsert(
        "insert into emails values ('40','1','saqib@gmail.com','Biit Trial 5 outing','','Hi! Are you going on trial 5?...','false','2')");
    await db.rawInsert(
        "insert into emails values ('15','1','saqib@gmail.com','Screens','','Hi! Are you going on trial 5?...','false','1')");
    await db.rawInsert(
        "insert into emails values ('16','1','saqib@gmail.com','Mockups','','Hi! Are you going on trial 5?...','false','2')");
    await db.rawInsert(
        "insert into emails values ('17','1','saqib@gmail.com','Meeting on Monday','','Hi! Are you going on trial 5?...','false','1')");
    await db.rawInsert(
        "insert into emails values ('18','1','saqib@gmail.com','Browser','','Hi! Are you going on trial 5?...','false','2')");
    await db.rawInsert(
        "insert into emails values ('8','1','noreply@notifications.freelancer.com','	PROJECT DESCRIPTION','','Here are the latest projects and contests matching your skills','false','1')");

    await db.rawInsert(
        "insert into emails values ('3','2','umer@gmail.com','Sql in Fyp','','AOA! how to connect sql in flutter? ...','false','2')");
    await db.rawInsert(
        "insert into emails values ('9','2','noreply@notifications.linkedin.com','LinkedIn Job Alerts','','30+ new jobs in Rawalpindi, Punjab, Pakistan match your preferences.','false','1')");

    await db.rawInsert(
        "insert into emails values ('19','2','umer@gmail.com','SqlLite in Android ','','AOA! how to connect sql in flutter? ...','false','2')");
    await db.rawInsert(
        "insert into emails values ('20','2','umer@gmail.com','Reading ','','AOA! how to connect sql in flutter? ...','false','1')");
    await db.rawInsert(
        "insert into emails values ('21','2','umer@gmail.com','Ego is Enemy book','','AOA! how to connect sql in flutter? ...','false','2')");
    await db.rawInsert(
        "insert into emails values ('22','2','umer@gmail.com','Splash colors','','AOA! how to connect sql in flutter? ...','false','1')");

    await db.rawInsert(
        "insert into emails values ('4','3','umer@gmail.com','Faizan Abbas (Classroom)','','Database Management System Book','false','2')");
    await db.rawInsert(
        "insert into emails values ('10','3','noreply@notifications.Rozee.com','Nutech Vocational Notifications ','','You are eligible to apply here.','false','1')");

    await db.rawInsert(
        "insert into emails values ('23','3','umer@gmail.com','Faizan Abbas (Classroom)','','Database Management System Book','false','2')");
    await db.rawInsert(
        "insert into emails values ('24','3','umer@gmail.com','Faizan Abbas (Classroom)','','Database Management System Book','false','1')");
    await db.rawInsert(
        "insert into emails values ('25','3','umer@gmail.com','Faizan Abbas (Classroom)','','Database Management System Book','false','2')");
    await db.rawInsert(
        "insert into emails values ('26','3','umer@gmail.com','Faizan Abbas (Classroom)','','Database Management System Book','false','1')");

    await db.rawInsert(
        "insert into emails values ('5','4','jobalerts-noreply@linkedin.com','Linked in job alert','','Your job alert for De+Montfort+University','false','2')");
    await db.rawInsert(
        "insert into emails values ('36','4','noreply@notifications.linkedin.com','Rozee.pk job Alerts','','New jobs in Lahore, Punjab, Pakistan match your preferences.','false','1')");

    await db.rawInsert(
        "insert into emails values ('27','4','jobalerts-noreply@linkedin.com','Canada job Alert','','Your job alert for De+Montfort+University','false','2')");
    await db.rawInsert(
        "insert into emails values ('28','4','jobalerts-noreply@linkedin.com','Flutter dev in Germany','','Your job alert for De+Montfort+University','false','1')");
    await db.rawInsert(
        "insert into emails values ('29','4','jobalerts-noreply@linkedin.com','Fifa worldcup','','Your job alert for De+Montfort+University','false','2')");
    await db.rawInsert(
        "insert into emails values ('30','4','jobalerts-noreply@linkedin.com','Psl new anthem','','Your job alert for De+Montfort+University','false','1')");
    await db.rawInsert(
        "insert into emails values ('31','4','jobalerts-noreply@linkedin.com','Imran khan new compain','','Your job alert for De+Montfort+University','false','2')");

    await db.rawInsert(
        "insert into emails values ('6','5','sadaqah@mail.islamnet.com','Islam net','','Assalamu Alaykum Hussnul, may Allah give you good health and a long life!','false','1')");
    await db.rawInsert(
        "insert into emails values ('32','5','noreply@notifications.linkedin.com','PMAS Ms Program','','Do you like to enroll in KJP?','false','2')");
    await db.rawInsert(
        "insert into emails values ('33','5','noreply@notifications.linkedin.com','Comset Ms Program','','Do you like to enroll in KJP?','false','1')");
    await db.rawInsert(
        "insert into emails values ('34','5','noreply@notifications.linkedin.com','Nutech Ms Program','','Do you like to enroll in KJP?','false','2')");
    await db.rawInsert(
        "insert into emails values ('35','5','noreply@notifications.linkedin.com','Fast Ms program','','Do you like to enroll in KJP?','false','1')");

    print('Command executed');
  }

  //         "create table accounts(id integer primary key ,type Text,email Text, pass Text)";

  Future<void> insertActionData(String actionType, String aValue,
      String sourceField, String destField, DateTime tDatetime) async {
    getNextid("actions").then((value) async {
      {
        print('Executing insertion command in Action Table...');
        await _db!.rawInsert(
            "insert into actions values ('$value','$actionType','$aValue', '$sourceField', '$destField', '$tDatetime')");
        print('Command executed in Actions table ');
      }
    });
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

  Future<List<Account>> selectAccountData() async {
    print('\n\n\nExecuting select command...in SelectAccount Data\n\n\n');
    var result = await _db!.rawQuery("select * from accounts");
    //print("result in select AccountData :$result");
    List<Account> accountList = [];
    result.forEach((element) => accountList.add(Account.fromMap(element)));
    print("after adding data in account list in db\n\n\n $accountList");
    return accountList;
  }

  Future<List<Email>> getData(int fid, int accId) async {
    print('Executing select command...');
    var result = await _db!.rawQuery(
        "select * from emails where folder_id=$fid and  account_id = $accId");
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
    var result = await _db!.rawQuery("select * from $tablename");
    int id = 1;

    result.forEach((element) {
      print('ID in $tablename =' + id.toString());
      id++;
    });
    return id;
  }

  // Future<List<DropBoxFolders>> GetFolder() async {
  //   List<DropBoxFolders> folders = [];
  //   print('fetching data.... ');
  //   var result = await _db!.rawQuery("select * from folders");
  //   print('Result ::');
  //   print(result);
  //   result.forEach((element) {
  //     DropBoxFolders dbf = DropBoxFolders();
  //     dbf.name = element["name"].toString();
  //     dbf.pid = element["id"] as int;
  //     dbf.fid = element["folder_id"] as int;
  //     folders.add(dbf);

  //     print("name is :::" + dbf.name.toString());
  //     print("id is :::" + dbf.pid.toString());
  //   });
  //   for (int i = 0; i < folders.length; i++) {
  //     String q = "Select name from folders where folder_id='" +
  //         folders[i].pid.toString() +
  //         "'";
  //     print("Query =$q");

  //     var rresult = await _db!.rawQuery(q);
  //     print('executed...');

  //     rresult.forEach((element) {
  //       folders[i].childfodlers.add(
  //             element["name"].toString(),
  //           );
  //       folders[i].childfodlers.add(
  //             element["id"].toString(),
  //           );
  //     });
  //     print('Returning   ');
  //     print(folders);
  //   }

  //   return folders;
  // }

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
      dbf.fid = element["folder_id"] as int;
      folders.add(dbf);

      print("name is :::" + dbf.name.toString());
      print("id is :::" + dbf.id.toString());
    });

    print(folders);

    return folders;
  }


}
