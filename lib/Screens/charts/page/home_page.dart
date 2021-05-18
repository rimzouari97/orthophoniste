import 'package:flutter/material.dart';
import 'package:orthophoniste/models/todo_param.dart';


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




