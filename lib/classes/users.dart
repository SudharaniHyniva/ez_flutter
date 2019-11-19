class Users {
  final int id;
  final String className;
  final int noOfSections;
  final int sortingOrder;
  final List<classNameVOs> classNameVO;

  Users({
    this.id,
    this.className,
    this.noOfSections,
    this.sortingOrder,
    this.classNameVO
  });

  factory Users.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['classNameVO'] as List;
    print(list.runtimeType);
    List<classNameVOs> classList = list.map((list) => classNameVOs.fromJson(list)).toList();
    return Users(
        id: parsedJson['id'],
        className: parsedJson['className'],
        noOfSections: parsedJson['noOfSections'],
        sortingOrder: parsedJson['sortingOrder'],
        classNameVO:classList
    );

  }

}
// ignore: camel_case_types
class classNameVOs {
  final int id;
  final String className;
  final int noOfSections;
  final int sortingOrder;
  final List<StudyClassList> studyClassList;

  classNameVOs({this.id,
    this.className,
    this.noOfSections,
    this.sortingOrder,
    this.studyClassList
    });

  factory classNameVOs.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['studyClassList'] as List;
    print(list);
    List<StudyClassList> studyClassList = list.map((list) => StudyClassList.fromJson(list)).toList();
    return classNameVOs(
      id: parsedJson['id'],
      className: parsedJson['className'],
      noOfSections: parsedJson['noOfSections'],
      sortingOrder: parsedJson['sortingOrder'],
        studyClassList: studyClassList
    );
  }
}
class StudyClassList{
  final int id;
  final String section;
  final int sectionCapacity;
  final String classNameAndSection;

  StudyClassList({
    this.id,
    this.section,
    this.sectionCapacity,
    this.classNameAndSection
  });

  factory StudyClassList.fromJson(Map<String, dynamic> json) {
    print(json['section']);
    return StudyClassList(
      id: json['id'],
      section: json['section'],
      sectionCapacity: json['sectionCapacity']

    );
  }
}

class ClassNameAndSection{
  String classNameAndSection;
  int studyClassId;
}