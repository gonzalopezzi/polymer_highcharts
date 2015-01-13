library PolymerHighcharts.YAxis;

import 'package:polymer/polymer.dart';
import 'package:polymer_highcharts/highcharts_axis.dart';
import 'dart:html';

@CustomTag('highcharts-y-axis')
class HighchartsYAxis extends HighchartsAxis {
  factory HighchartsYAxis() => new Element.tag('highcharts-y-axis');
  HighchartsYAxis.created () : super.created () {
    super.axis = "y";
  }
}