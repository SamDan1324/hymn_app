import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/hymn.dart';

class HymnService {
  List<Hymn> _allHymns = [];

  Future<List<Hymn>> loadHymns() async {
    if (_allHymns.isNotEmpty) return _allHymns;

    try {
      final jsonString =
          await rootBundle.loadString('assets/data/hymns_all.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _allHymns = jsonList.map((item) => Hymn.fromJson(item)).toList();
      return _allHymns;
    } catch (e) {
      print('Error loading hymns: $e');
      return [];
    }
  }

  List<Hymn> searchHymns(List<Hymn> hymns, String query) {
    if (query.isEmpty) return hymns;
    final lowerQuery = query.toLowerCase();
    return hymns.where((hymn) {
      return hymn.number.toString().contains(lowerQuery) ||
          hymn.title.toLowerCase().contains(lowerQuery) ||
          hymn.fullLyricsText.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
