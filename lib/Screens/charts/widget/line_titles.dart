
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          rotateAngle: 20,
          reservedSize: 35,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1 fois';
              case 5:
                return '5 fois';
              case 10:
                return '10 fois';
              case 15:
                return '15 fois';
              case 20:
                return '20 fois';

            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10pts';
              case 3:
                return '30pts';
              case 5:
                return '50pts';
              case 7:
                return '70pts';
              case 9:
                return '90pts';
            }
            return '';
          },
          reservedSize: 35,
          margin: 12,
        ),
      );
}
