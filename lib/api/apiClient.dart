import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiClient {
  final Dio _dio = Dio();
  static const String apiEndpoint = "http://10.0.2.2:8000";

  Future<Response> registerUser(Map<String, dynamic>? userData) async {
    try {
      Response response = await _dio.post(
        '$apiEndpoint/auth/user/register',
        data: userData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      debugPrint('$e');
      return e.response!;
    }
  }

  Future<Response> login(Map<String, dynamic>? userCredentials) async {
    try {
      Response response = await _dio.post(
        '$apiEndpoint/auth/user/login',
        data: userCredentials,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      debugPrint('$e');
      return e.response!;
    }
  }

  Future<Response> saveGlucoseLevel(Map<String, String>? req) async {
    try {
      Response response = await _dio.post(
        '$apiEndpoint/glucose/save',
        data: req,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
      );
      return response;
    } on DioError catch (e) {
      debugPrint('$e');
      return e.response!;
    }
  }
//
// Future<Response> getUserProfileData() async {
//   //GET USER PROFILE DATA
// }
//
// Future<Response> logout() async {
//   //IMPLEMENT USER LOGOUT
// }
}
