import 'package:polymer/polymer.dart';
import 'package:polymer_highcharts/highcharts_polymer_component.dart';
import 'package:highcharts_options/chart_options.dart' as hc;
import 'package:uuid/uuid.dart';
import 'dart:html';

@CustomTag('highcharts-series')
class HighchartsSeries extends PolymerElement {
  
  @published List numData;
  List<hc.Point> _data;
  
  @published 
  List<hc.Point> get data => _data;
  void set data (d) {
    _data = d;
    _addSeries ();
  }
  
  @published int index;
  @published int legendIndex;
  @published String name;
  @published var stack;
  @published String type;
  @published int xAxis;
  @published int yAxis;
  @published int zIndex;
  
  String _uid = new Uuid().v1();
  
  factory HighchartsSeries() => new Element.tag('highcharts-series');
  HighchartsSeries.created () : super.created ();
  
  HighchartsPolymerComponent highchartsPolymerComponent;
  
  void dataChanged (List<hc.Point> oldValue) {
    _addSeries ();
  }
  
  void numDataChanged (List oldValue) {
    _addSeries ();
  }
  
  @override 
  void attached () {
    highchartsPolymerComponent = this.parent;
    _addSeries ();
    this.changes.listen((_) {
      _addSeries();
    });
  }
  
  void _addSeries () {
    if (highchartsPolymerComponent != null) {
      highchartsPolymerComponent.addSeries(_uid, new hc.Series()
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
  
}