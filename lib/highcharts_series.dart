import 'package:polymer/polymer.dart';
import 'package:polymer_highcharts/highcharts_polymer_component.dart';
import 'package:highcharts_options/chart_options.dart' as hc;
import 'dart:html';

@CustomTag('highcharts-series')
class HighchartsSeries extends PolymerElement {
  
  @published List numData;
  List<hc.Point> _data;
  
  @published 
  List<hc.Point> get data => _data;
  void set data (d) {
    _data = d;
    _notifyNewSeries ();
  }
  
  @published int index;
  @published int legendIndex;
  @published String name;
  @published var stack;
  @published String type;
  @published int xAxis;
  @published int yAxis;
  @published int zIndex;
  
  bool _isAttached = false;
  
  factory HighchartsSeries() => new Element.tag('highcharts-series');
  HighchartsSeries.created () : super.created ();
  
  HighchartsPolymerComponent highchartsPolymerComponent;
  
  void dataChanged (List<hc.Point> oldValue) {
    if (_isAttached)
      _notifyNewSeries ();
  }
  
  void numDataChanged (List oldValue) {
    if (_isAttached)
      _notifyNewSeries ();
  }
  
  @override 
  void attached () {
    highchartsPolymerComponent = this.parent;
    _isAttached = true;
    _notifyNewSeries ();
    this.changes.listen((_) {
      _notifyNewSeries();
    });
  }
  
  void _notifyNewSeries () {
    if (highchartsPolymerComponent != null) {
      highchartsPolymerComponent.notifyNewSeries();
    }
  }
  
  hc.Series getSeries () {
    return (new hc.Series())
                ..numData = numData 
                ..data = data
                ..index = index
                ..legendIndex = legendIndex
                ..name = name
                ..stack = stack
                ..type = type
                ..xAxis = xAxis
                ..yAxis = yAxis
                ..zIndex = zIndex;
  }
  
}