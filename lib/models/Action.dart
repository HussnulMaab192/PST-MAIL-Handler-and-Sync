// ignore_for_file: non_constant_identifier_names

class EAction {
  late int action_id;
  late String action_type;
  late String action_value;
  late String source_field;
  late String destination_field;
  late DateTime TDatetime;

  EAction(
    this.action_id,
    this.action_type,
    this.action_value,
    this.source_field,
    this.destination_field,
    this.TDatetime,
  );

  int getActiontId() => action_id;
  String getActiontype() => action_type;
  String getActionValue() => action_value;
  String getSource() => source_field;
  String getDestination() => destination_field;
  DateTime getDateTime() => TDatetime;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mp = <String, dynamic>{};
    mp['action_id'] = action_id;
    mp['action_type'] = action_type;
    mp['action_value'] = action_value;
    mp['source_field'] = source_field;
    mp['destination_field'] = destination_field;
    mp['TDatetime'] = destination_field;
    return mp;
  }

  fromMap(Map<String, dynamic> map) {
    action_id = map['action_id'];
    action_type = map['action_type'];
    action_value = map['action_value'];
    source_field = map['source_field'];
    destination_field = map['destination_field'];
    TDatetime = map['TDatetime'];
  }
}
