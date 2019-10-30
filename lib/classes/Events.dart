class EventsVoList{
  int id;
  String eventDescription;
  String eventName;
  String startTime;
  String endTime;
  String eventFor;
  int academicYearId;
  int custId;
  int smsEventId;
  String status;
  String startDateTime;
  String endDateTime;
  int eventCreatedUserId;
  int studyClassIds;
  String includeNonTeachingStaff;

  EventsVoList({
    this.id,
    this.eventDescription,
    this.eventName,
    this.startTime,
    this.endTime,
    this.eventFor,
    this.academicYearId,
    this.custId,
    this.smsEventId,
    this.status,
    this.startDateTime,
    this.endDateTime,
    this.eventCreatedUserId,
    this.studyClassIds,
    this.includeNonTeachingStaff
  });
  factory EventsVoList.fromJson(Map<String, dynamic> json) {
    return EventsVoList(
        id:  json['id'],
        eventDescription: json['eventDescription'],
        eventName: json['eventName'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        eventFor: json['eventFor'],
        academicYearId: json['academicYearId'],
        custId: json['custId'],
        smsEventId: json['smsEventId'],
        status: json['status'],
        startDateTime: json['startDateTime'],
        endDateTime: json['endDateTime'],
        eventCreatedUserId: json['eventCreatedUserId'],
        studyClassIds: json['studyClassIds'],
        includeNonTeachingStaff: json['includeNonTeachingStaff']
    );
  }
}

