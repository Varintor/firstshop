import 'package:firstshop/pages/apple.dart';
import 'package:firstshop/pages/detailpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('computer knowledge')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            mybox(
              "what is a computer?",
              "Computer is a things to calculate and fo any other works",
              "assets/2.jpg",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Detailpage()),
                );
              },
            ),
            SizedBox(height: 20),
            mybox(
              "what is Flutter?",
              "Flutter is an open-source UI software development toolkit created by Google.",
              "assets/3.jpg",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApplePage()),
                );
              },
            ),
            SizedBox(height: 20),
            mybox(
              "what is a Dart?",
              "Dart is a programming language designed for building web, server, desktop, and mobile applications.",
              "assets/4.jpg",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApplePage()),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget mybox(
    String title,
    String subtitle,
    String imageUrl,
    VoidCallback ontab,
  ) {
    return GestureDetector(
      onTap: ontab,
      child: Container(
        padding: EdgeInsets.all(20),
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(subtitle, style: TextStyle(fontSize: 15, color: Colors.white)),
          TextButton(onPressed: ontab, child: Text('View Details')),
        ],
      ),
    ));
  }
}
