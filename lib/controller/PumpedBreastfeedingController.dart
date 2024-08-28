import 'package:babycare2/model/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PumpedBreastfeedingController extends GetxController {
  var milkAmount = 0.0.obs; // Observable for milk amount
  var selectedTime = TimeOfDay.now().obs; // Observable for selected time
  var breastSide = 'right'.obs; // Observable for selected breast side
  var selectedDate =  DateTime.now().obs;  // Observable for selected time

  var sessions = <Map<String, dynamic>>[].obs; // Observable list for sessions
  var weeklyData = List<double>.filled(7, 0.0).obs;
  var milkConsumptionData = <List<double>>[].obs;
  var birthdate = DateTime.now().obs;

  final dbHelper = DatabaseHelper();

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
    milkConsumptionData.value = List.generate(ageInDays + 1, (_) => [0.0, 0.0]);

    // توزيع البيانات على الأيام بناءً على التواريخ المسجلة في الجلسات
    for (var session in sessions) {
      String dateString = session['date'];
      try {
        DateTime sessionDate = DateTime.parse(dateString);
        int dayIndex = sessionDate.difference(birthdate.value).inDays;

        if (dayIndex >= 0 && dayIndex < milkConsumptionData.length) {
          if (session['breastSide'] == 'right') {
            milkConsumptionData[dayIndex][0] += session['milkAmount']; // الأيمن
          } else {
            milkConsumptionData[dayIndex][1] += session['milkAmount']; // الأيسر
          }
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

  void updateMilkAmountWithValue(double amount) {
  if(    milkAmount.value<140)
    milkAmount.value += amount;

  }

  void setTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  void setBreastSide(String side) {
    breastSide.value = side;
  }
  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  Future<void> saveSession() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value);  // Format date as '2024-08-17'

    String formattedTime = '${selectedTime.value.hour}:${selectedTime.value.minute}';
    await dbHelper.insertPumpedSession(milkAmount.value, formattedTime,formattedDate, breastSide.value);
    await loadSessions();
    _calculateMilkConsumptionData();
  }

  Future<void> loadSessions() async {
    sessions.value = await dbHelper.getPumpedSessions();
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
