import 'package:flutter/material.dart';


import 'line_chart_page.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(

        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 400, 8, 30),
          child: PageView(
            children: [
              LineChartPage(),
            ],
          ),
        ),
      );
}


