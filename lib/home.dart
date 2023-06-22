import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:another_trial/service/mood_service.dart';
import 'package:another_trial/song_screen.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AcrCloudSdk _acrCloudSdk = AcrCloudSdk();
  bool _isRecognizing = false;
  bool started = false;

  @override
  void initState() {
    super.initState();

    _acrCloudSdk
      ..init(
        host: 'identify-eu-west-1.acrcloud.com',
        accessKey: '723f21a2b6c74f61ef1767edabc363fe',
        accessSecret: 'mhn9oCs0kmG1qsYHUjrB2pZ77iUPMWyb6LYFmySY',
        setLog: true,
      )
      ..songModelStream.listen(_onSongRecognized);
  }

  void _onSongRecognized(SongModel song) async {
    if (song.metadata != null &&
        song.metadata!.music != null &&
        song.metadata!.music!.isNotEmpty) {
      String? songTitle = song.metadata!.music![0].title;
      List<Artists>? songArtist = song.metadata!.music![0].artists;

      if (songTitle != null && songArtist != null) {
        var moodService = MoodService();
        var moods = await moodService.getMood(songTitle, songArtist[0].name!);
        var mood = moods['mood'];
        var moodBySound = moods['moodBySound'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongScreen(
              song: songTitle,
              mood: mood!.isEmpty ? "Couldn't Detect" : mood,
              moodBySound:
                  moodBySound!.isEmpty ? "Couldn't Detect" : moodBySound,
            ),
          ),
        );
        _stopRecognition();
      }
    } else {
      _handleUnrecognizedSong();
    }
  }

  void _handleUnrecognizedSong() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongScreen(
          moodBySound: "Could not recognize mood by sound",
          song: 'Could not recognize song',
          mood: "Could not recognize mood by lyrics",
        ),
      ),
    );
    _stopRecognition();
  }

  void _startRecognition() async {
    setState(() {
      _isRecognizing = true;
    });

    try {
      started = await _acrCloudSdk.start();
    } catch (e) {
      print('Error starting ACRCloudSdk: $e');
    }

    Future.delayed(const Duration(seconds: 15), () {
      if (_isRecognizing) {
        _stopRecognition();
        _handleUnrecognizedSong();
      }
    });
  }

  void _stopRecognition() async {
    bool stopped = await _acrCloudSdk.stop();

    setState(() {
      _isRecognizing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF302E4A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _isRecognizing
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 84),
                          child: Text(
                            'Analyzing...',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: const Offset(0, 2),
                                  blurRadius: 4.0,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Lottie.asset(
                          'assets/animation.json',
                          key: const ValueKey<String>('animation'),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 84),
                          child: Text(
                            'Music to Emotions',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: const Offset(0, 2),
                                  blurRadius: 4.0,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                        AvatarGlow(
                          key: const ValueKey<String>('button'),
                          animate: _isRecognizing,
                          glowColor: Colors.white,
                          endRadius: 90.0,
                          child: SizedBox(
                            width: 150.0,
                            height: 150.0,
                            child: FloatingActionButton(
                              onPressed: _startRecognition,
                              backgroundColor: Colors.white,
                              child: Text(
                                _isRecognizing ? 'Recognizing...' : 'Start',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  color: Color(0xFF302E4A),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: Column(
                            children: [
                              Text('press start',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                  )),
                              Text(
                                  'so you can discover the emotion of your song',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
