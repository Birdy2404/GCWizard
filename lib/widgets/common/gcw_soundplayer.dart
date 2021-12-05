import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart'; // https://pub.dev/packages/audioplayers
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_slider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';

enum PlayerState { stopped, playing, paused }

class GCWSoundPlayer extends StatefulWidget {
  final PlatformFile file;

  const GCWSoundPlayer({Key key, @required this.file}) : super(key: key);

  @override
  _GCWSoundPlayerState createState() => _GCWSoundPlayerState();
}

class _GCWSoundPlayerState extends State<GCWSoundPlayer> {

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      audioCache.fixedPlayer?.notificationService.startHeadlessService();
    }
    advancedPlayer.onPlayerCompletion.listen((event) {
      onComplete();
      setState(() => playerState = PlayerState.stopped);
    });
  }

  @override
  void dispose() {
    advancedPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GCWIconButton(
          iconData: Icons.play_arrow,
          onPressed: isPlaying
              ? null
              : () => _AudioPlayerPlay(widget.file.bytes),
        ),
        GCWIconButton(
          iconData: Icons.stop,
          onPressed: isPlaying || isPaused ? () => _AudioPlayerStop() : null,
        ),
//        Expanded(
//          child: GCWSlider(value: 0.0, min: 0.0, max: 100.0, suppressReset: true),
//        ),
//        GCWText(text: '0:42 / 10:00')
      ],
    );
  }

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  _AudioPlayerPlay(Uint8List byteData) async {
    int result = await advancedPlayer.playBytes(byteData);
    setState(() => playerState = PlayerState.playing);
  }

  Future _AudioPlayerStop() async {
    await advancedPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
    });
  }

}


