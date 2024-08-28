import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:babycare2/model/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArtificialBreastfeedingController extends GetxController {
  var milkAmount = 0.0.obs;  // Observable for milk amount
  var selectedTime = TimeOfDay.now().obs;  // Observable for selected time
  var selectedDate = DateTime.now().obs;  // Observable for selected date
  var sessions = <Map<String, dynamic>>[].obs;  // Observable list for sessions
  var weeklyData = List<double>.filled(7, 0.0).obs;
  var milkConsumptionData = <double>[].obs;
  final dbHelper = DatabaseHelper();
  var birthdate = DateTime.now().obs;


  @override
  void onInit() async{
    super.onInit();
    loadChildInfo();
   await loadSessions();
    _aggregateDataByWeekday();
    _calculateMilkConsumptionData();
  }
  void _calculateMilkConsumptionData() {
    DateTime today = DateTime.now();
    int ageInDays = today.difference(birthdate.value).inDays;

    // تهيئة قائمة استهلاك الحليب اليومية بطول عمر الطفل بالأيام
    milkConsumptionData.value = List<double>.filled(ageInDays + 1, 0.0);

    // توزيع البيانات على الأيام بناءً على التواريخ المسجلة في الجلسات
    for (var session in sessions) {
      String dateString = session['date'];
      try {
        DateTime sessionDate = DateTime.parse(dateString);
        int dayIndex = sessionDate.difference(birthdate.value).inDays;

        if (dayIndex >= 0 && dayIndex < milkConsumptionData.length) {
          milkConsumptionData[dayIndex] += session['milkAmount'];
        }
      } catch (e) {
        print("Error parsing date: $dateString");
      }
    }
  }
  // باقي الدوال...

  void loadChildInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? birthdateString = prefs.getString('birthdate');
    if (birthdateString != null) {
      birthdate.value = DateTime.parse(birthdateString);
    }
    // تحميل البيانات الأخرى...
  }
  void updateMilkAmount(double amount) {
    milkAmount.value = amount;
  }

  void updateMilkAmountwithvalue(double amount) {
    milkAmount.value = amount + milkAmount.value;
  }

  void setTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> saveSession() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value);  // Format date as '2024-08-17'
    String formattedTime = selectedTime.value.format(Get.context!);  // Format time as '14:30'
    await dbHelper.insertArtificialSession(milkAmount.value, formattedTime, formattedDate,);
    await loadSessions();
    _calculateMilkConsumptionData();
    _aggregateDataByWeekday();  // Aggregate data by weekday after loading sessions
  }

  Future<void> loadSessions() async {
    sessions.value = await dbHelper.getArtificialSessions();
    _aggregateDataByWeekday();  // Ensure this is called whenever sessions are loaded
  }

  void _aggregateDataByWeekday() {
    weeklyData.value = List<double>.filled(7, 0.0);
    for (var session in sessions) {
      // Use the 'date' field correctly
      String dateString = session['date'];
      print("before");
      print(dateString);
      try {
        DateTime sessionDate = DateTime.parse(dateString);
        print("after");
        print(dateString);// Parse the date string
        int weekday = sessionDate.weekday;  // Monday is 1, Sunday is 7
        weeklyData[weekday - 1] += session['milkAmount'];
      } catch (e) {
        print("Error parsing date: $dateString");
      }
    }
  }
}
