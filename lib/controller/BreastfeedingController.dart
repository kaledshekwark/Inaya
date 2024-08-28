import 'package:babycare2/model/BreastfeedingSessi4.dart';
import 'package:babycare2/model/DatabaseHelper.dart';
import 'package:get/get.dart';
import 'dart:async';




import 'package:get/get.dart';
import 'dart:async';

class BreastfeedingController extends GetxController {
  var leftBreastSessions = <BreastfeedingSession>[].obs;
  var rightBreastSessions = <BreastfeedingSession>[].obs;
  var  timeConsumptionDataLeft = <Duration>[].obs;
  var  timeConsumptionDataRight = <Duration>[].obs;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Timer? _timer;
  DateTime? _startTime;
  bool? _isLeftBreast;
  var selectedDate =  DateTime.now().obs;  // Observable for selected time

  // Rx variables to store elapsed time for UI updates
  Rx<Duration> leftElapsedTime = Duration.zero.obs;
  Rx<Duration> rightElapsedTime = Duration.zero.obs;
  @override
  void onInit() {
    super.onInit();
    _startUpdateTimer();
    _loadSessionsFromDatabase();
    _loadSessionsFromDatabase();
    _calculateTimeConsumptionData();
  }
  void _calculateTimeConsumptionData() {
    final today = DateTime.now();
    final startDate = leftBreastSessions.isNotEmpty
        ? (leftBreastSessions.first.date.isBefore(rightBreastSessions.first.date)
        ? leftBreastSessions.first.date
        : rightBreastSessions.first.date)
        : today;

    int ageInDays = today.difference(startDate).inDays;

    // Initialize lists with zero durations for each day
    timeConsumptionDataLeft.value = List.generate(ageInDays + 1, (_) => Duration.zero);
    timeConsumptionDataRight.value = List.generate(ageInDays + 1, (_) => Duration.zero);

    // Distribute data across days based on session dates
    for (var session in leftBreastSessions) {
      int dayIndex = session.date.difference(startDate).inDays;
      if (dayIndex >= 0 && dayIndex < timeConsumptionDataLeft.length) {
        timeConsumptionDataLeft[dayIndex] += session.duration;
      }
    }

    for (var session in rightBreastSessions) {
      int dayIndex = session.date.difference(startDate).inDays;
      if (dayIndex >= 0 && dayIndex < timeConsumptionDataRight.length) {
        timeConsumptionDataRight[dayIndex] += session.duration;
      }
    }
  }
  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  // Start the timer for the selected breast (left or right)
  void startTimer(bool isLeftBreast) {
    stopTimer();

    _isLeftBreast = isLeftBreast;
    _startTime = DateTime.now();
    final elapsed = DateTime.now().difference(_startTime!);

    if (isLeftBreast) {
      leftElapsedTime.value = Duration.zero;
    } else {
      rightElapsedTime.value = Duration.zero;
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final elapsed = DateTime.now().difference(_startTime!);
      if (isLeftBreast) {
        leftElapsedTime.value = elapsed;
      } else {
        rightElapsedTime.value = elapsed;
      }
    });
  }
  // Stop the current timer and save the session
  void stopTimer() async {
    if (_timer != null && _startTime != null && _isLeftBreast != null) {
      final duration = DateTime.now().difference(_startTime!);
      final session = BreastfeedingSession(
        startTime: _startTime!,
        duration: duration,
        isLeftBreast: _isLeftBreast!,
        date: selectedDate.value,
      );
      if (_isLeftBreast!) {
        leftBreastSessions.add(session);
      } else {
        rightBreastSessions.add(session);
      }
      await _dbHelper.insertSession(session);
      _timer!.cancel();
      _timer = null;
      _startTime = null;
      _isLeftBreast = null;
    }
    _calculateTimeConsumptionData();

  }
  // Get the total elapsed time for all left breast sessions
  Duration getLeftElapsedTime() {
    return leftBreastSessions.fold(Duration.zero, (sum, session) => sum + session.duration);
  }

  // Get the total elapsed time for all right breast sessions
  Duration getRightElapsedTime() {
    return rightBreastSessions.fold(Duration.zero, (sum, session) => sum + session.duration);
  }

  // Get the total elapsed time for both breasts
  Duration getTotalElapsedTime() {
    return getLeftElapsedTime() + getRightElapsedTime();
  }
  Timer? _updateTimer;


  @override
  void onClose() {
    _updateTimer?.cancel();
    super.onClose();
  }
  Future<void> _loadSessionsFromDatabase() async {
    final leftSessions = await _dbHelper.getSessions(isLeftBreast: true);
    final rightSessions = await _dbHelper.getSessions(isLeftBreast: false);
    leftBreastSessions.addAll(leftSessions);
    rightBreastSessions.addAll(rightSessions);
     _calculateTimeConsumptionData();
  }

  void _startUpdateTimer() {
    // Update every minute
    _updateTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      // Trigger a manual update to refresh the UI
      leftBreastSessions.refresh();
      rightBreastSessions.refresh();
      _calculateTimeConsumptionData();
    });
  }

}
