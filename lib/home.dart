import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:another_trial/service/mood_service.dart';
import 'package:another_trial/song_screen.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

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
    MoodService().getMood("""Who am I? Someone that's afraid to let go, uh
You decide, if you're ever gonna let me know, yeah
Suicide, if you ever try to let go, uh
I'm sad I know, yeah, I'm sad I know, yeah
Who am I? Someone that's afraid to let go, uh
You decide, if you're ever gonna let me know, yeah
Suicide, if you ever try to let go, uh
I'm sad I know, yeah, I'm sad I know, yeah
I gave her everything
She took my heart and left me lonely
I think broken heart's contagious
I won't fix, I'd rather weep
I'm lost then I'm found
But it's torture bein' in love
I love when you're around
But I fuckin' hate when you leave
Who am I? Someone that's afraid to let go, uh
You decide, if you're ever gonna let me know, yeah
Suicide, if you ever try to let go, uh
I'm sad I know, yeah, I'm sad I know, yeah
Who am I? Someone that's afraid to let go, uh
You decide, if you're ever gonna let me know, yeah
Suicide, if you ever try to let go, uh
I'm sad I know, yeah, I'm sad I know, yeah""");

    _acrCloudSdk
      ..init(
        host: 'identify-eu-west-1.acrcloud.com',
        accessKey: '8ae888974b56eb5b673ba6cd02299c73',
        accessSecret: 'GVlxZFEzmreshnpIhT9c3D3RHLqijGh0scrJJ4ac',
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

      if (songTitle != null) {
        var moodService = MoodService();
        var mood = await moodService.getMood(songTitle);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongScreen(
              song: songTitle,
              mood: mood,
            ),
          ),
        );
        _stopRecognition();
      }
    } else {
      // handle the case when no song is recognized
    }
  }

  void _handleUnrecognizedSong() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongScreen(
          song: 'Could not recognize song',
          mood: "Could not recognize mood",
        ),
      ),
    );
    _stopRecognition();
  }

  void _startRecognition() async {
    print("Recognition Started!");
    try {
      started = await _acrCloudSdk.start();
    } catch (e) {
      print('Error starting ACRCloudSdk: $e');
    }
    print("Ofc Started!");
    setState(() {
      _isRecognizing = started;
    });

    Future.delayed(const Duration(seconds: 15), () {
      if (_isRecognizing) {
        _stopRecognition();
        _handleUnrecognizedSong();
      }
    });
  }

  void _stopRecognition() async {
    print("Recognition Stopped!");
    bool stopped = await _acrCloudSdk.stop();
    setState(() {
      _isRecognizing = !stopped;
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
            AvatarGlow(
              animate: _isRecognizing,
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
          ],
        ),
      ),
    );
  }
}
