import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {

  String p1 = """This is Software Engineering Project of Third Year Computer Science. You can convert images to text.\n\nWhen you access the phone number/URL written in magazines or brochures, it's really hard to input the URL or phone number by the keyboard. So Use our application named NotesScanner! Because it automatically recognize the characters from an image and will provide that phone-number or URL.\n\nWhen you record the memo written on the blackboard or white board, it's very troublesome to transcript it by the keyboard. But you can do it very easily by our application named NotesScanner! It's possible to record contents immediately!\n
              """;

  String features = """
●  Fast scanning speed
●  High Accuracy
●  Support photos of your album
●  Support handwritten notes
●  Saves extracted data in PDF/DOC file
●  Recognized text, it is possible to perform the following operations :
    - URL access
    - Telephone call
    - Copy to clipboard
    - Delete/Paste any data 
    - etc...
  """;

  String permissions = """●  Camera permission\n●  Network Access\n●  File Storage\n""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Screen")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description :\n",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
            Text(p1,style: TextStyle(fontSize: 18.0),),
            Text("Features :\n",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
            Text(features,style: TextStyle(fontSize: 18.0),),
            Text("Permissions :\n",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
            Text(permissions,style: TextStyle(fontSize: 18.0),),
            Text("Developers :\n",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
            Text("1)\t111803173\t:\tHarsh Wadhawe  \n2)\t111803146\t:\tMd Aawesh Patanwala \n",style: TextStyle(fontSize: 20.0),),
          ],
        ),
      ),
    );
  }
}
