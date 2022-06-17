class DropBoxFolders {
  String? name;
  late int pid;
  late int fid;
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
    mp['id'] = fid;
    mp['folder_name'] = fname;
    mp['account_id'] = acc_id;
    return mp;
  }

  Folder.fromMap(Map<String, dynamic> map) {
    fid = map['id'];
    fname = map['folder_name'];
    acc_id = map['account_id'];
  }
}
