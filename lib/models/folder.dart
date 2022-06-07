class DropBoxFolders {
  String? name;
  late int pid;
  List<String> childfodlers = [];
}

class Folder {
  late int fid;
  late String fname;

  // ignore: non_constant_identifier_names
  late int acc_id;

  Folder(this.fid, this.fname, this.acc_id);
  int getmId() => fid;
  String getfanme() => fname;
  int accid() => acc_id;
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = <String, dynamic>{};
    mp['fid'] = fid;
    mp['fname'] = fname;
    mp['acc_id'] = acc_id;
    return mp;
  }

  Folder.fromMap(Map<String, dynamic> map) {
    fid = map['fid'];
    fname = map['fname'];
    acc_id = map['acc_id'];
  }
}
