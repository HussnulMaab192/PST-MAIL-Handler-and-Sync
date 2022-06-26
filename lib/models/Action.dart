// ignore_for_file: non_constant_identifier_names

class EAction {
  int? action_id;
  late String action_type;
  late String action_value;
  late String source_field;
  late String destination_field;
  late DateTime TDatetime;
  late int object_id;

  EAction(
      {this.action_id,
      required this.action_type,
     required this.action_value,
      required this.source_field,
     required this.destination_field,
     required this.TDatetime,
      required this.object_id});

  int? getActiontId() => action_id;
  int getObjectId() => object_id;
  String getActiontype() => action_type;
  String getActionValue() => action_value;
  String getSource() => source_field;
  String getDestination() => destination_field;
  DateTime getDateTime() => TDatetime;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = <String, dynamic>{};
    mp['id'] = action_id;
    mp['type'] = action_type;
    mp['value'] = action_value;
    mp['source'] = source_field;
    mp['destination'] = destination_field;
    mp['TDatetime'] = destination_field;
    mp['object_id'] = object_id;
    return mp;
  }

  fromMap(Map<String, dynamic> map) {
    action_id = map['id'];
    action_type = map['type'];
    action_value = map['value'];
    source_field = map['source'];
    destination_field = map['destination'];
    TDatetime = map['TDatetime'];
    object_id = map['object_id'];
  }
}
