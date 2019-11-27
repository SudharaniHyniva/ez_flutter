class Users {
  final int id;
  final String className;
  final int noOfSections;
  final int sortingOrder;
  final List<classNameVOss> classNameVO;

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
    List<classNameVOss> classList = list.map((list) => classNameVOss.fromJson(list)).toList();
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
class classNameVOss {
  final int id;
  final String className;
  final int noOfSections;
  final int sortingOrder;
  final List<StudyClassLists> studyClassList;

  classNameVOss({this.id,
    this.className,
    this.noOfSections,
    this.sortingOrder,
    this.studyClassList
  });

  factory classNameVOss.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['studyClassList'] as List;
    print(list);
    List<StudyClassLists> studyClassList = list.map((list) => StudyClassLists.fromJson(list)).toList();
    return classNameVOss(
        id: parsedJson['id'],
        className: parsedJson['className'],
        noOfSections: parsedJson['noOfSections'],
        sortingOrder: parsedJson['sortingOrder'],
        studyClassList: studyClassList
    );
  }
}
class StudyClassLists{
  final int id;
  final String section;
  final int sectionCapacity;
  final String classNameAndSection;
  final List<StudySubjectList> studySubjectList;

  StudyClassLists({
    this.id,
    this.section,
    this.sectionCapacity,
    this.classNameAndSection,
    this.studySubjectList
  });
  factory StudyClassLists.fromJson(Map<String, dynamic> parsedJson){
    var list = parsedJson['studySubjectList'] as List;
    print(list);
    List<StudySubjectList> studySubjectList = list.map((list) => StudySubjectList.fromJson(list)).toList();
    return StudyClassLists(
        id: parsedJson['id'],
        section: parsedJson['section'],
        sectionCapacity: parsedJson['sectionCapacity'],
        studySubjectList:studySubjectList

    );
  }
}

class StudySubjectList{
  final int id;
  final String name;

  StudySubjectList({
    this.id,
    this.name,
  });

  factory StudySubjectList.fromJson(Map<String, dynamic> json) {
    return StudySubjectList(
        id: json['id'],
      name: json['name'],
    );
  }
}


class SubjectName{
  String name;
}
