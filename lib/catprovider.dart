import 'dart:convert';

import 'package:catsapi/cats.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CatProvider with ChangeNotifier {
  List<Cats> _cats = [];
  List<Cats> get cats => _cats;
  Future<void> fetchCats([String query = '']) async {
    final url = query.isEmpty
        ? "https://freetestapi.com/api/v1/cats"
        : "https://freetestapi.com/api/v1/cats?search=[query]";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _cats = data.map((json) => Cats.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw error;
    }
  }
}
