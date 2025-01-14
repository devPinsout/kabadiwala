
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/screens/home/home.dart';
import 'package:kabadiwala/screens/rateList/rateList.dart';
import 'package:kabadiwala/utils/colors.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

 final AppController controller = (Get.isRegistered<AppController>())?Get.find<AppController>():Get.put(AppController());
  
 final List<ColorFiltered> unselectedIcons = [
    ColorFiltered(
      colorFilter: const ColorFilter.mode(
        Colors.white, 
        BlendMode.srcIn,
      ),
      child: SvgPicture.asset(
        "assets/images/soldScrap.svg",
        width: 24,
        height: 24,
      ),
    ),
    ColorFiltered(
      colorFilter: const ColorFilter.mode(
        Colors.white, 
        BlendMode.srcIn,
      ),
      child: SvgPicture.asset(
        "assets/images/soldScrap.svg",
        width: 24,
        height: 24,
      ),
    ),

   
  ];

  final List<ColorFiltered> selectedIcons = [
    ColorFiltered(
      colorFilter: ColorFilter.mode(
        AppColors.darkYellowColor, 
        BlendMode.srcIn,
      ),
      child: SvgPicture.asset(
        "assets/images/soldScrap.svg",
        width: 24,
        height: 24,
      ),
    ),
    ColorFiltered(
      colorFilter: ColorFilter.mode(
        AppColors.darkYellowColor, 
        BlendMode.srcIn,
      ),
      child: SvgPicture.asset(
        "assets/images/soldScrap.svg",
        width: 24,
        height:24,
      ),
    ),

   
  ];

  final List<BottomNavigationBarItem> navbarItem=[
    BottomNavigationBarItem(icon:
    ColorFiltered(
      colorFilter: ColorFilter.mode(
        AppColors.primaryColor, 
        BlendMode.dstIn,
      ),
      child: SvgPicture.asset(
        "assets/images/soldScrap.svg",
        width: 24,
        height: 24,
      ),
    ),label: "Sell scrap"),
    BottomNavigationBarItem(icon: SvgPicture.asset("assets/images/soldScrap.svg"),label: "Rate List"),
   
  ];

  final List<Widget> navBody=[
    HomeScreen(),RateListScreen()

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           Obx(()=> Expanded(child: navBody.elementAt(controller.currentNavIndex.value),)),
        ],
      ),
      bottomNavigationBar: Obx(()=>
          BottomNavigationBar(currentIndex: controller.currentNavIndex.value,items:
          List.generate(
            navbarItem.length,
                (index) => BottomNavigationBarItem(
              icon: controller.currentNavIndex.value == index
                  ?
              selectedIcons[index]
                  : unselectedIcons[index],
              label: navbarItem[index].label,
            ),
          ),

            backgroundColor: AppColors.primaryColor,type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.darkYellowColor,
            unselectedItemColor: Colors.white,
            unselectedIconTheme: IconThemeData(color: Colors.black12),
            // selectedIconTheme: IconThemeData(
            //     //fill: .8,
            //     color: AppColors.darkYellowColor
            // ),
            onTap: (value){
              print('Tapped index: $value');
              //AppController().isCategoryPage.value = false;
              controller.currentNavIndex.value=value;
            },
            selectedLabelStyle: const TextStyle(),),
      ),
    );
  }
}
