import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/response_api.dart';

class BooksApi {
  Future<ResponseApi> getBooks(String parameter) async {
    final response = await http.get(Uri.parse(
        'https://api.nytimes.com/svc/books/v3/lists/full-overview.json?api-key=d4TStilVORriHVOR8F4GZKIgINKDQ8Pz'));
    print("resultado ${response.body}");

    if (response.statusCode == 200) {
      print("status code = ${response.statusCode}");
      return ResponseApi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load books');
    }
  }
}
