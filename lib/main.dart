import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:the_word/pages/home/page.dart';

//  home/2024-04-10T19:14:59.556002


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.clear();
  final isIOS = Platform.isIOS;
  // if (isIOS) {
  runApp(const IOSApp());
  // } else {
  //   runApp(const AndroidApp());
  // }
}

class IOSApp extends StatelessWidget {
  const IOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        scaffoldBackgroundColor: Color(0xfff1f0f6),
        primaryColor: Color(0xff6486ff),
      ),
      debugShowCheckedModeBanner: false,
      title: 'The Word',
      home: HomePageIOS(),
    );
  }
}

class AndroidApp extends StatelessWidget {
  const AndroidApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
