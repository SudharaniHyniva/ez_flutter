class TaskDetails{
  int id;
  String taskName;
  String date;
  String reminder;
  DateTime specificDate;
  String description;
  bool mobileService;
  bool emailService;
  String createdBy;

  TaskDetails({
    this.id,
    this.taskName,
    this.date,
    this.reminder,
    this.specificDate,
    this.description,
    this.mobileService,
    this.emailService,
    this.createdBy
  });
  factory TaskDetails.fromJson(Map<String, dynamic> json) {
    return TaskDetails(
        id: json['id'],
        taskName: json['taskName'],
        date: json['date'],
        reminder: json['reminder'],
        specificDate: json['specificDate'],
        description: json['description'],
        mobileService: json['mobileService'],
        emailService: json['emailService'],
        createdBy: json['createdBy']
    );
  }
}
