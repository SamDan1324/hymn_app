import 'package:just_audio/just_audio.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _player = AudioPlayer();
  String? _currentUrl;

  bool get isPlaying => _player.playing;
  bool get hasUrl => _currentUrl != null;

  Future<void> play(String url) async {
    if (url.isEmpty) {
      throw Exception('No audio URL provided');
    }
    // If same URL is already playing, pause it
    if (_currentUrl == url && _player.playing) {
      await _player.pause();
    } else {
      _currentUrl = url;
      await _player.setUrl(url);
      await _player.play();
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
    _currentUrl = null;
  }

  void dispose() {
    _player.dispose();
  }
}
