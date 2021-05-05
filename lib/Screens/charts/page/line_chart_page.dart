
import 'package:flutter/material.dart';
import 'package:orthophoniste/Screens/charts/widget/line_chart_widget.dart';

class LineChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: const Color(0xff020227),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 20, 0),
          child: LineChartWidget(),
        ),
      );
}
