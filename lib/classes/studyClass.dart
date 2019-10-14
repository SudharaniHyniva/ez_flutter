class StudyClass {
  int id;
  String className;
  String noOfSection;
  String sortingOrder;

  StudyClass({
    this.id,
    this.className,
    this.noOfSection,
    this.sortingOrder,
  });

  factory StudyClass.fromJson(Map<String, dynamic> json) {
    return StudyClass(
      id: json['id'],
      className: json['className'],
      noOfSection: json['noOfSection'],
      sortingOrder:  json['sortingOrder'],
    );
  }
}