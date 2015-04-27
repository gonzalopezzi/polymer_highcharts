import 'package:polymer/polymer.dart';
import 'package:polymer_highcharts/highcharts_polymer_component.dart';

/**
 * A Polymer highcharts-no-series element.
 */
@CustomTag('highcharts-no-series')

class HighchartsNoSeries extends PolymerElement {

  HighchartsPolymerComponent highchartsPolymerComponent;
  
  /// Constructor used to create instance of HighchartsNoSeries.
  HighchartsNoSeries.created() : super.created() {
  }
  
  @override 
  void attached () {
    highchartsPolymerComponent = this.parent;
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
  
}
