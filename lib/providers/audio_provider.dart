import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/audio_service.dart';

class AudioProvider extends ChangeNotifier {
  final AudioService _audioService = AudioService();
  String? _playingHymnNumber;
  bool _isLoading = false;
  Duration _position = Duration.zero;
  Duration? _duration;

  String? get playingHymnNumber => _playingHymnNumber;
  bool get isLoading => _isLoading;
  Duration get position => _position;
  Duration? get duration => _duration;

  AudioProvider() {
    _audioService.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });
    _audioService.durationStream.listen((dur) {
      _duration = dur;
      notifyListeners();
    });
  }

  Future<bool> _hasInternet() async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<void> togglePlay(String hymnNumber, String audioUrl) async {
    if (audioUrl.isEmpty) {
      _playingHymnNumber = null;
      notifyListeners();
      throw Exception('No audio available for this hymn.');
    }
    if (!await _hasInternet()) {
      _playingHymnNumber = null;
      notifyListeners();
      throw Exception('No internet connection. Please connect and try again.');
    }

    _isLoading = true;
    notifyListeners();

    try {
      if (_playingHymnNumber == hymnNumber && _audioService.isPlaying) {
        await _audioService.pause();
        _playingHymnNumber = null;
      } else {
        await _audioService.play(audioUrl);
        _playingHymnNumber = hymnNumber;
      }
    } catch (e) {
      _playingHymnNumber = null;
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> seek(Duration position) async {
    await _audioService.seek(position);
  }

  void stop() {
    _audioService.stop();
    _playingHymnNumber = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }
}
