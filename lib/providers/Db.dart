import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:pst1/models/folder.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Mail.dart';

class DBHandler {
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
  static DBHandler? _instance = null;
  int v = 20;
  DBHandler._Init() {
    _createDB();
  }
  static Future<DBHandler> getInstnace() async {
    if (_instance == null) _instance ??= DBHandler._Init();

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
        //String query = '''
        // create table account(ac_id int primary key ,acc_type varchar(40),acc_email varchar(50), acc_pass varchar(50));
        // create table folder(fid int primary key ,fname varchar(50),acc_id int foreign key references account);
        // create table contacts(contact_id int primary key ,first_name varchar(60),last_name varchar(60), picture varchar(1000),acc_id int foreign key references account);
        // create table Email(mid int primary key ,fid int foreign key references folder ,sender varchar(60) ,subject varchar(1000),mData varchar(1000), body varchar(2000));
        // create table Action(action_id int primary key ,action_type varchar(60) ,action_value varchar(60),source_field varchar(50),destination_field varchar(1000), TDatetime datetime);
        // ''';
        String query =
            "create table account(ac_id int primary key ,acc_type varchar(40),acc_email varchar(50), acc_pass varchar(50))";

        await db.execute(query);
        print('Account table created...');
        query =
            "create table folder(fid int primary key ,fname varchar(50),acc_id int,parent_Folder varchar(50))";
        await db.execute(query);
        print('Folder table created....');
        query =
            "create table contacts(contact_id int primary key ,first_name varchar(60),last_name varchar(60), picture varchar(1000),acc_id int)";
        await db.execute(query);
        print('contacts table created....');

        query =
            " create table Email(mid int primary key ,fid int ,sender varchar(60) ,subject varchar(1000),mData varchar(1000), body varchar(2000),deleted_flag varchar(30))";
        await db.execute(query);
        print(
            'Email table created....'); //action type==mail pr ya folder pr laga?
        query =
            "create table Action(action_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,action_Type varchar(50) ,AValue varchar(60) ,source_field varchar(1000),dest_field varchar(1000), TDatetime datetime)";
        await db.execute(query);
        _db = db;

        print('Action table created....');
        await insertAccountData(db);
        await insertFolderData(db);
        await insertContactsData(db);

        await insertEmailData(db);
      }).then((value) {
        print('_db is intialized... ');
        _db = value;
      });
    }
  }

  Future<void> insertData(
      int id, String name, int accId, String parentName) async {
    print('Executing insertion command...');
    await _db!.rawInsert(
        "insert into folder values ('$id', '$name', '$accId','$parentName')");
    print('Command executed');
  }

//create table Action(Action_id int primary key,Action_Type varchar(50),AValue varchar(60),field1_S varchar(50),field2_D varchar(50),TDatetime datetime2)
  Future<void> insertAccountData(Database db) async {
    print('Executing insertion command...');

    await db.rawInsert(
        "insert into Account values ('1', 'yahoo', 'abc@yahoo.com', '123')");
    print('inserted...');
    await db.rawInsert(
        "insert into Account values ('2', 'gmail', 'abc@gmail.com', '123')");
    await db.rawInsert(
        "insert into Account values ('3', 'outlook', 'abc@outlook.com', '123')");
    print('Command executed');
  }

  Future<void> insertFolderData(Database db) async {
    print('Executing insertion command in Folder Table...');

    await db.rawInsert("insert into folder values ('0', 'inbox', '1','null')");
    await db.rawInsert("insert into folder values ('1', 'drafts', '1','null')");
    await db
        .rawInsert("insert into folder values ('2', 'Archieve', '1','null')");
    await db.rawInsert("insert into folder values ('3', 'sent', '1','null')");
    await db
        .rawInsert("insert into folder values ('4', 'deleted', '1','null')");
    await db.rawInsert("insert into folder values ('5', 'junk', '1','null')");

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

  Future<void> insertEmailData(Database db) async {
    print('Executing insertion command in Email Table...');

    await db.rawInsert(
        "insert into Email values ('1','0','sohaib@gmail.com','Final year project','','Hello! Maab how is your Fyp going?...','false')");
    await db.rawInsert(
        "insert into Email values ('11','0','sohaib@gmail.com','Browsing Files','','Hello! Maab how is your Fyp going?...','false')");
    await db.rawInsert(
        "insert into Email values ('12','0','sohaib@gmail.com','Comosing','','Hello! Maab how is your Fyp going?...','false')");
    await db.rawInsert(
        "insert into Email values ('13','0','sohaib@gmail.com','Text Field initializing','','Hello! Maab how is your Fyp going?...','false')");
    await db.rawInsert(
        "insert into Email values ('14','0','sohaib@gmail.com','Search Data','','Hello! Maab how is your Fyp going?...','false')");
    await db.rawInsert(
        "insert into Email values ('7','0','sadaqah@mail.islamnet.com','New assignment:Pre mid  ','','Please submit your Q2 here','false')");

    await db.rawInsert(
        "insert into Email values ('2','1','saqib@gmail.com','Biit Trial 5 outing','','Hi! Are you going on trial 5?...','false')");

    await db.rawInsert(
        "insert into Email values ('40','1','saqib@gmail.com','Biit Trial 5 outing','','Hi! Are you going on trial 5?...','false')");
    await db.rawInsert(
        "insert into Email values ('15','1','saqib@gmail.com','Screens','','Hi! Are you going on trial 5?...','false')");
    await db.rawInsert(
        "insert into Email values ('16','1','saqib@gmail.com','Mockups','','Hi! Are you going on trial 5?...','false')");
    await db.rawInsert(
        "insert into Email values ('17','1','saqib@gmail.com','Meeting on Monday','','Hi! Are you going on trial 5?...','false')");
    await db.rawInsert(
        "insert into Email values ('18','1','saqib@gmail.com','Browser','','Hi! Are you going on trial 5?...','false')");
    await db.rawInsert(
        "insert into Email values ('8','1','noreply@notifications.freelancer.com','	PROJECT DESCRIPTION','','Here are the latest projects and contests matching your skills','false')");

    await db.rawInsert(
        "insert into Email values ('3','2','umer@gmail.com','Sql in Fyp','','AOA! how to connect sql in flutter? ...','false')");
    await db.rawInsert(
        "insert into Email values ('9','2','noreply@notifications.linkedin.com','LinkedIn Job Alerts','','30+ new jobs in Rawalpindi, Punjab, Pakistan match your preferences.','false')");

    await db.rawInsert(
        "insert into Email values ('19','2','umer@gmail.com','SqlLite in Android ','','AOA! how to connect sql in flutter? ...','false')");
    await db.rawInsert(
        "insert into Email values ('20','2','umer@gmail.com','Reading ','','AOA! how to connect sql in flutter? ...','false')");
    await db.rawInsert(
        "insert into Email values ('21','2','umer@gmail.com','Ego is Enemy book','','AOA! how to connect sql in flutter? ...','false')");
    await db.rawInsert(
        "insert into Email values ('22','2','umer@gmail.com','Splash colors','','AOA! how to connect sql in flutter? ...','false')");

    await db.rawInsert(
        "insert into Email values ('4','3','umer@gmail.com','Faizan Abbas (Classroom)','','Database Management System Book','false')");
    await db.rawInsert(
        "insert into Email values ('10','3','noreply@notifications.Rozee.com','Nutech Vocational Notifications ','','You are eligible to apply here.','false')");

    await db.rawInsert(
        "insert into Email values ('23','3','umer@gmail.com','Faizan Abbas (Classroom)','','Database Management System Book','false')");
    await db.rawInsert(
        "insert into Email values ('24','3','umer@gmail.com','Faizan Abbas (Classroom)','','Database Management System Book','false')");
    await db.rawInsert(
        "insert into Email values ('25','3','umer@gmail.com','Faizan Abbas (Classroom)','','Database Management System Book','false')");
    await db.rawInsert(
        "insert into Email values ('26','3','umer@gmail.com','Faizan Abbas (Classroom)','','Database Management System Book','false')");

    await db.rawInsert(
        "insert into Email values ('5','4','jobalerts-noreply@linkedin.com','Linked in job alert','','Your job alert for De+Montfort+University','false')");
    await db.rawInsert(
        "insert into Email values ('36','4','noreply@notifications.linkedin.com','Rozee.pk job Alerts','','New jobs in Lahore, Punjab, Pakistan match your preferences.','false')");

    await db.rawInsert(
        "insert into Email values ('27','4','jobalerts-noreply@linkedin.com','Canada job Alert','','Your job alert for De+Montfort+University','false')");
    await db.rawInsert(
        "insert into Email values ('28','4','jobalerts-noreply@linkedin.com','Flutter dev in Germany','','Your job alert for De+Montfort+University','false')");
    await db.rawInsert(
        "insert into Email values ('29','4','jobalerts-noreply@linkedin.com','Fifa worldcup','','Your job alert for De+Montfort+University','false')");
    await db.rawInsert(
        "insert into Email values ('30','4','jobalerts-noreply@linkedin.com','Psl new anthem','','Your job alert for De+Montfort+University','false')");
    await db.rawInsert(
        "insert into Email values ('31','4','jobalerts-noreply@linkedin.com','Imran khan new compain','','Your job alert for De+Montfort+University','false')");

    await db.rawInsert(
        "insert into Email values ('6','5','sadaqah@mail.islamnet.com','Islam net','','Assalamu Alaykum Hussnul, may Allah give you good health and a long life!','false')");
    await db.rawInsert(
        "insert into Email values ('32','5','noreply@notifications.linkedin.com','PMAS Ms Program','','Do you like to enroll in KJP?','false')");
    await db.rawInsert(
        "insert into Email values ('33','5','noreply@notifications.linkedin.com','Comset Ms Program','','Do you like to enroll in KJP?','false')");
    await db.rawInsert(
        "insert into Email values ('34','5','noreply@notifications.linkedin.com','Nutech Ms Program','','Do you like to enroll in KJP?','false')");
    await db.rawInsert(
        "insert into Email values ('35','5','noreply@notifications.linkedin.com','Fast Ms program','','Do you like to enroll in KJP?','false')");

    print('Command executed');
  }

  Future<void> insertActionData(String action_type, String Avalue,
      String source_field, String dest_field, DateTime TDatetime) async {
    print('Executing insertion command in Contact Table...');

    await _db!.rawInsert(
        "insert into Action values ('$action_type','$Avalue', '$source_field', '$dest_field', '$TDatetime')");

    print('Command executed');
  }

  Future<List<Email>> getData(int fid) async {
    print('Executing select command...');
    var result = await _db!.rawQuery("select * from Email where fid=$fid");
    List<Email> elist = [];
    result.forEach((element) => elist.add(Email.fromMap(element)));
    return elist;
  }

  Future<List<Map<String, dynamic>>> deleteMail(int eid) async {
    print('Executing delete command...');
    // var result = await _db!
    //     .rawQuery("update Email set deleted_flag = true where mid=$eid");
    var result = await _db!.rawQuery("DELETE FROM Email WHERE mid=$eid");
    print('Delete command executed...');
    return result;
  }

  Database? getDB() {
    return _db;
  }

  void UpdateEmail(int fid, int eid) async {
    print('fid: $fid');
    print('eid : $eid');

    String query = "Update Email set fid=$fid where mid =$eid";
    await _db!.rawUpdate(query);
  }

  Future<int> getNextid(String tablename) async {
    var result = await _db!.rawQuery("select * from $tablename ");
    int id = 1;
    result.forEach((element) {
      id++;
    });
    return id;
  }

  Future<List<DropBoxFolders>> GetFolder() async {
    List<DropBoxFolders> folders = [];
    print('fetching data.... ');
    var result = await _db!.rawQuery("select fname from Folder");
    print('Result ::');
    print(result);
    result.forEach((element) {
      DropBoxFolders dbf = DropBoxFolders();
      dbf.name = element["fname"].toString();
      folders.add(dbf);
      print(dbf.name);
    });
    for (int i = 0; i < folders.length; i++) {
      String q = "Select fname from Folder where parent_Folder='" +
          folders[i].name! +
          "'";
      print("Query =$q");

      var rresult = await _db!.rawQuery(q);
      print('executed...');

      rresult.forEach((element) {
        folders[i].childfodlers.add(element["fname"].toString());
      });
      print('Returning   ');
      print(folders);
    }

    return folders;
  }
}
// git remote add origin https://github.com/HussnulMaab192/PST-Mail-Handler-and-Sync.git