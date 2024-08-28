
import 'package:babycare2/views/ArtificialBreastfeedingScreen.dart';
import 'package:babycare2/views/BreastfeedingChart.dart';
import 'package:babycare2/views/FeedingScreen.dart';
import 'package:babycare2/views/NaturalBreastfeedingScreen.dart';
import 'package:babycare2/views/PumpedBreastfeedingScreen.dart';
import 'package:babycare2/views/PumpedBreastfeedingScreenChart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:babycare2/controller/BreastfeedingController.dart';


class MianBabyScreenView extends StatelessWidget {
  MianBabyScreenView({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Color(0xFF49CBD2),
          centerTitle: true,
          title: Text(
            'Baby Care'.tr,
            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Get.toNamed('/InfoScreen');
            },
          ),
          bottom: TabBar(labelColor: Colors.white,
            tabs: [
              Tab(text: "Natural Breastfeeding".tr), // Natural Breastfeeding
              Tab(text: "Artificial Breastfeeding".tr), // Artificial Breastfeeding
               Tab(text: "Expressed Breastfeeding".tr), // Artificial Breastfeeding
               Tab(text: "food".tr), // Artificial Breastfeeding
             ],
          ),
        ),
        body: TabBarView(
          children: [
            // First tab content (Natural Breastfeeding)
            NaturalBreastfeedingScreen(),
            // Second tab content (Artificial Breastfeeding)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ArtificialBreastfeedingScreen()
                  // Add the UI for artificial breastfeeding here
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  PumpedBreastfeedingScreen()
                  // Add the UI for artificial breastfeeding here
                ],
              ),
            ),


            FeedingScreen(),

          ],
        ),
      ),
    );
  }
}

