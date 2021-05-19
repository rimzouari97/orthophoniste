import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get_it/get_it.dart';
import 'package:orthophoniste/Screens/charts/widget/line_titles.dart';
import 'package:orthophoniste/models/done.dart';
import 'package:orthophoniste/models/todo_param.dart';
import 'package:orthophoniste/services/done_service.dart';

class LineChartWidget extends StatelessWidget {

  ToDoParam _toDoParam;

  LineChartWidget(this._toDoParam);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("State of user"),),
      body: Center(child: Column(
        children: [
         Card(
            margin: EdgeInsets.all(20),
           borderOnForeground: true,

           child: Column(
             children: [
               Text("Name patient  :"+_toDoParam.id,style: TextStyle(color: Colors.blueAccent,  ),),
               Text(""),
               Text("Name Exercice :"+_toDoParam.idOrtho,style: TextStyle(color: Colors.blueAccent,  ),)
             ],
           ),

         ),
          Text(""),
          Text(""),
          Text(""),
          Text(""),
          Text(""),
          Text(""),
          Text(""),
          MyLineChart(_toDoParam)
        ],
      )
      ),
    );
  }
}

class MyLineChart extends StatefulWidget {
  ToDoParam _toDoParam;

  MyLineChart(this._toDoParam);

  @override
  _MyLineChartState createState() => _MyLineChartState();
  String _name;
  String _id;

}

class _MyLineChartState extends State<MyLineChart> {
  DoneService get service => GetIt.I<DoneService>();


  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  Future<List<Done>> fetchData() =>
      Future.delayed(Duration(microseconds: 3000), () async {
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        //     widget._id = await preferences.getString('idUser');
        return  await service.getState(widget._toDoParam);

        // return list;

      });


  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<FlSpot> spotsL = [
            FlSpot(0, 0)
          ];
          var len;
          try {
            len = snapshot.data.length.toDouble();
            print(snapshot.data.length);
            List<Done> listdone = snapshot.data;
            //int i = 0;
            print(listdone.first.score);
            // spotsL= [];
            for (int i = 0; i <= listdone.length; i++) {
              Done done = listdone[i];
              FlSpot flSpot = FlSpot(
                  i.toDouble() + 1, double.parse(done.score) / 10);
              //  print(i);
              spotsL.add(flSpot);
            }
          } catch (e) {
            print(e);
          }


          return LineChart(
            LineChartData(
              minX: 0,
              maxX: len + 1,
              minY: 0,
              maxY: 10,
              titlesData: LineTitles.getTitleData(),
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: const Color(0xff37434d),
                    strokeWidth: 1,
                  );
                },
                drawVerticalLine: true,
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: const Color(0xff37434d),
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: const Color(0xff37434d), width: 1),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spotsL,
                  isCurved: true,
                  colors: gradientColors,
                  barWidth: 5,
                  // dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        }else{
          return Center(
            child:

            SizedBox(
              child: CircularProgressIndicator(backgroundColor:  Colors.white,),
              width: 60,
              height: 60,
            ),

          );
        }
      }
  );
}