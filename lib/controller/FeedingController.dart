import 'package:babycare2/model/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedingController extends GetxController {
  var feedingAmount = 0.0.obs;
  var selectedTime = TimeOfDay.now().obs;

  var sessions = <Map<String, dynamic>>[].obs;

  var foodController = TextEditingController();  // Controller for food name
  var commentsController = TextEditingController(); // Controller for comments

  final dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    loadSessions();
  }

  void updateMilkAmount(double amount) {
    feedingAmount.value = amount;
  }

  void updateMilkAmountWithValue(double amount) {
   if(feedingAmount.value<140) {
     feedingAmount.value += amount;
   }
  }

  void setTime(TimeOfDay time) {
    selectedTime.value = time;
  }



  Future<void> saveSession() async {
    String formattedTime = '${selectedTime.value.hour}:${selectedTime.value.minute}';
    await dbHelper.insertFeedingSession(feedingAmount.value, formattedTime , foodController.text, commentsController.text);
    await loadSessions();
  }

  Future<void> loadSessions() async {
    sessions.value = await dbHelper.getFeedingSessions();
  }
}
