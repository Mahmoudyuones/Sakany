import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'owner_model.dart';

class OwnerService {
  static Future<OwnerModel> fetchOwnerData(String ownerId) async {
    final url =
        'https://creative-endlessly-bullfrog.ngrok-free.app/api/owner/$ownerId';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Authentication token not found');
    }
    try {
      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        return OwnerModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load owner data: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      String errorMessage = 'Failed to load owner data';
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Connection timed out';
      } else if (e.type == DioErrorType.badResponse) {
        errorMessage = 'Invalid response: ${e.response?.statusMessage}';
      } else if (e.type == DioErrorType.unknown) {
        errorMessage = 'Server unreachable';
      }
      throw Exception(errorMessage);
    }
  }

  static Future<OwnerModel> editOwnerData({
    required String ownerId,
    required String firstName,
    required String lastName,
    String? email,
    required String residence,
    required String religion,
    required String phoneNumber,
    required String profilePhoto,
    required String frontId,
    required String backId,
  }) async {
    final url =
        'https://creative-endlessly-bullfrog.ngrok-free.app/api/owner/$ownerId';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Authentication token not found');
    }
    final data = {
      'firstName': firstName,
      'lastName': lastName,
      if (email != null) 'email': email,
      'residence': residence,
      'religion': religion.toLowerCase(), // Normalize to match API expectation
      'phoneNumber': phoneNumber,
      'profilePhoto': profilePhoto,
      'FrontId': frontId,
      'BackId': backId,
    };
    try {
      final response = await Dio().put(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        return OwnerModel.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to update owner data: ${response.statusMessage}',
        );
      }
    } on DioError catch (e) {
      String errorMessage = 'Failed to update owner data';
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        errorMessage = 'Connection timed out';
      } else if (e.type == DioErrorType.badResponse) {
        errorMessage = 'Invalid response: ${e.response?.statusMessage}';
      } else if (e.type == DioErrorType.unknown) {
        errorMessage = 'Server unreachable';
      }
      throw Exception(errorMessage);
    }
  }
}
