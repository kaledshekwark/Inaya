import 'package:babycare2/controller/BreastfeedingController.dart';
 import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NaturalBreastfeedingScreenChart extends StatelessWidget {
  final BreastfeedingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Convert List<Duration> to List<List<double>> for chart
      List<List<double>> timeConsumptionData = _convertDurationToDouble(
          controller.timeConsumptionDataLeft.value,
          controller.timeConsumptionDataRight.value
      );
      return Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 3, // Rotate text vertically
                      child: Text(
                        'Time (minutes): Right breast in red, left breast in blue'.tr,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        width: 800,
                        height: Get.height * 0.8,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceEvenly,
                            maxY: timeConsumptionData.isNotEmpty
                                ? timeConsumptionData.expand((i) => i).reduce((a, b) => a > b ? a : b) +10.0
                                : 10.0,
                            barTouchData: BarTouchData(
                              enabled: true,
                              touchTooltipData: BarTouchTooltipData(
                                tooltipPadding: const EdgeInsets.all(8),
                                tooltipMargin: 8,
                                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                  return BarTooltipItem(
                                    'Day ${group.x + 1}\n',
                                    TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '${rod.toY.toStringAsFixed(1)} min\n',
                                        style: TextStyle(
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: groupIndex % 2 == 0 ? 'Right Breast' : 'Left Breast',
                                        style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 0.5,
                                  reservedSize: 50,
                                  getTitlesWidget: (double value, TitleMeta meta) {
                                    if (value % 1 == 0 || value % 0.1 == 0) { // Show labels for 0.1 increments
                                      return Text(value.toStringAsFixed(1));
                                                                  }
                                     return Text(value.toStringAsFixed(1)); //
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (double value, TitleMeta meta) {
                                    return Text((value + 1).toInt().toString());
                                  },
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            barGroups: List.generate(timeConsumptionData.length, (index) {
                              return BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    toY: timeConsumptionData[index][0], // Right
                                    color:Colors.red ,
                                    width: 10,
                                  ),
                                  BarChartRodData(
                                    toY: timeConsumptionData[index][1], // Left
                                    color:Colors.blue ,
                                    width: 10,
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Age in days'.tr,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
    });
  }

  // Convert List<Duration> to List<List<double>>
  List<List<double>> _convertDurationToDouble(List<Duration> leftDurations, List<Duration> rightDurations) {
    int length = leftDurations.length > rightDurations.length
        ? leftDurations.length
        : rightDurations.length;

    return List.generate(
      length,
          (index) => [
        rightDurations[index].inMinutes.toDouble(), // Right breast
        leftDurations[index].inMinutes.toDouble()   // Left breast
      ],
    );
  }  }