class Reminders{
  int id;
  String name;
  String reminder;
  String expirationDate;
  String specificDate;
  String description;
  String receiverType;
  String staffType;
  String status;

  Reminders({
    this.id,
    this.name,
    this.reminder,
    this.expirationDate,
    this.specificDate,
    this.description,
    this.receiverType,
    this.staffType,
    this.status
  });
  factory Reminders.fromJson(Map<String, dynamic> json) {
    return Reminders(
        id: json['id'],
        name: json['name'],
        reminder: json['reminder'],
        expirationDate: json['expirationDate'],
        specificDate: json['specificDate'],
        description: json['description'],
        receiverType: json['receiverType'],
        staffType: json['staffType'],
        status: json['status']
    );
  }
}