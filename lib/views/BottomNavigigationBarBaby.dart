import 'package:babycare2/Resources/app_data.dart';
import 'package:babycare2/Resources/colors_manager.dart';
import 'package:babycare2/controller/ChildInfoController.dart';
import 'package:babycare2/views/ChartScreenView.dart';
import 'package:babycare2/views/babys_creen.dart';
import 'package:babycare2/views/momean_book.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';





class BottomNavigigationBarBaby  extends StatelessWidget {

  BottomNavigigationBarBaby({Key? key}) : super(key: key);
  final ChildInfoController controller = Get.find( );

  final List<Widget> screens =  [

    MianBabyScreenView(),
    ChartScreenView(),

    MomeanBook(),
    // ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: Obx(
            () {
          return BottomNavigationBar(

            unselectedItemColor: AppColors.black,
            currentIndex: controller.currentBottomNavItemIndex.value,
            showUnselectedLabels: true,
            onTap: controller.switchBetweenBottomNavigationItems,
            fixedColor: AppColors.white,
            backgroundColor: AppColors.primary,
            items: AppData.bottomNavigationItems
                .map(
                  (element) => BottomNavigationBarItem(
                  icon: element.icon, label: element.label),
            )
                .toList(),
          );
        },
      ),
      body: Obx(() => screens[controller.currentBottomNavItemIndex.value]),
    );
  }
}
