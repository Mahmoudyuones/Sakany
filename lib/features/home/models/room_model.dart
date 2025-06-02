import 'bed_model.dart'; // if using separate files

class RoomModel {
  final String id;
  final String apartmentId;
  final String roomType;
  final int numberOfBeds;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<BedModel> beds;

  RoomModel({
    required this.id,
    required this.apartmentId,
    required this.roomType,
    required this.numberOfBeds,
    required this.createdAt,
    required this.updatedAt,
    required this.beds,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      apartmentId: json['apartmentId'],
      roomType: json['roomType'],
      numberOfBeds: json['numberOfBeds'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      beds:
          (json['beds'] as List<dynamic>)
              .map((bed) => BedModel.fromJson(bed))
              .toList(),
    );
  }
}
