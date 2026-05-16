import 'lyric_segment.dart';

class Hymn {
  final int number;
  final String title;
  final List<LyricSegment> lyrics;
  final String audioUrl;
  final String pdfUrl;

  Hymn({
    required this.number,
    required this.title,
    required this.lyrics,
    required this.audioUrl,
    required this.pdfUrl,
  });

  // Creates a Hymn from JSON
  factory Hymn.fromJson(Map<String, dynamic> json) {
    var lyricsList = json['lyrics'] as List? ?? [];
    return Hymn(
      number: json['number'] ?? 0,
      title: json['title'] ?? 'Untitled',
      lyrics: lyricsList.map((item) => LyricSegment.fromJson(item)).toList(),
      audioUrl: json['audio_url'] ?? '',
      pdfUrl: json['pdf_url'] ?? '',
    );
  }

  // Combines all lyrics into one string for easy searching
  String get fullLyricsText {
    return lyrics.map((seg) => seg.content).join(' ');
  }
}
