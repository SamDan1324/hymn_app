class LyricSegment {
  final String type; // "verse" or "chorus"
  final String label; // "Verse 1", "CHORUS", etc.
  final String content; // The actual lyrics text

  LyricSegment({
    required this.type,
    required this.label,
    required this.content,
  });

  // Creates a LyricSegment from JSON data
  factory LyricSegment.fromJson(Map<String, dynamic> json) {
    return LyricSegment(
      type: json['type'] ?? 'verse',
      label: json['label'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
