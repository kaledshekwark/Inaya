import 'package:babycare2/Resources/assets_manager.dart';
import 'package:babycare2/Resources/colors_manager.dart';
import 'package:babycare2/Resources/styles_manager.dart';
 import 'package:babycare2/controller/PumpedBreastfeedingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class PumpedBreastfeedingScreen extends StatelessWidget {
  final PumpedBreastfeedingController controller = Get.put(PumpedBreastfeedingController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  '${controller.milkAmount.value.toStringAsFixed(0)} ${"ml".tr}',
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
                        color: Colors.white),
                    Slider(
                      value: controller.milkAmount.value,
                      onChanged: (value) {
                        controller.updateMilkAmount(value);
                      },
                      min: 0,
                      max: 150,
                      divisions: 100,
                      label: controller.milkAmount.value.toStringAsFixed(0),
                      activeColor: Color(0xFF49CBD2),
                      inactiveColor: Color(0x426667FF),
                    ),
                    IconButton(
                        onPressed: () {
                          controller.updateMilkAmountWithValue(-10);
                        },
                        icon: Icon(Icons.remove_circle_outline_outlined),
                        color: Colors.white),
                  ],
                ),
              ],),
          ),
        )),
        SizedBox(height: 10),
        Obx(() => Text(
          '${"time".tr}: ${controller.selectedTime.value.format(context)}',
          style: TextStyle(fontSize: 24, color: Color(0xFF49CBD2)),
        )),
        Obx(() => Text(
          '${"date".tr}: ${DateFormat.yMMMd().format(controller.selectedDate.value)}',
          style: TextStyle(fontSize: 24, color: Color(0xFF49CBD2)),
        )),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: Icon(Icons.calendar_today, color: Colors.white),
                label: Text('choose_date'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF49CBD2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                ),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    controller.setDate(pickedDate);
                  }
                },
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: ElevatedButton.icon(
                icon: Icon(Icons.access_time, color: Colors.white),
                label: Text('choose_time'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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
            ),
          ],
        ),

        Obx(() => DropdownButton<String>(
          value: controller.breastSide.value,
          items: [
            DropdownMenuItem(value: 'right', child: Text('Right Breast'.tr)),
            DropdownMenuItem(value: 'left', child: Text('Left Breast'.tr)),
            DropdownMenuItem(value: 'both', child: Text('both_breasts'.tr)),
          ],
          onChanged: (value) {
            controller.setBreastSide(value!);
          },
        )),
        Row(
          children: [
            SizedBox(width: 10,),
            Expanded(
              child: ElevatedButton(
                  onPressed: () async {
                    await controller.saveSession();
                  },
                  child: Text('save_data'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF49CBD2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  )),
            ),
            SizedBox(width: 10,),

          ],
        ),        Container(
          height: Get.height - 605,
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
                                '${"date".tr}: ${session['date']}',
                                style: getRegularStyle(color: Colors.black, fontSize: 17),
                              ),
                              Text(
                                '${"time".tr}: ${session['time']}',
                                style: getRegularStyle(color: Colors.black, fontSize: 17),
                              ),
                              Text(
                                '${"amount".tr}: ${session['milkAmount']} ${"ml".tr}',
                                style: getRegularStyle(color: Colors.black, fontSize: 13),
                              ),
                              Text(
                                '${"breast".tr}: ${session['breastSide'] == 'right' ? "Right Breast".tr : session['breastSide'] == 'left' ? "Left Breast".tr : "both_breasts".tr}',
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
    );
  }

  Widget RecentCard({required Widget widget, Color? background}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 125,
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: background ?? Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        child: widget,
      ),
    );
  }
}
