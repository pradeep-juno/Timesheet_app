import 'package:flutter/material.dart';

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Next Page'),
          backgroundColor: Colors.red,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Pradeep',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Jayakumar',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Prasanth',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
