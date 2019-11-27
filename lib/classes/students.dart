class Student {
  int studentId;
  String firstName;
  String lastName;
  String fatherName;
  String mobileNumber;
  String motherName;
  String gender;
  String dateOfBirth;
  String street;
  String city;
  String stateName;
  String postalCode;
  int admissionNumber;
  int rollNumber;
  int imageId;
  String imageUrl;
  String studentMobile;
  String parentEmail;
  String parentId;
  String status;
  String transportMode;
  String description;
  String classSectionId;
  String accountId;
  String custId;
  String academicYearId;
  String boardingPointId;
  String stsNumber;
  String aadharNumber;
  final viewStudentPersonAccountDetailsVOs viewStudentPersonAccountDetailsVO;

  Student({
    this.studentId,
    this.firstName,
    this.lastName,
    this.fatherName,
    this.mobileNumber,
    this.motherName,
    this.gender,
    this.dateOfBirth,
    this.street,
    this.city,
    this.stateName,
    this.postalCode,
    this.admissionNumber,
    this.rollNumber,
    this.imageId,
    this.imageUrl,
    this.studentMobile,
    this.parentEmail,
    this.parentId,
    this.status,
    this.transportMode,
    this.description,
    this.classSectionId,
    this.accountId,
    this.custId,
    this.academicYearId,
    this.boardingPointId,
    this.stsNumber,
    this.aadharNumber,
    this.viewStudentPersonAccountDetailsVO
  });

  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['viewStudentPersonAccountDetailsVO'] ;
    print(list.runtimeType);
    viewStudentPersonAccountDetailsVOs classList = viewStudentPersonAccountDetailsVOs.fromJson(list);
    return Student(
      studentId: parsedJson['studentId'],
      firstName: parsedJson['firstName'],
      lastName: parsedJson['lastName'],
      fatherName: parsedJson['fatherName'],
      mobileNumber: parsedJson['mobileNumber'],
      motherName: parsedJson['motherName'],
      gender: parsedJson['gender'],
      dateOfBirth: parsedJson['dateOfBirth'],
      street: parsedJson['street'],
      city: parsedJson['city'],
      stateName: parsedJson['stateName'],
      postalCode: parsedJson['postalCode'],
      admissionNumber: parsedJson['admissionNumber'],
      rollNumber: parsedJson['rollNumber'],
      imageId: parsedJson['imageId'],
      imageUrl: parsedJson['imageUrl'],
      studentMobile: parsedJson['studentMobile'],
      parentEmail: parsedJson['parentEmail'],
      parentId: parsedJson['parentId'],
      status: parsedJson['status'],
      transportMode: parsedJson['transportMode'],
      description: parsedJson['description'],
      classSectionId: parsedJson['classSectionId'],
      accountId: parsedJson['accountId'],
      custId: parsedJson['custId'],
      academicYearId: parsedJson['academicYearId'],
      boardingPointId: parsedJson['boardingPointId'],
      stsNumber: parsedJson['stsNumber'],
      aadharNumber: parsedJson['aadharNumber'],
        viewStudentPersonAccountDetailsVO: classList
    );
  }
}

// ignore: camel_case_types
class viewStudentPersonAccountDetailsVOs{
  int studentId;
  String firstName;
  String lastName;
  String fatherName;
  String mobileNumber;
  String motherName;
  String gender;
  String dateOfBirth;
  String street;
  String city;
  String stateName;
  String postalCode;
  //int admissionNumber;
  int rollNumber;
  int imageId;
  String imageUrl;
  String studentMobile;
  String parentEmail;
  String parentId;
  String status;
  String transportMode;
  String description;
  int classSectionId;
  int accountId;
  String custId;
  String academicYearId;
  String boardingPointId;
  String stsNumber;
  String aadharNumber;

  viewStudentPersonAccountDetailsVOs({
    this.studentId,
    this.firstName,
    this.lastName,
    this.fatherName,
    this.mobileNumber,
    this.motherName,
    this.gender,
    this.dateOfBirth,
    this.street,
    this.city,
    this.stateName,
    this.postalCode,
    //this.admissionNumber,
    this.rollNumber,
    this.imageId,
    this.imageUrl,
    this.studentMobile,
    this.parentEmail,
    this.parentId,
    this.status,
    this.transportMode,
    this.description,
    this.classSectionId,
    this.accountId,
    this.custId,
    this.academicYearId,
    this.boardingPointId,
    this.stsNumber,
    this.aadharNumber,
  });
  factory viewStudentPersonAccountDetailsVOs.fromJson(Map<String, dynamic> json) {
    return viewStudentPersonAccountDetailsVOs(
      studentId: json['studentId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fatherName: json['fatherName'],
      mobileNumber: json['mobileNumber'],
      motherName: json['motherName'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      street: json['street'],
      city: json['city'],
      stateName: json['stateName'],
      postalCode: json['postalCode'],
     // admissionNumber: json['admissionNumber'],
      imageUrl: json['imageUrl'],
      studentMobile: json['studentMobile'],
      parentEmail: json['parentEmail'],

      status: json['status'],
      transportMode: json['transportMode'],
      description: json['description'],
      classSectionId : json['classSectionId'],
      accountId : json['accountId'],
      //rollNumber: json['rollNumber']

    );
  }
}