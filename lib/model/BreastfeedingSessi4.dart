class BreastfeedingSession {
  final DateTime startTime;
  final Duration duration;
  final bool isLeftBreast;
  final DateTime date; // Add this field

  BreastfeedingSession({
    required this.startTime,
    required this.duration,
    required this.isLeftBreast,
    required this.date, // Add this field
  });

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.toIso8601String(),
      'duration': duration.inSeconds,
      'isLeftBreast': isLeftBreast ? 1 : 0,
      'date': date.toIso8601String(), // Add this field
    };
  }

  factory BreastfeedingSession.fromMap(Map<String, dynamic> map) {
    return BreastfeedingSession(
      startTime: DateTime.parse(map['startTime']),
      duration: Duration(seconds: map['duration']),
      isLeftBreast: map['isLeftBreast'] == 1,
      date: DateTime.parse(map['date']), // Add this field
    );
  }
}
