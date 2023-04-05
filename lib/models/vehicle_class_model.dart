class VehicleClass {
  int? classId;
  String? name;
  int? seats;
  String? icon;

  VehicleClass({this.classId, this.name, this.seats, this.icon});

  VehicleClass.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    name = json['name'];
    seats = json['seats'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_id'] = this.classId;
    data['name'] = this.name;
    data['seats'] = this.seats;
    data['icon'] = this.icon;
    return data;
  }
}
