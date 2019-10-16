class StudyClass {
  int id;
  String section;
  int sectionCapacity;

  StudyClass({
    this.id,
    this.section,
    this.sectionCapacity,
  });

  factory StudyClass.fromJson(Map<String, dynamic> json) {
    return StudyClass(
      id: json['id'],
      section: json['section'],
      sectionCapacity: json['sectionCapacity'],
    );
  }
}