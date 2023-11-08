import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:test/style/theme.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget(
      {super.key,
      required this.points,
      required this.step,
      required this.limitCount});

  //getting values
  final int limitCount;
  final List<FlSpot> points;
  final double step;

  //simple line style
  LineChartBarData line() {
    return LineChartBarData(
      color: Styles.surfaceColor,
      spots: points,
      dotData: const FlDotData(
        show: false,
      ),
      barWidth: 1,
      isCurved: false,
    );
  }

  //looking for lowest value to center chart
  double? minYvalue() {
    List<double> listOfY = [];
    for (FlSpot element in points) {
      listOfY.add(element.y);
    }
    listOfY.sort();
    //debugPrint("MINY: ${listOfY.first.toString()}");
    return listOfY.first;
  }

  //looking for highest value to center chart
  double? maxYvalue() {
    List<double> listOfY = [];
    for (FlSpot element in points) {
      listOfY.add(element.y);
      //  debugPrint(element.toString());
    }
    listOfY.sort();
    //debugPrint("MAXY: ${listOfY.last.toString()}");
    return listOfY.last;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 5,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0, top: 5),
            child: LineChart(
              LineChartData(
                minY: minYvalue(),
                maxY: maxYvalue(),
                minX: points.first.x,
                maxX: points.last.x,
                lineTouchData: const LineTouchData(enabled: false),
                clipData: const FlClipData.all(),
                gridData: const FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    drawHorizontalLine: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  line(),
                ],
                titlesData: const FlTitlesData(
                  show: false,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
