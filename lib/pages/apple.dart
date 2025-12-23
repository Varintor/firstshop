import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplePage extends StatefulWidget {
  const ApplePage({Key? key}) : super(key: key);

  @override
  _ApplePageState createState() => _ApplePageState();
}
class _ApplePageState extends State<ApplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to the Apple Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
