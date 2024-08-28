import 'package:babycare2/controller/BreastfeedingController.dart';
import 'package:flutter/material.dart';


import 'package:babycare2/Resources/assets_manager.dart';
import 'package:babycare2/Resources/colors_manager.dart';
import 'package:babycare2/Resources/styles_manager.dart';
import 'package:babycare2/model/BreastfeedingSessi4.dart';
import 'package:iconsax/iconsax.dart';


import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NaturalBreastfeedingScreen extends StatelessWidget {
    NaturalBreastfeedingScreen({super.key});
  final BreastfeedingController controller = Get.put(BreastfeedingController());

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Total Elapsed Time
                Obx(() {
                  final totalElapsed = controller.getTotalElapsedTime();
                  if (totalElapsed.inSeconds == 0) {
                    return SizedBox.shrink();
                  }

                  final totalElapsedFormatted =
                      '${totalElapsed.inHours.toString().padLeft(2, '0')}:${(totalElapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(totalElapsed.inSeconds % 60).toString().padLeft(2, '0')}';

                  return Text(
                    '${"Total breastfeeding time".tr}: $totalElapsedFormatted',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }),
                SizedBox(height: 20),

                // Right and Left Breast Timers with Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        // Left Breast Elapsed Time
                        Obx(() {
                          final leftElapsedFormatted = '${controller.leftElapsedTime.value.inHours.toString().padLeft(2, '0')}:${(controller.leftElapsedTime.value.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.leftElapsedTime.value.inSeconds % 60).toString().padLeft(2, '0')}';

                          return Text(
                            leftElapsedFormatted,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          );
                        }),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            controller.startTimer(true); // Start left breast timer
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF49CBD2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: Text(
                            "Left Breast".tr,
                            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // Right Breast Elapsed Time
                        Obx(() {
                          final rightElapsedFormatted = '${controller.rightElapsedTime.value.inHours.toString().padLeft(2, '0')}:${(controller.rightElapsedTime.value.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.rightElapsedTime.value.inSeconds % 60).toString().padLeft(2, '0')}';

                          return Text(
                            rightElapsedFormatted,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          );
                        }),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            controller.startTimer(false); // Start right breast timer
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF49CBD2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: Text(
                            "Right Breast".tr,
                            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
                SizedBox(height:10 ),


                ElevatedButton.icon(
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
                SizedBox(height: 20),
                 ElevatedButton(
                  onPressed: () {
                    controller.stopTimer(); // Stop timer
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF49CBD2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    "stop".tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),

                // Session History
                Container(
                  height:Get.height- 590,
                  child: Obx(() {
                    final leftBreastCards = controller.leftBreastSessions.map((session) {
                      return _buildRecentCard(session, isLeftBreast: true);
                    }).toList();

                    final rightBreastCards = controller.rightBreastSessions.map((session) {
                      return _buildRecentCard(session, isLeftBreast: false);
                    }).toList();

                    return ListView(
                      children: [...leftBreastCards, ...rightBreastCards],
                    );
                  }),
                ),

              ],
            ),
          )
          // Add the UI for natural breastfeeding here
        ],
      ),
    ) ;
  }
  Widget RecentCard({required Widget widget, Color? background}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: background ?? Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: widget,
      ),
    );
  }
  Widget _buildRecentCard(BreastfeedingSession session, {required bool isLeftBreast}) {
    final elapsedTime = DateTime.now().difference(session.startTime);
    final timeAgo = _formatTimeAgo(elapsedTime);
    final durationText = _formatDuration(session.duration);
     final breastSide = isLeftBreast ? "Left Breast".tr : "Right Breast".tr;
    final sessionDateFormatted = _formatDate(session.date ?? DateTime.now());

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
                    '$timeAgo',
                    style: getRegularStyle(color: Colors.black, fontSize: 17),
                  ),
                  Text(
                    '$breastSide - $durationText',
                    style: getRegularStyle(color: Colors.black, fontSize: 13),
                  ),
                  Text(
                    '$sessionDateFormatted    ',
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
  }
  String _formatTimeAgo(Duration elapsedTime) {
    if (elapsedTime.inMinutes < 60) {
      final minutesAgo = 'min ago'.tr; // Translate "min ago"
      return '${elapsedTime.inMinutes} $minutesAgo';
    } else {
      final hours = elapsedTime.inHours;
      final minutes = elapsedTime.inMinutes % 60;
      final hrText = 'hr'.tr; // Translate "hr"
      final minText = 'min'.tr; // Translate "min"
      final agoText = 'ago'.tr; // Translate "ago"
      return '$hours $hrText ${minutes} $minText $agoText';
    }
  }

// Helper function to format session duration (e.g., "10 min")
  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final hrText = 'hr'.tr; // Translate "hr"
    final minText = 'min'.tr; // Translate "min"

    if (hours > 0) {
      return '$hours $hrText ${minutes} $minText';
    } else {
      return '${minutes} $minText';
    }
  }

  String _formatDate(DateTime date) {
    final formatter = DateFormat('MMM d, yyyy'); // You can adjust the format
    return formatter.format(date);
  }
}
