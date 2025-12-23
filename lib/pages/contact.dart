import 'package:firstshop/pages/apple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final items = List<String>.generate(1000, (i) => "Item $i");

       @override
  Widget build(BuildContext context) {
    List mydata = ['apple', 'papaya', 'banana', 'orange'];
    return Scaffold(
      appBar: AppBar(title: Text('Contact Page')),
      body: ListView(
        children: [
          ListTile(
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ApplePage()));},
            leading: FlutterLogo(),
            title: Text(mydata[0]),
          ),
          ListTile(
            onTap: () {},
            leading: FlutterLogo(),
            title: Text(mydata[1]),
          ),
          ListTile(
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));},
            leading: FlutterLogo(),
            title: Text(mydata[2]),
          ),
          ListTile(
            onTap: () {},
            leading: FlutterLogo(),
            title: Text(mydata[3]),
          ),
        ],
      ),
    );
  }
}
