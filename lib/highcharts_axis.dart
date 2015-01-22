import 'package:polymer/polymer.dart';
import 'package:polymer_highcharts/highcharts_axes.dart';
import 'package:polymer_highcharts/highcharts_polymer_component.dart';
import 'package:highcharts_options/chart_options.dart' as hc;
import 'dart:html';

/**
 * A Polymer highcharts-axis element.
 */
@CustomTag('highcharts-axis')

class HighchartsAxis extends PolymerElement {
  
  /** 
   * Whether this is an "x" axis or a "y" axis. Values accepted: "x" or "y" 
   */
  @published String axis;
  
  @published bool allowDecimals;
  @published String alternateGridColor;
  @published List<String> categories;
  @published num ceiling;
  @published Map dateTimeLabelFormats;
  @published bool endOnTick;
  @published Map events;
  @published num floor;
  @published String gridLineColor;
  @published String gridLineDashStyle;
  @published num gridLineWidth;
  @published num gridZIndex;
  @published Map labels;
  @published String color;
  @published num lineWidth;
  @published num linkedTo;
  @published num max;
  @published num maxPadding;
  @published num min;
  @published num minPadding;
  @published num minRange;
  @published num minTickInterval;
  @published String minorGridLineColor;
  @published String minorGridLineDashStyle;
  @published num minorGridLineWidth;
  @published String minorTickColor;
  @published num minorTickInterval;
  @published num minorTickLength;
  @published String minorTickPosition;
  @published num minorTickWidth;
  @published int axis_offset;
  @published bool opposite;
  @published List<Map> plotBands;
  /* @published String plotLines;  TODO:UNSUPPORTED */
  @published bool reversed;
  @published bool showEmpty;
  @published bool showFirstLabel;
  @published bool showLastLabel;
  @published int startOfWeek;
  @published bool startOnTick;
  @published String tickColor;
  @published num tickInterval;
  @published int tickLength;
  @published int tickPixelInterval;
  @published String tickPosition;
  @published Function tickPositioner;
  @published List<int> tickPositions;
  @published int tickWidth;
  @published String tickmarkPlacement;
  @published String axisTitle;
  @published String type;  
  
  /* Only for "y" axes */
  @published String maxColor;
  @published String minColor;
  @published Map stackLabels;
  
  @published Map moreOptions;
  
  /// Constructor used to create instance of HighchartsAxis.
  HighchartsAxis.created() : super.created() {
  }

  factory HighchartsAxis () => new Element.tag('highcharts-axis');
  
  hc.XAxis getAxis () {
    hc.XAxis axis;
    if (this.axis == "x") {
      axis = new hc.XAxis ();
    }
    else if (this.axis == "y") {
      axis = new hc.YAxis ();
    }
    else {
      throw new ArgumentError("HighchartsAxis requires an attribute axis with value 'x' or 'y'");
    }
    
    axis.allowDecimals = this.allowDecimals;
    axis.alternateGridColor = this.alternateGridColor;
    axis.categories = this.categories;
    axis.ceiling = this.ceiling;
    axis.dateTimeLabelFormats = this.dateTimeLabelFormats;
    axis.endOnTick = this.endOnTick;
    axis.events = this.events;
    axis.floor = this.floor;
    axis.gridLineColor = this.gridLineColor;
    axis.gridLineDashStyle = this.gridLineDashStyle;
    axis.gridLineWidth = this.gridLineWidth;
    axis.gridZIndex = this.gridZIndex;
    axis.id = this.id;
    axis.labels = this.labels;
    axis.color = this.color;
    axis.lineWidth = this.lineWidth;
    axis.linkedTo = this.linkedTo;
    axis.max = this.max;
    axis.maxPadding = this.maxPadding;
    axis.min = this.min;
    axis.minPadding = this.minPadding;
    axis.minRange = this.minRange;
    axis.minTickInterval = this.minTickInterval;
    axis.minorGridLineColor = this.minorGridLineColor;
    axis.minorGridLineDashStyle = this.minorGridLineDashStyle;
    axis.minorGridLineWidth = this.minorGridLineWidth;
    axis.minorTickColor = this.minorTickColor;
    axis.minorTickInterval = this.minorTickInterval;
    axis.minorTickLength = this.minorTickLength;
    axis.minorTickPosition = this.minorTickPosition;
    axis.minorTickWidth = this.minorTickWidth;
    axis.offset = this.axis_offset;
    axis.opposite = this.opposite;
    axis.plotBands = this.plotBands;
    /*axis.plotLines = this.plotLines; TODO: UNSUPPORTED */
    axis.reversed = this.reversed;
    axis.showEmpty = this.showEmpty;
    axis.showFirstLabel = this.showFirstLabel;
    axis.showLastLabel = this.showLastLabel;
    axis.startOfWeek = this.startOfWeek;
    axis.startOnTick = this.startOnTick;
    axis.tickColor = this.tickColor;
    axis.tickInterval = this.tickInterval;
    axis.tickLength = this.tickLength;
    axis.tickPixelInterval = this.tickPixelInterval;
    axis.tickPosition = this.tickPosition;
    axis.tickPositioner = this.tickPositioner;
    axis.tickPositions = this.tickPositions;
    axis.tickWidth = this.tickWidth;
    axis.tickmarkPlacement = this.tickmarkPlacement;
    axis.title = (new hc.AxisTitle())..text = this.axisTitle;
    axis.type = this.type;
    
    if (this.axis == "y") {
      (axis as hc.YAxis).maxColor = this.maxColor;
      (axis as hc.YAxis).minColor = this.minColor;
      (axis as hc.YAxis).stackLabels = this.stackLabels;
    }
    axis.moreOptions = this.moreOptions;
    return axis;
  }
  
  attached() {
    if (parent is HighchartsAxes) {
      (parent as HighchartsAxes).notifyAxis();
    }
    else if (parent is HighchartsPolymerComponent) {
      if (this.axis == "x") {
        (parent as HighchartsPolymerComponent).xAxis = this.getAxis();
      }
      else {
        (parent as HighchartsPolymerComponent).yAxis = this.getAxis();
      }
    }
  }
}
