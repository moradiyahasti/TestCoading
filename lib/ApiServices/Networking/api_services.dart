import 'dart:convert';
import 'dart:developer';
import 'package:coding_test/ApiServices/Networking/api.dart';
import 'package:http/http.dart' as http;

class StarWarsService {
  Future<Map<String, dynamic>> fetchCharacters(int page) async {
    try {
      final response =
          await http.get(Uri.parse('${ApiUrl.baseUrl}?page=$page'));
      print("Home Data Response : ${response.body}");
      log("Url-------------: ${'${ApiUrl.baseUrl}?page=$page'}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load Data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}
