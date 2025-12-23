import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sample extends StatefulWidget {
  const Sample({Key? key}) : super(key: key);

  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  final List<String> lyrics = [
    'Welcome to SAMPLEPAGE!',
    'may be we get married one day',
    'but who know',
    'daniel ceasar',
    'WHO KNOW??',
  ];

  int index = 0;

  void _nextLyric() {
    setState(() {
      index = (index + 1) % lyrics.length; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 40, 160, 246),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lyrics[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _nextLyric,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

