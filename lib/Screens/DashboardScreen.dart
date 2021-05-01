import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/DetailScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  File _image;
  String _path;
  final picker = ImagePicker();


  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _path = pickedFile.path;
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _path = pickedFile.path;
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 70.0,
            elevation: 5.0,
            backgroundColor: Colors.blue,
            title: Text(
              'SE Project',
              style: TextStyle(
                fontSize: 28.0,
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: 10.0,
              ),
              FloatingActionButton(
                mini: true,
                onPressed: () async {
                  if (await Permission.camera.request().isGranted) {
                    print('Button pressed');
                    try {
                      getImageCamera();
                      print('Route Executed');
                    } catch (e) {
                      print('Error Occured');
                      print(e);
                    }
                  } else if (await Permission.camera.isPermanentlyDenied) {
                    openAppSettings();
                  }
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.blue,
                  size: 22.0,
                ),
                backgroundColor: Colors.white,
              ),
              SizedBox(
                width: 10.0,
              ),
              FloatingActionButton(
                mini: true,
                onPressed: () async {
                  if (await Permission.camera.request().isGranted) {
                    print('Button pressed');
                    try {
                      getImageGallery();
                      print('Route Executed');
                    } catch (e) {
                      print('Error Occured');
                      print(e);
                    }
                  } else if (await Permission.camera.isPermanentlyDenied) {
                    openAppSettings();
                  }
                },
                child: Icon(
                  Icons.image,
                  color: Colors.blue,
                  size: 22.0,
                ),
                backgroundColor: Colors.white,
              ),
              SizedBox(
                width: 10.0,
              ),
              FloatingActionButton(
                mini: true,
                onPressed: () async {
                    if (_image != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(_path),
                        ),
                      );
                    }
                },
                child: Icon(
                  Icons.send,
                  color: Colors.blue,
                  size: 22.0,
                ),
                backgroundColor: Colors.white,
              ),
              SizedBox(
                width: 10.0,
              ),
            ]
        ),
      body: Center(
        child:Container(
          child: _image == null ? Text('No image selected.',style: TextStyle(fontSize: 20.0),) : Image.file(_image),
        ),
      ),
    );
  }
}