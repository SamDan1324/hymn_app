import 'package:just_audio/just_audio.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _player = AudioPlayer();
  String? _currentUrl;

  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  bool get isPlaying => _player.playing;

  Future<void> play(String url) async {
    if (url.isEmpty) throw Exception('No audio URL');
    if (_currentUrl == url && _player.playing) {
      await _player.pause();
    } else {
      _currentUrl = url;
      await _player.setUrl(url);
      await _player.play();
    }
  }

  Future<void> pause() async => _player.pause();
  Future<void> stop() async => _player.stop();
  Future<void> seek(Duration position) async => _player.seek(position);

  void dispose() => _player.dispose();
}
