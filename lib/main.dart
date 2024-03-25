import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_view.dart'; // Your LoginView
import 'task_list_view.dart'; // Your main app screen (TaskListView)
import 'authentication_service.dart'; // Your AuthenticationService

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MyApp());
}


class MyApp extends StatelessWidget {
   MyApp({super.key});
  // Create the AuthenticationService 
  //instance outside of the build method
  final AuthenticationService authService = AuthenticationService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task Organizer',
      // Theme data and other MaterialApp properties...
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return const LoginView(); // Pass the authService here
            }
            return const TaskListView(); // Your main app screen
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
