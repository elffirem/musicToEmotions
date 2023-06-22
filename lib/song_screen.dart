import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

extension StringExtension on String {
  String capitalize() {
    print('${this[0].toUpperCase()}${substring(1)}');
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

class SongScreen extends StatefulWidget {
  final String song;
  final String mood;
  final String moodBySound;

  const SongScreen({
    Key? key,
    required this.song,
    required this.mood,
    required this.moodBySound,
  }) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  Color backgroundColor = const Color.fromARGB(255, 91, 58, 145);
  Color tagColor = Colors.black;
  late String animationAsset;

  @override
  void initState() {
    super.initState();
    if (widget.mood == widget.moodBySound) {
      if (widget.mood == 'happy') {
        backgroundColor = const Color(0xffF3D375);
        animationAsset = 'assets/happy.json';
      } else if (widget.mood == 'sad') {
        backgroundColor = const Color(0xffBCBDC1);
        animationAsset = 'assets/sad.json';
      } else if (widget.mood == 'relaxed') {
        backgroundColor = const Color(0xff7DC0D9);
        animationAsset = 'assets/relaxed.json';
      } else if (widget.mood == 'angry') {
        backgroundColor = const Color(0xffEE5D5B);
        animationAsset = 'assets/angry.json';
      }
    } else {
      animationAsset = 'assets/confused.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.3, 0.55, 0.9],
            colors: [
              backgroundColor.withOpacity(0.9),
              backgroundColor.withOpacity(0.7),
              backgroundColor.withOpacity(0.5),
              Colors.white.withOpacity(0.9),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                const Text(
                  'Song',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.song,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Mood by Lyrics',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.mood.capitalize(),
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Mood by Music',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.moodBySound.capitalize(),
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 70),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 300.0,
                    width: 300.0,
                    child: Lottie.asset(
                      animationAsset,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
