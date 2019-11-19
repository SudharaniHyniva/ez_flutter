class ClassAssignmentsVO{
  final int id;
  final String description;
  final String createdBy;
  final String date;
  final int studyClassId;
  final String classAndSection;
  final int subjectId;
  final String subjectName;
  final String status;

  ClassAssignmentsVO({
    this.description,
    this.id,
    this.createdBy,
    this.date,
    this.studyClassId,
    this.classAndSection,
    this.subjectId,
    this.subjectName,
    this.status,

  });
  factory ClassAssignmentsVO.fromJson(Map<String, dynamic> json) {
    return ClassAssignmentsVO(
        description: json['description'],
        id: json['id'],
        createdBy: json['createdBy'],
        date: json['date'],
        studyClassId: json['studyClassId'],
        classAndSection: json['classAndSection'],
        subjectId: json['subjectId'],
        subjectName: json['subjectName'],
        status: json['status'],

    );
  }
}

