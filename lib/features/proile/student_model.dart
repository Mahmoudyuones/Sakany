class StudentModel {
  final String studentId;
  final String userId;
  final String firstName;
  final String lastName;
  final String fullName;
  final String? collegeName;
  final int age;
  final String? origin;
  final String? profilePhoto;
  final String? gender;
  final String? phoneNumber;
  final String? religon;
  final String? createdAt;
  final String? updatedAt;

  StudentModel({
    required this.studentId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    this.collegeName,
    required this.age,
    this.origin,
    this.profilePhoto,
    this.gender,
    this.phoneNumber,
    this.religon,
    this.createdAt,
    this.updatedAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      studentId: json['studentId'],
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      collegeName: json['collegeName'],
      age: json['age'],
      origin: json['origin'],
      profilePhoto: json['profilePhoto'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      religon: json['religon'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
