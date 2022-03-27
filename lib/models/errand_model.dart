class ErrandModel {
  dynamic id;
  String label;
  dynamic status;
  String date;
  String priority;
  String notification;
  String observation;

  ErrandModel({
    this.id,
    required this.label,
    required this.status,
    required this.date,
    required this.priority,
    required this.notification,
    required this.observation,
  });

  factory ErrandModel.fromJson(Map<String, dynamic> json) => ErrandModel(
        id: json["id"],
        label: json["label"] as dynamic,
        status: json["status"] as dynamic,
        date: json["date"] as dynamic,
        priority: json["priority"] as dynamic,
        notification: json["notification"] as dynamic,
        observation: json["observation"] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "status": status as int,
        "date": date,
        "priority": priority,
        "notification": notification,
        "observation": observation,
      };
}
