class HeightRecord {

  final double height;
  final DateTime date;

  HeightRecord({  required this.height, required this.date});

  Map<String, dynamic> toMap() {
    return {

      'height': height,
      'date': date.toIso8601String(),
    };
  }

  static HeightRecord fromMap(Map<String, dynamic> map) {
    return HeightRecord(

      height: map['height'],
      date: DateTime.parse(map['date']),
    );
  }
}
