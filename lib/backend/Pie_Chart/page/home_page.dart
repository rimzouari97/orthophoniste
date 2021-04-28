
import 'package:flutter/material.dart';
import 'package:orthophoniste/backend/Pie_Chart/page/pie_chart_page.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(

        body: Padding(
          padding: const EdgeInsets.all(8),
          child: PageView(
            children: [
              PieChartPage(),
            ],
          ),
        ),
      );
}
