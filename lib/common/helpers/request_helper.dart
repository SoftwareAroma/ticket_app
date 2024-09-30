import 'dart:convert';

import 'package:award_ticket/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestHelper {
  RequestHelper._();

  static final _instance = RequestHelper._();
  static RequestHelper get instance => _instance;

  /// [http.get] request
  Future<T> getRequest<T>({
    required String path,
    Map<String, String>? headers,
    required T Function(dynamic data) builder,
  }) async {
    Uri url = Uri.parse(path);
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    // response.headers['Access-Control-Allow-Credentials'] = 'true';
    try {
      if (response.ok) {
        String data = response.body;
        dynamic decodedData = jsonDecode(data);
        dynamic returnData = {
          "data": decodedData,
          "success": true,
        };
        return builder(returnData);
      } else {
        final failure = ServerFailure(message: response.body);
        dynamic decodedData = jsonDecode(failure.toString());
        dynamic returnData = {
          "data": decodedData,
          "success": false,
        };
        return builder(returnData);
      }
    } catch (e) {
      debugPrint(e.toString());
      final errorMessage = HttpExceptions.errorMessage(e);
      final failure = ServerFailure(message: errorMessage);
      dynamic returnData = {
        "data": failure,
        "success": false,
      };
      return builder(returnData);
    }
  }

  /// [http.post] request
  Future<T> postRequest<T>({
    required String path,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Encoding? encoding,
    required T Function(dynamic data) builder,
  }) async {
    Uri url = Uri.parse(path);
    http.Response response = await http.post(
      url,
      body: jsonEncode(data),
      headers: headers,
      encoding: encoding,
    );
    // debugPrint("response: ${response.body}");
    try {
      if (response.ok) {
        String data = response.body;
        dynamic decodedData = jsonDecode(data);
        dynamic returnData = {
          "data": decodedData,
          "success": true,
        };
        return builder(returnData);
      } else {
        final failure = ServerFailure(message: response.body);
        dynamic decodedData = jsonDecode(failure.toString());
        dynamic returnData = {
          "data": decodedData,
          "success": false,
        };
        return builder(returnData);
      }
    } catch (e) {
      debugPrint("Error from post: ${e.toString()}");
      final errorMessage = HttpExceptions.errorMessage(e);
      final failure = ServerFailure(message: errorMessage);
      dynamic decodedData = jsonDecode(failure.toString());
      dynamic returnData = {
        "data": decodedData,
        "success": false,
      };
      return builder(returnData);
    }
  }

  /// [http.patch] request
  Future<T> patchRequest<T>({
    required String path,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Encoding? encoding,
    required T Function(dynamic data) builder,
  }) async {
    Uri url = Uri.parse(path);
    try {
      // debugPrint("here => $data");
      http.Response response = await http.patch(
        url,
        body: jsonEncode(data),
        headers: headers,
        encoding: encoding,
      );
      if (response.ok) {
        String data = response.body;
        dynamic decodedData = jsonDecode(data);
        dynamic returnData = {
          "data": decodedData,
          "success": true,
        };
        return builder(returnData);
      } else {
        final failure = ServerFailure(message: response.body);
        dynamic decodedData = jsonDecode(failure.toString());
        dynamic returnData = {
          "data": decodedData,
          "success": false,
        };
        return builder(returnData);
      }
    } catch (e) {
      debugPrint(e.toString());
      final errorMessage = HttpExceptions.errorMessage(e);
      final failure = ServerFailure(message: errorMessage);
      dynamic decodedData = jsonDecode(failure.toString());
      dynamic returnData = {
        "data": decodedData,
        "success": false,
      };
      return builder(returnData);
    }
  }

  /// [http.put] request
  Future<T> putRequest<T>({
    required String path,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Encoding? encoding,
    required T Function(dynamic data) builder,
  }) async {
    Uri url = Uri.parse(path);
    http.Response response = await http.put(
      url,
      body: jsonEncode(data),
      headers: headers,
      encoding: encoding,
    );
    try {
      if (response.ok) {
        String data = response.body;
        dynamic decodedData = jsonDecode(data);
        dynamic returnData = {
          "data": decodedData,
          "success": true,
        };
        return builder(returnData);
      } else {
        final failure = ServerFailure(message: response.body);
        dynamic decodedData = jsonDecode(failure.toString());
        dynamic returnData = {
          "data": decodedData,
          "success": false,
        };
        return builder(returnData);
      }
    } catch (e) {
      debugPrint(e.toString());
      final errorMessage = HttpExceptions.errorMessage(e);
      final failure = ServerFailure(message: errorMessage);
      dynamic decodedData = jsonDecode(failure.toString());
      dynamic returnData = {
        "data": decodedData,
        "success": false,
      };
      return builder(returnData);
    }
  }

  /// [http.delete] request
  Future<T> deleteRequest<T>({
    required String path,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Encoding? encoding,
    required T Function(dynamic data) builder,
  }) async {
    Uri url = Uri.parse(path);
    http.Response response = await http.delete(
      url,
      body: jsonEncode(data),
      headers: headers,
      encoding: encoding,
    );
    try {
      if (response.ok) {
        String data = response.body;
        dynamic decodedData = jsonDecode(data);
        dynamic returnData = {
          "data": decodedData,
          "success": true,
        };
        return builder(returnData);
      } else {
        final failure = ServerFailure(message: response.body);
        dynamic decodedData = jsonDecode(failure.toString());
        dynamic returnData = {
          "data": decodedData,
          "success": false,
        };
        return builder(returnData);
      }
    } catch (e) {
      debugPrint(e.toString());
      final errorMessage = HttpExceptions.errorMessage(e);
      final failure = ServerFailure(message: errorMessage);
      dynamic decodedData = jsonDecode(failure.toString());
      dynamic returnData = {
        "data": decodedData,
        "success": false,
      };
      return builder(returnData);
    }
  }
}
