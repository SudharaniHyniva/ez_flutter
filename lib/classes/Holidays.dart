
class SchoolHolidaysVOList{
  int id;
  String holidayDate;
  String startDate;
  String endDate;
  double noOfDays;
  String holidayDescription;
  String status;
  int monthId;
  //double yearId;
  //int classId;
 // String holiDaysFor;

  SchoolHolidaysVOList({
    this.id,
    this.holidayDate,
    this.startDate,
    this.endDate,
    this.noOfDays,
    this.holidayDescription,
    this.status,
    this.monthId,
    //this.yearId,
    //this.classId,
    //this.holiDaysFor
  });
  factory SchoolHolidaysVOList.fromJson(Map<String, dynamic> json) {
    return SchoolHolidaysVOList(
        id:  json['id'],
      holidayDate: json['holidayDate'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        noOfDays: json['noOfDays'],
        holidayDescription: json['holidayDescription'],
        status: json['status'],
        monthId: json['monthId'],
        //yearId: json['yearId'],
        //classId: json['classId'],
       // holiDaysFor: json['holiDaysFor']
    );
  }
}

