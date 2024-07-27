import 'package:flutter/material.dart';
import 'package:flutter_gemini_test/provider/geminiProvider.dart';
import 'package:flutter_gemini_test/provider/mediaProvider.dart';
import 'package:flutter_gemini_test/screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GeminiProvider()),
        ChangeNotifierProvider(create: (context) => MediaProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Gemini ✨',
        home: HomeScreen(),
      ),
    );
  }
}



