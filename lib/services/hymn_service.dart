import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/hymn.dart';

class HymnService {
  List<Hymn> _allHymns = [];

  Future<List<Hymn>> loadHymns(BuildContext context) async {
    if (_allHymns.isNotEmpty) return _allHymns;

    try {
      final jsonString =
          await rootBundle.loadString('assets/data/hymns_all.json');

      final List<dynamic> jsonList = json.decode(jsonString);

      _allHymns = jsonList.map((item) => Hymn.fromJson(item)).toList();

      if (_allHymns.isEmpty) {
        _showSnackbar(context, 'JSON parsed but 0 hymns. Check file content.');
      } else {
        _showSnackbar(context, '✅ Loaded ${_allHymns.length} hymns!',
            isError: false);
      }
      return _allHymns;
    } catch (e) {
      _showSnackbar(context, '❌ Error: $e');
      return [];
    }
  }

  void _showSnackbar(BuildContext context, String message,
      {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 5),
      ),
    );
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
