class Item {
  late int mid;
  late int fid;
  late String sender;
  late String subject;
  late String mData;
  late String body;

  Item(this.mid, this.fid, this.sender, this.subject, this.mData, this.body);
  List<Item>? itemList;
  List<Item>? selectedList;


  void initState() {
    loadList();
  }

  void loadList() {}
}
