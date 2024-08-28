import 'package:babycare2/Resources/assets_manager.dart';
import 'package:babycare2/Resources/colors_manager.dart';
import 'package:babycare2/Resources/styles_manager.dart';
import 'package:babycare2/controller/%D9%90ArtificialBreastFeedingcController.dart';
import 'package:babycare2/controller/FeedingController.dart';
import 'package:babycare2/controller/PumpedBreastfeedingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FeedingScreen extends StatelessWidget {
  final FeedingController controller = Get.put(FeedingController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Food Name Input Field
            TextField(

              controller: controller.foodController,
              decoration: InputDecoration(
                labelText: 'food'.tr, // Translate "اسم الطعام"
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF49CBD2), width: 3),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Comments Input Field
            TextField(
              controller: controller.commentsController,
              decoration: InputDecoration(
                labelText: 'comments'.tr, // Translate "الملاحظات"
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 10),
      
            // Milk Amount Slider
            Obx(() => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 115,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFACEAEC),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      '${controller.feedingAmount.value.toStringAsFixed(0)} ${'gram'.tr}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.updateMilkAmountWithValue(10);
                          },
                          icon: Icon(Icons.add_circle_outline_outlined),
                          color: Colors.white,
                        ),
                        Slider(
                          value: controller.feedingAmount.value,
                          onChanged: (value) {
                            controller.updateMilkAmount(value);
                          },
                          min: 0,
                          max: 150,
                          divisions: 100,
                          label: controller.feedingAmount.value.toStringAsFixed(0),
                          activeColor: Color(0xFF49CBD2),
                          inactiveColor: Color(0x426667FF),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.updateMilkAmountWithValue(-10);
                          },
                          icon: Icon(Icons.remove_circle_outline_outlined),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(height: 10),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(
                  '${'time'.tr}: ${controller.selectedTime.value.format(context)}',
                  style: TextStyle(fontSize: 24, color: Color(0xFF49CBD2)),
                )),
                ElevatedButton.icon(
                  icon: Icon(Icons.access_time, color: Colors.white),
                  label: Text('time_picker'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)), // Translate "اختر الوقت"
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF49CBD2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: controller.selectedTime.value,
                    );
                    if (pickedTime != null) {
                      controller.setTime(pickedTime);
                    }
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                await controller.saveSession();
              },
              child: Text('save_data'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)), // Translate "احفظ البيانات"
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF49CBD2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              ),
            ),
            Container(
              height: Get.height - 582,
              child: SingleChildScrollView(
                child: Obx(() => Wrap(
                  children: controller.sessions.map((session) {
                    return RecentCard(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(AppAssets.bottle, scale: 0.8),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${'time'.tr}: ${session['time']}',
                                    style: getRegularStyle(color: Colors.black, fontSize: 17),
                                  ),
                                  Text(
                                    '${'quantity'.tr}: ${session['foodAmount']} ${'gram'.tr}',
                                    style: getRegularStyle(color: Colors.black, fontSize: 13),
                                  ),
                                  Text(
                                    '${'food'.tr}: ${session['foodName']}',
                                    style: getRegularStyle(color: Colors.black, fontSize: 13),
                                  ),
                                  Text(
                                    '${'comments'.tr}: ${session['comments']}',
                                    style: getRegularStyle(color: Colors.black, fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 45,
                                    width: 2,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              SizedBox(width: 5),
                              Icon(Iconsax.timer_1, size: 40),
                            ],
                          ),
                        ],
                      ),
                      background: AppColors.card1,
                    );
                  }).toList(),
                )),
              ),
            ),
      
          ],
        ),
      ),
    );
  }
}
Widget RecentCard({required Widget widget, Color? background}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 150,
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: background ?? Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: widget,
    ),
  );
}
