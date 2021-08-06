import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mrhairsaloon/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TutorTown',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          primarySwatch: Colors.pink,
          appBarTheme: AppBarTheme(
            color: Color(0xFFFDBAA4),
            elevation: 5.0,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: Theme.of(context).textTheme,
          ),
        ),
        home: Wrapper());
  }
}
