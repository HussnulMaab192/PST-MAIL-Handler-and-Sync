class FolderDetail {
  late int id;
  late String name;
  late int fid;
  List<FolderDetail> childrens = [];

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
      print(e.name.toString() +
          " id::" +
          e.id.toString() +
          " pid" +
          e.fid.toString());
    });
    print(allfolders);
    List<FolderDetail> flist = [];
    var pfolders = allfolders.where((element) => element.fid == -1);
    pfolders.forEach((e) {
      print(e);
      flist.add(e);
    });

    var i = allfolders.where((element) => element.fid != -1);
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
