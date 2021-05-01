import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:flutter_app/Screens/EditScreen.dart';

class FileDir extends StatefulWidget {
  @override
  _FileDirState createState() => _FileDirState();
}

class _FileDirState extends State<FileDir> {
  String directory;
  // ignore: deprecated_member_use
  List file = new List();

  // ignore: non_constant_identifier_names
  final User = FirebaseAuth.instance.currentUser;
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _listofFiles();
  }

  Future<File> changeFileNameOnly({String oldname, String newname}) async {
    directory = (await getApplicationDocumentsDirectory()).path;
    print(directory);

    var dir = Directory('$directory/${User.uid}');
    var path = '${dir.path}/$oldname.json';
    File file = File(path);
    print('Inside Change file name');
    print(path);
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newname+'.json';
    print("Done with Rename");
    print(newPath);
    return file.rename(newPath);
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, String oldname) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rename File'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: oldname),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
//            FlatButton(
//              child: Text('Delete',style: TextStyle(color: Colors.red,),),
//              onPressed: () async {
//                await deleteFile(filename: oldname);
//                print('File Deleted');
//                Navigator.pop(context);
//              },
//            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                print(_textFieldController.text);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushNamed(context, '/files');
              },
            ),
          ],
        );
      },
    );
  }

  void _listofFiles() async {
    directory = (await getApplicationDocumentsDirectory()).path;

    var dir = Directory('$directory/${User.uid}');

    if (await dir.exists()) {
      print('Directory Exists');
    } else {
      print('Creating Dir');
      dir.create();
    }

    setState(() {
      file = io.Directory("${dir.path}/").listSync();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Files"),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: file.length,
        itemBuilder: (BuildContext context, int index) {
          return TextButton(
            onPressed: () async {
              print(User.uid);
              print(file[index].toString());
              var filename = file[index].toString().substring(
                    file[index].toString().lastIndexOf('/') + 1,
                    file[index].toString().length - 6,
                  );
              print("Inside Raised Btn");
              print(filename);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditScreen(
                    filePath: filename,
                  ),
                ),
              );
            },
            onLongPress: () async{
              print('Inside Long Press');
              var oldname = file[index].toString().substring(
                    file[index].toString().lastIndexOf('/') + 1,
                    file[index].toString().length - 6,
                  );
              var newFilename;
              print("Old file name : " + oldname);
              await _displayTextInputDialog(context, oldname);

              print(_textFieldController.text);

              if (_textFieldController.text.length != 0) {
                newFilename = _textFieldController.text;
                print('NewFile name: '+newFilename);
                changeFileNameOnly(
                  oldname:oldname,
                  newname: newFilename,
                );
              } else {
                print('No text in textField');
              }

              print("This is a Long Press " + index.toString());
            },
            child: Column(
              children: [
                Icon(
                  Icons.insert_drive_file,
                  size: 136.0,
                ),
                Text(
                  file[index].toString().substring(
                        file[index].toString().lastIndexOf('/') + 1,
                        file[index].toString().length - 6,
                      ),
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
