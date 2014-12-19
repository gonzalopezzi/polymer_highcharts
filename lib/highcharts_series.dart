import 'package:polymer/polymer.dart';
import 'package:polymer_highcharts/highcharts_polymer_component.dart';
import 'package:highcharts_options/chart_options.dart' as hc;
import 'dart:html';

@CustomTag('highcharts-series')
class HighchartsSeries extends PolymerElement {
  
  @published List numData;
  @published List<hc.Point> data;
  @published int index;
  @published int legendIndex;
  @published String name;
  @published var stack;
  @published String type;
  @published int xAxis;
  @published int yAxis;
  @published int zIndex;
  
  factory HighchartsSeries() => new Element.tag('highcharts-series');
  HighchartsSeries.created () : super.created ();
  
  HighchartsPolymerComponent highchartsPolymerComponent;
  
  @override 
  void attached () {
    highchartsPolymerComponent = this.parent;
    highchartsPolymerComponent.addSeries(new hc.Series()
                                            ..numData = numData 
                                            ..data = data
                                            ..index = index
                                            ..legendIndex = legendIndex
                                            ..name = name
                                            ..stack = stack
                                            ..type = type
                                            ..xAxis = xAxis
                                            ..yAxis = yAxis
                                            ..zIndex = zIndex);
  }
}