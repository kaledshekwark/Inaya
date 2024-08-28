import 'package:babycare2/controller/%D9%90ArtificialBreastFeedingcController.dart';
import 'package:babycare2/controller/ChildInfoController.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BreastfeedingChart extends StatelessWidget {
  final ChildInfoController controller = Get.find();
  final ArtificialBreastfeedingController Artificialcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // استخدام البيانات الحقيقية من `Artificialcontroller.milkConsumptionData`
      List<double> milkConsumptionData = Artificialcontroller.milkConsumptionData;

      // التأكد من أن الرسم البياني يستخدم البيانات الصحيحة
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
                        'Milk ml'.tr,
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
                        width: Get.height,
                        height: 800,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceEvenly,
                            maxY: milkConsumptionData.isNotEmpty ? milkConsumptionData.reduce((a, b) => a > b ? a : b) + 10 : 10.0,
                            barTouchData: BarTouchData(enabled: true),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 20,
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
                                    toY: milkConsumptionData[index],
                                    color: Colors.blue,
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
