import 'room_model.dart'; // if using separate files

class ApartmentModel {
  final String apartmentId;
  final String apartmentTitle;
  final int numberOfRooms;
  final int numberOfBeds;
  final bool isWifi;
  final String ownerId;
  final String description;
  final String location;
  final String mainImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<RoomModel> rooms;

  ApartmentModel({
    required this.apartmentId,
    required this.apartmentTitle,
    required this.numberOfRooms,
    required this.numberOfBeds,
    required this.isWifi,
    required this.ownerId,
    required this.description,
    required this.location,
    required this.mainImage,
    required this.createdAt,
    required this.updatedAt,
    required this.rooms,
  });

  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    return ApartmentModel(
      apartmentId: json['apartmentId'],
      apartmentTitle: json['apartmentTitle'],
      numberOfRooms: json['numberOfRooms'],
      numberOfBeds: json['numberOfBeds'],
      isWifi: json['isWifi'],
      ownerId: json['ownerId'],
      description: json['description'],
      location: json['location'],
      mainImage: json['mainImage'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      rooms:
          (json['rooms'] as List<dynamic>)
              .map((room) => RoomModel.fromJson(room))
              .toList(),
    );
  }
}
