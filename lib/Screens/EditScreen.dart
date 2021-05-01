import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';
import 'dart:convert'; // access to jsonEncode()
import 'dart:io'; // access to File and Directory classes

// ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  String recognizedText;
  String filePath;

  // ignore: non_constant_identifier_names

  EditScreen({this.recognizedText, this.filePath});

  @override
  _EditScreenState createState() => _EditScreenState(recognizedText, filePath);
}

class _EditScreenState extends State<EditScreen> {
  ZefyrController _controller;
  FocusNode _focusNode;
  String text = 'No Text Found :(';
  String filePath;

  String fileName = 'Untitled';
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat.yMd().add_jms();
  // ignore: non_constant_identifier_names
  final User = FirebaseAuth.instance.currentUser;

  _EditScreenState(this.text, this.filePath);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    _loadDocument().then((document) {
      setState(() {
        _controller = ZefyrController(document);
      });
    });
  }

  Future<String> getFilePath() async {
    Directory currdir = await getApplicationDocumentsDirectory();
    var dir = Directory('${currdir.path}/${User.uid}');

    if (filePath == null) {
      fileName =
          formatter.format(now).replaceAll(' ', ':').replaceAll('/', ':');
      print(fileName);

      if (await dir.exists()) {
        print('Directory Exists');
      } else {
        print('Creating Dir');
        dir.create();
      }

      return '${dir.path}/$fileName.json';
    } else {
      return '${dir.path}/$filePath.json';
    }
  }

  Future<void> deleteFile() async {
    final file = File(await getFilePath());
    try {
      print(file.path);
      await file.delete();
      print("File Deleted");
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteConfirm(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete File'),
          content: Text('Are you sure that you want to delete this file!'),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text(
                'DELETE',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                deleteFile();
                Navigator.pop(context);
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

  Future<NotusDocument> _loadDocument() async {
    final file = File(await getFilePath());

    if (await file.exists()) {
      final contents = await file.readAsString();
      return NotusDocument.fromJson(
        jsonDecode(contents),
      );
    } else {
      print('Text:');
      print(text.length);

      if(text.length == 0) {
        text = 'No text Found :(\n';
      }
      final Delta delta = Delta()..insert(text);
      return NotusDocument.fromDelta(delta);
    }
  }

  void _saveDocument(BuildContext context) async {
    final contents = jsonEncode(_controller.document);
    // Save our document
    final file = File(await getFilePath());
    // And show a snack bar on success.
    file.writeAsString(contents).then(
      (_) {
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Saved."),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // If _controller is null we show Material Design loader, otherwise
    // display Zefyr editor.
    final Widget body = (_controller == null)
        ? Center(child: CircularProgressIndicator())
        : ZefyrScaffold(
            child: ZefyrEditor(
              padding: EdgeInsets.all(16),
              controller: _controller,
              focusNode: _focusNode,
            ),
          );

    return Scaffold(
        appBar: AppBar(
          title: Text(
            filePath == null ? "Text Editor" : filePath,
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
          actions: <Widget>[
            filePath != null
                ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteConfirm(context),
                    iconSize: 30.0,
                  )
                : SizedBox(
                    width: 5.0,
                  ),
            SizedBox(
              width: 10.0,
            ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () => _saveDocument(context),
              iconSize: 30.0,
            ),
          ],
        ),
        body: body);
  }
}
