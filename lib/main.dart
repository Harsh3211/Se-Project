import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_app/Screens/FileDir.dart';
import 'package:flutter_app/Screens/AboutScreen.dart';
import 'package:flutter_app/Screens/HelpScreen.dart';
import 'package:flutter_app/Auth/AuthService.dart';
import 'package:flutter_app/Screens/DashboardScreen.dart';
import 'package:flutter_app/Screens/DetailScreen.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/Auth/SignInPage.dart';
import 'package:flutter_app/Auth/SignUpPage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String get username => null;

  String get path => null;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Text Recognition',
        initialRoute: '/',
        routes: {
          '/signUp': (context) => SignUpPage(),
          '/homepage': (context) => HomePage(username),
          '/dashboard': (context) => DashboardScreen(),
          '/details': (context) => DetailScreen(path),
          '/help': (context) => HelpScreen(),
          '/about': (context) => AboutScreen(),
          '/files': (context) => FileDir(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();



    if (firebaseUser != null) {
      if (firebaseUser.displayName != null) {
        print("Inside Auth Wrapper");
        print(firebaseUser.displayName);
        print(firebaseUser.uid);
        return HomePage(firebaseUser.displayName);
      }
    } else {
      print('Try Again');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('SE Project'),
      ),
      body: SignInPage(),
    );
  }
}
