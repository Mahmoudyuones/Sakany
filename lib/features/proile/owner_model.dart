class OwnerModel {
  final String ownerId;
  final String userId;
  final String firstName;
  final String lastName;
  final String fullName;
  final String residence;
  final String? gender;
  final String religion;
  final String phoneNumber;
  final String profilePhoto;
  final String frontId;
  final String backId;
  final String verificationStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  OwnerModel({
    required this.ownerId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.residence,
    this.gender,
    required this.religion,
    required this.phoneNumber,
    required this.profilePhoto,
    required this.frontId,
    required this.backId,
    required this.verificationStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      ownerId: json['ownerId'] ?? '',
      userId: json['userId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '',
      residence: json['residence'] ?? '',
      gender: json['gender'],
      religion: json['religion'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profilePhoto: json['profilePhoto'] ?? '',
      frontId: json['frontId'] ?? '',
      backId: json['backId'] ?? '',
      verificationStatus: json['verificationStatus'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? '1970-01-01T00:00:00Z'),
      updatedAt: DateTime.parse(json['updatedAt'] ?? '1970-01-01T00:00:00Z'),
    );
  }
}
