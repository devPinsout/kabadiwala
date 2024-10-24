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
import 'package:kabadiwala/widgets/customDrawer.dart';

class CommonPageLayout extends StatefulWidget {
  final Widget body;
  final String title;

  const CommonPageLayout({Key? key, required this.body, required this.title}) : super(key: key);

  @override
  _CommonPageLayoutState createState() => _CommonPageLayoutState();
}

class _CommonPageLayoutState extends State<CommonPageLayout> {
  OverlayEntry? _overlayEntry;

  void _showDropdownPopup() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    // Calculate the top position considering the safe area
    final double statusBarHeight = MediaQuery.of(context).padding.top; // Height of the status bar
    final double appBarHeight = AppBar().preferredSize.height; // Height of the AppBar

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              _hideDropdownPopup(); // Dismiss the popup on tapping outside
            },
            child: Container(
              color: Colors.transparent, // Make the background tappable
              height: MediaQuery.of(context).size.height, // Fill the screen
            ),
          ),
          Positioned(
            top: statusBarHeight, // Adjust position below the AppBar
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent, // Use transparent to allow for background
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select pickup address",
                          style: TextStyle(color: AppColors.blackColor, fontSize: 18.sp, fontWeight: FontWeight.bold),textScaler: TextScaler.linear(1.0),
                        ),
                        Icon(Icons.arrow_drop_down_circle_outlined, color: AppColors.primaryColor),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                       border: Border.all(
                       color: AppColors.primaryColor, // Border color
                        width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Home"),
                            Text("103, Railway Coloney, Lucknow"),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1.h,
                          width: 100.w,
                          color: AppColors.lightGreyColor,
                          
                        ),

                        SizedBox(width: 4.w,),


                        Text("or",style: TextStyle(fontSize: 14.sp,color: AppColors.lightGreyColor),textScaler: TextScaler.linear(1.0),),

                        SizedBox(width: 4.w,),
                        Container(
                          height: 1.h,
                          width: 100.w,
                          color: AppColors.lightGreyColor,
                        )
                      ],
                    ),

                    SizedBox(height: 20.h,),

                    InkWell(
                      
                      onTap: (){
                        _hideDropdownPopup();
                         Navigator.push(
                           context,
                  MaterialPageRoute(
                    builder: (context) => SetLocationScreen(),
                  ),
                );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_city_outlined),
                          SizedBox(width: 15.w,),
                          Text("Add new Address",style: TextStyle(fontSize: 18.sp),textScaler: TextScaler.linear(1.0),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _hideDropdownPopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Set the height of the AppBar
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, 
            iconTheme: IconThemeData(
          color: AppColors.whiteColor, // Set the color you want for the drawer icon
        ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pickup location - Home",
                  style: TextStyle(fontSize: 18.sp, color: AppColors.whiteColor),
                ),
                SizedBox(height: 3.h),
                Text(
                  "103, Railway Station Coloney Lucknow",
                  style: TextStyle(fontSize: 16.sp, color: AppColors.whiteColor),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.white),
                onPressed: _showDropdownPopup,
              ),
            ],
          ),
        ),
      ),
      body: widget.body,
      drawer: CustomDrawer()
    );
  }
}
