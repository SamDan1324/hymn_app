import 'package:flutter/material.dart';
import '../services/audio_service.dart';

class AudioProvider extends ChangeNotifier {
  final AudioService _audioService = AudioService();
  int? _playingHymnNumber;
  bool _isLoading = false;

  int? get playingHymnNumber => _playingHymnNumber;
  bool get isLoading => _isLoading;

  // Toggle play/pause for a given hymn
  Future<void> togglePlay(int hymnNumber, String audioUrl) async {
    if (audioUrl.isEmpty) {
      _playingHymnNumber = null;
      notifyListeners();
      return;
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
      debugPrint('Audio error: $e');
      _playingHymnNumber = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
