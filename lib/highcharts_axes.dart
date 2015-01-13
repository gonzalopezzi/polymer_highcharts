library highcharts_axes;

import 'package:polymer/polymer.dart';
import 'package:polymer_highcharts/highcharts_axis.dart';
import 'package:polymer_highcharts/highcharts_polymer_component.dart';
import 'package:highcharts_options/chart_options.dart' as hc;
import 'dart:html';

@CustomTag('highcharts-axes')
class HighchartsAxes extends PolymerElement {

  bool propertiesDirty = false;
  
  /// Constructor used to create instance of HighchartsAxes.
  HighchartsAxes.created() : super.created() {
  }

  attached() {
    super.attached();
  }

  detached() {
    super.detached();
  }
  
  ready () {
    
  }
  
  void _invalidateProperties () {
    propertiesDirty = true;
    window.animationFrame.then((_) => _commitProperties());
  }

  void notifyAxis () {
    _invalidateProperties();
  }
  
  List<HighchartsAxis> _findAxes () {
    List<HighchartsAxis> found = new List<HighchartsAxis> ();
    found.addAll(this.querySelectorAll("highcharts-axis"));
    found.addAll(this.querySelectorAll("highcharts-x-axis"));
    found.addAll(this.querySelectorAll("highcharts-y-axis"));
    return found;
  }
  
  void _commitProperties () {
    propertiesDirty = false;
    List<hc.XAxis> xAxes = new List<hc.XAxis>();
    List<hc.YAxis> yAxes = new List<hc.YAxis>(); 
    List<HighchartsAxis> found = _findAxes();
    xAxes.addAll(found.where((axis) => axis.axis == "x").map((axis) => axis.getAxis()));
    yAxes.addAll(found.where((axis) => axis.axis == "y").map((axis) => axis.getAxis()));
    (parent as HighchartsPolymerComponent).xAxes = xAxes;
    (parent as HighchartsPolymerComponent).yAxes = yAxes;
  }

}
