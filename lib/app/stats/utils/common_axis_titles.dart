import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

AxisTitles get noAxisTitles =>
    const AxisTitles(sideTitles: SideTitles(showTitles: false));

TextStyle smallAxisTitleStyle(BuildContext context) =>
    Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 10);
