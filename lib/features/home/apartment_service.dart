// lib/services/apartment_service.dart
import 'package:dio/dio.dart';
import 'package:sakany/features/home/models/apartment_model.dart';

class ApartmentService {
  static final Dio _dio = Dio();

  static Future<List<ApartmentModel>> fetchApartments({
    required int skip,
    int take = 10,
  }) async {
    final response = await _dio.get(
      'https://creative-endlessly-bullfrog.ngrok-free.app/api/Apartment',
      queryParameters: {'Skip': skip, 'Take': take},
    );

    final List data = response.data;
    return data.map((e) => ApartmentModel.fromJson(e)).toList();
  }
}
