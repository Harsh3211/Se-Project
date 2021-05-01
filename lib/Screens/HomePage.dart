import 'package:flutter/material.dart';
import 'package:flutter_app/Auth/AuthService.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String username;

  HomePage(this.username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72.0,
        title: Text(
          username,
          style: TextStyle(fontSize: 28.0),
        ),
        elevation: 8.0,
        actions: [
          // ignore: deprecated_member_use
          RaisedButton(
            padding: EdgeInsets.all(8.0),
            onPressed: () {
              context.read<AuthService>().signOut();
              //Navigator.pop(context);
            },
            child: Column(
              children: [
                Icon(
                  Icons.exit_to_app,
                  size: 30.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "LogOut",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white
                  ),
                )
              ],
            ),
            color: Colors.blue,
          ),
        ],
      ),
      body: (username == null)
          ? Center(child: CircularProgressIndicator())
          : Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
        child: GridView.count(
          padding: EdgeInsets.all(10.0),
          crossAxisCount: 2,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: Column(
                children: [
                  Icon(
                    Icons.add_a_photo,
                    size: 100.0,
                  ),
                  Text(
                    'New',
                    style: TextStyle(fontSize: 25.0, color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/files');
              },
              child: Column(
                children: [
                  Icon(
                    Icons.insert_drive_file,
                    size: 100.0,
                  ),
                  Text(
                    'Files',
                    style: TextStyle(fontSize: 25.0, color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
              child: Column(
                children: [
                  Icon(
                    Icons.question_answer,
                    size: 100.0,
                  ),
                  Text(
                    'About',
                    style: TextStyle(fontSize: 25.0, color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/help');
              },
              child: Column(
                children: [
                  Icon(
                    Icons.library_books,
                    size: 100.0,
                  ),
                  Text(
                    'Help',
                    style: TextStyle(fontSize: 25.0, color: Colors.blueGrey),
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
