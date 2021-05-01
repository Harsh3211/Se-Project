import 'AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SignInPage.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SE Project'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Text Recognition',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            // ignore: deprecated_member_use

            Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              // ignore: deprecated_member_use
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  print(emailController.text);
                  print(passwordController.text);
                  print(userNameController.text);

                  if (emailController.text.trim() != null) {

                    if (userNameController.text.trim() != null) {

                      if (passwordController.text.trim().length > 8) {

                        context.read<AuthService>().signUp (
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              userName: userNameController.text.trim(),
                            );
                        Navigator.pop(context);

                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(
                                  "Password should be greater than 8 charecters!"),
                            );
                          },
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Enter UserName."),
                          );
                        },
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Enter a valid Email."),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text('Already have an account?'),
                  // ignore: deprecated_member_use
                  FlatButton(
                    textColor: Colors.blue,
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInPage(),
                        ),
                      );
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
