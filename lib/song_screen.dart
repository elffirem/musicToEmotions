import 'package:flutter/material.dart';

class SongScreen extends StatefulWidget {
  final String song;
  final String mood;

  const SongScreen({
    Key? key,
    required this.song,
    required this.mood,
  }) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  Color backgroundColor = const Color(0xFF302E4A);
  Color tagColor = Colors.black;
  @override
  void initState() {
    super.initState();
    if (widget.mood == 'happy') {
      backgroundColor = const Color(0xffF3D375);
    } else if (widget.mood == 'sad') {
      backgroundColor = const Color(0xffBCBDC1);
    } else if (widget.mood == 'relaxed') {
      backgroundColor = const Color(0xff7DC0D9);
    } else if (widget.mood == 'angry') {
      backgroundColor = const Color(0xffEE5D5B);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Song',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: tagColor,
              ),
            ),
            Text(
              widget.song,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Mood by Lyrics',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: tagColor,
              ),
            ),
            Text(
              widget.mood,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Mood by Music',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: tagColor,
              ),
            ),
            Text(
              widget.mood,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
