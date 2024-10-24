import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/screens/language/selectLanguage.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.72, 783.27),
      minTextAdapt: true,
      child: GetMaterialApp(
        
        debugShowCheckedModeBanner: false,
        title: 'Scrap Adda',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SelectLanguage(),
      ),
    );
  }
}

