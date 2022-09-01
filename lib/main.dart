import 'package:chatapp/Pages/regester.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Pages/chat_page.dart';
import 'Pages/login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Loginpage.Id: ((context) => Loginpage()),
        Regester_page.Id: ((context) => Regester_page()),
        Chat_page.Id: ((context) => Chat_page())
      },
      initialRoute: Loginpage.Id,
    );
  }
}
