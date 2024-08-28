import 'dart:convert';
import 'dart:io';

import 'package:flutter_with_webapi/model.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "http://10.0.2.2:5019/api/user";

  //get req handling
  Future<List<User>> getUserData() async {
    List<User> data = [];
    final uri = Uri.parse(baseUri);
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        data = jsonData.map((json) => User.fromJson(json)).toList();
      }
    } catch (e) {
      return data;
    }
    return data;
  }

  Future<http.Response> updateUser({required id, required User user}) async {
    print(json.encode(user));
    final uri = Uri.parse("$baseUri");
    late http.Response response;
    try {
      response = await http.put(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: json.encode(user),
      );
    } catch (e) {
      return response;
    }
    print(response.body.toString());
    return response;
  }

  Future<http.Response> addUser({required User user}) async {
    final uri = Uri.parse(baseUri);
    late http.Response response;

    try {
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: json.encode(user),
      );
    } catch (e) {
      return response;
    }

    return response;
  }

  Future<http.Response> deleteUser({required int id}) async {
    final uri = Uri.parse("$baseUri/$id");
    late http.Response response;
    try {
      response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
      );
    } catch (e) {
      return response;
    }
    return response;
  }
}
