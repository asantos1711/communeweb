import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../modelos/trustswiftly/responseCreate.dart';
import '../modelos/trustswiftly/responseGet.dart';

class Trustswiftly {
  String token = "Bearer 2|rNsbN8Bb9EtI6vRBZtJ6N4TdUG8kPSRCeDh2kGZw506d8f94";
  String baseUrl = "https://commune.trustswiftly.com/api";

  // Future<ResponseCreate> createUser(String id, String name) async {
  //   late ResponseCreate responsem;
  //   String method = "/users";
  //   var url = Uri.parse(baseUrl + method);
  //   print(url);
  //   print(url);
  //   var headers = {
  //     'Authorization': token,
  //     'Content-Type': 'application/json',
  //     'User-Agent': 'TrustSwiftly/1.0'
  //   };
  //   var body = {
  //     "email": "$id@commune.com.mx",
  //     "last_name": name,
  //     "first_name": name,
  //     "phone": "+521111111111",
  //     "username": id,
  //     "template_id": "tmpl_MQ"
  //   };
  //   print('body status: ${body}');
  //   final dio = Dio();
  //   final responsedio = await dio.post(baseUrl + method,
  //       data: body, options: Options(headers: headers));
  //   //print("DIO BUSQUEDA----> ${responsedio.statusCode}");
  //   //print("DIO BUSQUEDA----> ${responsedio.data}");

  //   try {
  //     if (responsedio.statusCode == 200) {
  //       print("Estamos dentro");
  //       final decodeData = responsedio.data;

  //       _services = Services.fromJson(decodeData);
  //     } else {
  //       _services == null;
  //       print("getServices service status code: ${responsedio.data}");
  //     }
  //   } catch (e) {
  //     responsem == ResponseCreate();
  //     logError("Error en getServices $e");
  //   }
  //   print('Request status: ${response.request}');
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //   print('Response body: ${response.bodyBytes}');
  //   responsem = ResponseCreate.fromJson(json.decode(response.body));
  //   return responsem;
  // }
  Future<ResponseCreate> createUser(String id, String name) async {
    late ResponseCreate responsem;
    String method = "/users";
    var url = Uri.parse(baseUrl + method);
    print(url);
    print(url);
    var headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
      'User-Agent': 'TrustSwiftly/1.0'
    };
    var body = {
      "email": "$id@commune.com.mx",
      "last_name": name,
      "first_name": name,
      "phone": "+529999999999",
      "username": id,
      "template_id": "tmpl_MQ"
    };
    print('body status: ${body}');
    var response =
        await http.post(url, body: json.encode(body), headers: headers);
    print('Request status: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('Response body: ${response.bodyBytes}');
    responsem = ResponseCreate.fromJson(json.decode(response.body));
    return responsem;
  }

  Future<ResponseGet> getUser(String id) async {
    late ResponseGet responsem;
    String method = "/users/$id";
    var url = Uri.parse(baseUrl + method);
    print(url);
    print(url);
    var headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
      'User-Agent': 'TrustSwiftly/1.0'
    };

    var response = await http.get(url, headers: headers);
    print('Request status: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('Response body: ${response.bodyBytes}');
    responsem = ResponseGet.fromJson(json.decode(response.body));
    return responsem;
  }
}
