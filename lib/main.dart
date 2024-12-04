import 'package:flutter/material.dart';
import 'package:luzmed/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:luzmed/views/perfil.dart';
import 'package:luzmed/views/select.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const LuzMed());
}

class LuzMed extends StatelessWidget {
  const LuzMed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LuzMed",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SelectScreen(),
    );
  }
}