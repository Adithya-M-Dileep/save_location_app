import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String API = "9rRi1LUfkHfiOdAgyir2fqVWyaWGRZ0y";

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return "https://open.mapquestapi.com/staticmap/v4/getmap?key=${dotenv.env['API_KEY']}&size=600,400&zoom=13&center=$latitude,$longitude&mcenter=$latitude,$longitude";
  }

  static Future<Map<String, dynamic>> getPlaceAddress(
      {double latitude, double longitude}) async {
    final url =
        "https://api.geoapify.com/v1/geocode/reverse?lat=$latitude&lon=$longitude&apiKey=${dotenv.env['GEOCODING_API']}";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)["features"][0]["properties"];
  }
}
