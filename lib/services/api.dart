
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String apiKey = 'AIzaSyBMhjyTxBv4-Wy3xzoZKbUWTmu0qQBeqPc'; // Replace with your actual API key
  static final String apiUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  Future<List<String>> getAutocompleteResults(String input) async {
    final Uri uri = Uri.parse('$apiUrl?input=$input&key=$apiKey');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> predictions = json.decode(response.body)['predictions'];
      return predictions.map((prediction) => prediction['description'].toString()).toList();
    } else {
      throw Exception('Failed to load autocomplete results');
    }
  }
}

