import 'dart:convert';

import 'package:firstshop/pages/detailpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        child: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No data found'));
            }

            final List<dynamic> data = json.decode(snapshot.data!);

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return mybox(
                  data[index]['title'],
                  data[index]['subtitle'],
                  data[index]['imageUrl'],
                  data[index]['detail'],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget mybox(String title, String subtitle, String imageUrl,String detail) {
    var v1, v2, v3, v4;
     v1=title;
     v2=subtitle;
     v3=imageUrl;
     v4=detail;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
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
            TextButton(
              onPressed: () {
                print("nextpage>>");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Detailpage(v1, v2, v3, v4)),
                );
              },
              child: Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}
