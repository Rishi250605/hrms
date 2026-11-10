import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../../app/l10n/app_localizations.dart';

/// Longest voice note (PHASE-2-FEATURES §6.2).
const kMaxVoiceNote = Duration(minutes: 2);

/// Records an AAC (m4a) voice note of up to two minutes. Reports the recorded bytes (or null when cleared).
class VoiceNoteRecorder extends StatefulWidget {
  const VoiceNoteRecorder({super.key, required this.onChanged});

  final ValueChanged<Uint8List?> onChanged;

  @override
  State<VoiceNoteRecorder> createState() => _VoiceNoteRecorderState();
}

class _VoiceNoteRecorderState extends State<VoiceNoteRecorder> {
  final _recorder = AudioRecorder();
  final _player = AudioPlayer();
  Timer? _ticker;
  Duration _elapsed = Duration.zero;
  bool _recording = false;
  String? _path;

  @override
  void dispose() {
    _ticker?.cancel();
    unawaited(_recorder.dispose());
    unawaited(_player.dispose());
    super.dispose();
  }

  Future<void> _start() async {
    final l10n = AppLocalizations.of(context);
    if (!await _recorder.hasPermission()) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.microphoneDenied)));
      return;
    }
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/voice-${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _recorder.start(const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 64000, sampleRate: 22050, numChannels: 1), path: path);
    setState(() {
      _recording = true;
      _elapsed = Duration.zero;
      _path = null;
    });
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed += const Duration(seconds: 1));
      if (_elapsed >= kMaxVoiceNote) unawaited(_stop());
    });
  }

  Future<void> _stop() async {
    _ticker?.cancel();
    final path = await _recorder.stop();
    if (!mounted) return;
    setState(() {
      _recording = false;
      _path = path;
    });
    widget.onChanged(path == null ? null : await File(path).readAsBytes());
  }

  void _clear() {
    setState(() => _path = null);
    widget.onChanged(null);
  }

  Future<void> _play() async {
    if (_path == null) return;
    await _player.setFilePath(_path!);
    await _player.play();
  }

  String _fmt(Duration d) => '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return InputDecorator(
      decoration: InputDecoration(labelText: l10n.voiceNote, helperText: l10n.voiceNoteHelp),
      child: Row(
        children: [
          if (_recording) ...[
            Icon(Icons.fiber_manual_record, color: scheme.error, size: 16),
            const SizedBox(width: 6),
            Text('${_fmt(_elapsed)} / ${_fmt(kMaxVoiceNote)}'),
            const Spacer(),
            FilledButton.tonalIcon(key: const Key('voice.stop'), onPressed: _stop, icon: const Icon(Icons.stop), label: Text(l10n.stop)),
          ] else if (_path != null) ...[
            IconButton(key: const Key('voice.play'), tooltip: l10n.play, onPressed: _play, icon: const Icon(Icons.play_arrow)),
            Text(_fmt(_elapsed)),
            const Spacer(),
            IconButton(tooltip: l10n.remove, onPressed: _clear, icon: const Icon(Icons.delete_outline)),
          ] else ...[
            Expanded(child: Text(l10n.noVoiceNote)),
            OutlinedButton.icon(key: const Key('voice.record'), onPressed: _start, icon: const Icon(Icons.mic_none), label: Text(l10n.record)),
          ],
        ],
      ),
    );
  }
}

/// Plays a voice note from a signed URL.
class VoiceNotePlayer extends StatefulWidget {
  const VoiceNotePlayer({super.key, required this.url});

  final String url;

  @override
  State<VoiceNotePlayer> createState() => _VoiceNotePlayerState();
}

class _VoiceNotePlayerState extends State<VoiceNotePlayer> {
  final _player = AudioPlayer();
  bool _loaded = false;

  @override
  void dispose() {
    unawaited(_player.dispose());
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_player.playing) {
      await _player.pause();
      return;
    }
    if (!_loaded) {
      await _player.setUrl(widget.url);
      _loaded = true;
    }
    if (_player.processingState == ProcessingState.completed) await _player.seek(Duration.zero);
    await _player.play();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snap) {
        final playing = snap.data?.playing ?? false;
        return OutlinedButton.icon(
          key: const Key('voice.playRemote'),
          onPressed: _toggle,
          icon: Icon(playing ? Icons.pause : Icons.play_arrow),
          label: Text(playing ? l10n.pause : l10n.playVoiceNote),
        );
      },
    );
  }
}
