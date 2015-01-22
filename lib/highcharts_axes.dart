library highcharts_axes;

import 'package:polymer/polymer.dart';
import 'package:polymer_highcharts/highcharts_axis.dart';
import 'package:polymer_highcharts/highcharts_polymer_component.dart';
import 'package:highcharts_options/chart_options.dart' as hc;
import 'dart:html';

@CustomTag('highcharts-axes')
class HighchartsAxes extends PolymerElement {

  bool propertiesDirty = false;
  
  List<hc.XAxis> _commitedXAxes;
  List<hc.YAxis> _commitedYAxes;
  
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
  
  bool _axesDirty (List<hc.XAxis> xAxes, List<hc.YAxis> yAxes) {
    bool equalY = true;
    bool equalX = true;
    
    equalY = (yAxes == null && _commitedYAxes == null) || (yAxes != null && _commitedYAxes != null); 
    equalX = (xAxes == null && _commitedXAxes == null) || (xAxes != null && _commitedXAxes != null);
    
    if (_commitedYAxes != null) {
      equalY = equalY || yAxes.length == _commitedYAxes.length;
      yAxes.forEach((hc.YAxis axis) {
        equalY = equalY && _containsAxis (_commitedYAxes, axis);
      });
    }
    if (equalY && _commitedXAxes != null) {
      equalX = equalX || xAxes.length == _commitedXAxes.length;
      xAxes.forEach ((hc.XAxis axis) {
        equalX = equalX && _containsAxis (_commitedXAxes, axis); 
      });
    }
    return !equalX || !equalY;
  }
  
  bool _containsAxis (List<hc.XAxis> commitedAxes, hc.XAxis searchAxis) {
    int i = 0; 
    bool found = false;
    if (commitedAxes != null) {
      while ((!found) && (i < commitedAxes.length)) {
        hc.XAxis axis = commitedAxes[i];
        found = axis.id == searchAxis.id;  /* TODO: Hacer esto con equals */
        i++;
      }
    }
    return found;
  }
  
  void _commitProperties () {
    propertiesDirty = false;
    List<hc.XAxis> xAxes = new List<hc.XAxis>();
    List<hc.YAxis> yAxes = new List<hc.YAxis>();
    List<HighchartsAxis> found = _findAxes();
    xAxes.addAll(found.where((axis) => axis.axis == "x").map((axis) => axis.getAxis()));
    yAxes.addAll(found.where((axis) => axis.axis == "y").map((axis) => axis.getAxis()));
    if (_axesDirty(xAxes, yAxes)) {
      (parent as HighchartsPolymerComponent).xAxes = xAxes;
      (parent as HighchartsPolymerComponent).yAxes = yAxes;
      _commitedXAxes = xAxes;
      _commitedYAxes = yAxes;
    }
  }

}
