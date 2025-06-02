class BedModel {
  final String id;
  final String roomId;
  final String? studentId;
  final double price;
  final bool isAC;
  final bool isVacant;
  final DateTime createdAt;
  final DateTime updatedAt;

  BedModel({
    required this.id,
    required this.roomId,
    this.studentId,
    required this.price,
    required this.isAC,
    required this.isVacant,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BedModel.fromJson(Map<String, dynamic> json) {
    return BedModel(
      id: json['id'],
      roomId: json['roomId'],
      studentId: json['studentId'],
      price: (json['price'] as num).toDouble(),
      isAC: json['isAC'],
      isVacant: json['isVacant'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
