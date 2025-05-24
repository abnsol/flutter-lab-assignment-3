import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/album.dart';
import '../models/photo.dart';

class ApiService {
  final String _baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse("$_baseUrl/albums"));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Album.fromJson(item)).toList();
    } else {
      throw "Failed to load albums";
    }
  }

  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri.parse("$_baseUrl/photos"));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Photo.fromJson(item)).toList();
    } else {
      throw "Failed to load photos";
    }
  }
}
