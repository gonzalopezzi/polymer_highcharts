library PolymerHighcharts.XAxis;

import 'package:polymer/polymer.dart';
import 'package:polymer_highcharts/highcharts_axis.dart';
import 'dart:html';

@CustomTag('highcharts-x-axis')
class HighchartsXAxis extends HighchartsAxis {
  
  factory HighchartsXAxis() => new Element.tag('highcharts-x-axis');
  HighchartsXAxis.created () : super.created () {
    super.axis = "x";
  }
}