class FolderDetail {
  dynamic id;
  late String name;
  dynamic fid;
  List<FolderDetail> childrens = [];
  FolderDetail() {}
  FolderDetail.jsonMap(Map<String, dynamic> map) {
    id = map['fid'];
    name = map['fName'];
    fid = map['pid'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = <String, dynamic>{};

    mp['id'] = fid;
    mp['name'] = name;
    mp['folder_id'] = fid;
    return mp;
  }

  void getChildHeirachy(List<FolderDetail> sub, FolderDetail f) {
    print('inside get herirchy...');
    print('length of subfolders ' + sub.length.toString());
    print(f.name + " searching its childs..." + f.id.toString());
    var lst = sub.where((element) => element.fid == f.id);
    print('list childs are ' + lst.length.toString());
    lst.forEach((element) {
      print('adding child of ' + f.name + "  as " + element.name);
      f.childrens.add(element);
    });
    if (f.childrens.isEmpty) return;
    for (int i = 0; i < f.childrens.length; i++) {
      getChildHeirachy(sub, f.childrens[i]);
    }
    print("f.children list is " + f.childrens.toString());
  }

  List<FolderDetail> getFolderHirerachy(List<FolderDetail> allfolders) {
    print('printing all folders...');
    allfolders.forEach((e) {
      print(e.name.toString() + " id::" + e.id.toString() + " pid" + e.fid);
    });
    print(allfolders);
    List<FolderDetail> flist = [];
    var pfolders = allfolders.where((element) => int.parse(element.fid) == -1);
    pfolders.forEach((e) {
      print(e);
      flist.add(e);
    });

    var i = allfolders.where((element) => element.fid == -1);
    List<FolderDetail> subfolders = [];
    i.forEach((element) {
      subfolders.add(element);
    });

    for (int i = 0; i < flist.length; i++) {
      getChildHeirachy(subfolders, flist[i]);
    }
    print("printing final list....");
    print(flist);

    return flist;
  }
}
