import 'dart:convert';
import 'package:dio/dio.dart';

class CallApi {
  final String apiUrl = 'http://127.0.0.1:5000';

  getData(apiUrl) async {
    try {
      var response = await Dio().get(apiUrl, options: Options());
      if (response.statusCode == 200) {
        print(jsonDecode(response.data));
      } else {
        print("error");
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
