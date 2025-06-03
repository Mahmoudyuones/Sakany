// lib/services/apartment_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:sakany/features/home/models/apartment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static const String _baseUrl =
      "https://creative-endlessly-bullfrog.ngrok-free.app/api/Apartment";

  static Future<bool> addApartment({
    required String title,
    required int rooms,
    required int beds,
    required bool isWifi,
    required String description,
    required String location,
    required String? imageFile,
    required String ownerId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token not found");
      }

      final Map<String, dynamic> requestData = {
        "apartmentTitle": title,
        "numberOfRooms": rooms,
        "numberOfBeds": beds,
        "isWifi": isWifi,
        "description": description,
        "location": location,
        "mainImage": imageFile,
        "ownerId": ownerId,
      };

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print('Error ${response.statusCode}: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }
}
