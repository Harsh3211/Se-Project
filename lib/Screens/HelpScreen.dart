import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  Future<void> _launched;

  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Contact Us:",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15.0,),
            Text(
              "For All Queries, kindly Mail Us.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 30.0,),
            TextButton(
              onPressed: () {
                setState(() {
                  _launched = _openUrl('mailto: harsh.wadhawe55@gmail.com');
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.mail),
                Text(" Mail",style: TextStyle(fontSize: 24),),
              ],),
            ),
          ],
        ),
      ),
    );
  }
}
