import 'package:flutter/material.dart';

class SongScreen extends StatelessWidget {
  final String song;
  final String mood;
  final List artist;

  const SongScreen({Key? key, required this.song, required this.artist, required this.mood})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFF302E4A),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              song,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
            Text(
              artist[0],
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(5.0, 5.0),
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
