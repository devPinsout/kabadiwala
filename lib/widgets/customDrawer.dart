import 'package:flutter/material.dart';
import 'package:kabadiwala/screens/aboutus/about.dart';
import 'package:kabadiwala/screens/home/profile/profile.dart';
import 'package:kabadiwala/screens/howItworks/howItworks.dart';
import 'package:kabadiwala/screens/language/selectLanguage.dart';
import 'package:kabadiwala/screens/location/setLocation.dart';
import 'package:kabadiwala/screens/pickupRequest/pickupRequest.dart';
import 'package:kabadiwala/screens/scrapImpact/scrapImpact.dart';
import 'package:kabadiwala/screens/shareus/shareus.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: SafeArea( // Ensure it covers the screen, including areas behind the status and navigation bar
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                  SizedBox(width: 15.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome,",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Text(
                        "Deepak",
                        style: TextStyle(
                          fontSize: 19.sp,
                          color: AppColors.whiteColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.fire_truck, color: AppColors.whiteColor),
              title: Text(
                'Pickup Requests',
                style: TextStyle(fontSize: 18.sp, color: AppColors.whiteColor),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PickupRequestScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.card_travel, color: AppColors.whiteColor),
              title: Text(
                'Scrap Impact',
                style: TextStyle(fontSize: 18.sp, color: AppColors.whiteColor),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScrapImpactScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.description, color: AppColors.whiteColor),
              title: Text(
                'How it works',
                style: TextStyle(fontSize: 18.sp, color: AppColors.whiteColor),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HowItWorksScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: AppColors.whiteColor),
              title: Text(
                'Share us',
                style: TextStyle(fontSize: 18.sp, color: AppColors.whiteColor),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShareusScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: AppColors.whiteColor),
              title: Text(
                'Profile',
                style: TextStyle(fontSize: 18.sp, color: AppColors.whiteColor),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.description_sharp, color: AppColors.whiteColor),
              title: Text(
                'About',
                style: TextStyle(fontSize: 18.sp, color: AppColors.whiteColor),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.mobile_friendly_sharp, color: AppColors.whiteColor),
              title: Text(
                'Change Language',
                style: TextStyle(fontSize: 18.sp, color: AppColors.whiteColor),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectLanguage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: AppColors.whiteColor),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18.sp, color: AppColors.whiteColor),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
