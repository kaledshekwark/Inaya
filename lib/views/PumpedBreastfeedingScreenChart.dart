import 'package:babycare2/controller/PumpedBreastfeedingController.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PumpedBreastfeedingScreenChart extends StatelessWidget {
  final PumpedBreastfeedingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // هنا يجب استخدام `.value` للحصول على القيمة الفعلية من `RxList`
      List<List<double>> milkConsumptionData = controller.milkConsumptionData.value;

      return Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 3, // لتدوير النص عموديًا
                      child: Text(
                        'Milk ml: Right breast in red, left breast in blue'.tr,
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
                            maxY: milkConsumptionData.isNotEmpty
                                ? milkConsumptionData.expand((i) => i).reduce((a, b) => a > b ? a : b) + 10
                                : 10.0,
                            barTouchData: BarTouchData(
                              enabled: true,
                              touchTooltipData: BarTouchTooltipData(
                                tooltipPadding: const EdgeInsets.all(8),
                                tooltipMargin: 8,
                                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                  return BarTooltipItem(
                                    'اليوم ${group.x + 1}\n',
                                    TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '${rod.toY.toStringAsFixed(1)} مل\n',
                                        style: TextStyle(
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: controller.sessions[groupIndex]['breastSide'] == 'right'
                                            ? 'الثدي الأيمن'
                                            : 'الثدي الأيسر',
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
                                  interval: 10,
                                  reservedSize: 40,
                                  getTitlesWidget: (double value, TitleMeta meta) {
                                    return Text(value.toInt().toString());
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
                            barGroups: List.generate(milkConsumptionData.length, (index) {
                              return BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    toY: milkConsumptionData[index][0],  // الأيمن
                                    color: Colors.blue,
                                    width: 10,
                                  ),
                                  BarChartRodData(
                                    toY: milkConsumptionData[index][1],  // الأيسر
                                    color: Colors.red,
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
}
