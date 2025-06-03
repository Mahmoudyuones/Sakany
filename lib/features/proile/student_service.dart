import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'student_model.dart'; // make sure to import your model

class StudentService {
  static Future<StudentModel> fetchStudentData(String studentId) async {
    final url =
        'https://creative-endlessly-bullfrog.ngrok-free.app/api/Student/$studentId';

    final response = await Dio().get(url);

    if (response.statusCode == 200) {
      return StudentModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load student data');
    }
  }

  static Future<StudentModel> editStudent(String studentId) async {
    final url =
        'https://creative-endlessly-bullfrog.ngrok-free.app/api/Student/$studentId';

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
        return StudentModel.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load student data: ${response.statusMessage}',
        );
      }
    } on DioError catch (e) {
      String errorMessage = 'Failed to load student data';
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

  static Future<StudentModel> editStudentData({
    required String studentId,
    required String firstName,
    required String lastName,
    required String collegeName,
    required int age,
    required String origin,
    required String religon,
    required String profilePhoto,
    required String phoneNumber,
    required String gender,
  }) async {
    final url =
        'https://creative-endlessly-bullfrog.ngrok-free.app/api/Student/$studentId';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Authentication token not found');
    }

    final data = {
      'firstName': firstName,
      'lastName': lastName,
      'collegeName': collegeName,
      'age': age,
      'origin': origin,
      'religon': religon,
      'profilePhoto': profilePhoto,
      'phoneNumber': phoneNumber,
      'gender': gender,
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
        return StudentModel.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to update student data: ${response.statusMessage}',
        );
      }
    } on DioError catch (e) {
      String errorMessage = 'Failed to update student data';
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
