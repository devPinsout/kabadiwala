import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/authController.dart';
import 'package:kabadiwala/screens/language/selectLanguage.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  // final prefs = await SharedPreferences.getInstance();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await Get.putAsync(() async => AuthController()); 
  
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
        home: FutureBuilder(
          
          // Check the login status before deciding the initial route
          future: Get.find<AuthController>().isLoggedIn(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              //return LoginPage();
              return WelcomeScreen();
            }
            else{
              if (snapshot.data == true) {
                return MainScreen();
             } else {
               //return LoginPage();
               return WelcomeScreen();
               }
            }
            
         
           },
        ),
        
      ),
    );
  }
}

