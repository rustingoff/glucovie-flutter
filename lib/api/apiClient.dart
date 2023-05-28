import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final Dio _dio = Dio();
  final storage = const FlutterSecureStorage();
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
      await storage.write(key: "jwt", value: response.data["at"]);
      return response;
    } on DioError catch (e) {
      debugPrint('$e');
      return e.response!;
    }
  }

  Future<Response> saveGlucoseLevel(Map<String, dynamic>? req) async {
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

  Future<Response> saveEvent(Map<String, dynamic>? req) async {
    var token = await storage.read(key: "jwt");
    try {
      Response response = await _dio.post(
        '$apiEndpoint/event/save',
        data: req,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      debugPrint('$e');
      return e.response!;
    }
  }

  Future<Response> getGlucoseLevelLastWeek() async {
    try {
      Response response = await _dio.get(
        '$apiEndpoint/glucose/week',
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

  Future<Response> getEvents() async {
    var token = await storage.read(key: "jwt");
    try {
      Response response = await _dio.get(
        '$apiEndpoint/event/get',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      debugPrint('$e');
      return e.response!;
    }
  }

  Future<Response> deleteEvent(String id) async {
    var token = await storage.read(key: "jwt");
    try {
      Response response = await _dio.delete(
        '$apiEndpoint/event/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      debugPrint('$e');
      return e.response!;
    }
  }
}
