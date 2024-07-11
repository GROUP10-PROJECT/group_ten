import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dash/src/pages/welcome_page_ui.dart';
//import 'widgets/widget_tree.dart';

import 'screens/main_screen.dart';
//import 'screens/cart_screen.dart';
import 'screens/login_screen.dart';
import 'widgets/auth_service.dart';

//import 'screens/signup_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FOOD DASH",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WidgetTree(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          return user == null ? LoginScreen() : MainScreen();
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return WelcomePage();
          } else {
            return LoginScreen();
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}


/*import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
// Import your home page widget here

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'food Dash',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(), // Set your home page widget here
    );
  }
}
*/