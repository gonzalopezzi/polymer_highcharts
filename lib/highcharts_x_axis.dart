library PolymerHighcharts.XAxis;

import 'package:polymer/polymer.dart';
import 'package:polymer_highcharts/highcharts_polymer_component.dart';
import 'package:highcharts_options/chart_options.dart' as hc;
import 'dart:html';

@CustomTag('highcharts-x-axis')
class HighchartsXAxis extends PolymerElement {
  
  factory HighchartsXAxis() => new Element.tag('highcharts-x-axis');
  HighchartsXAxis.created () : super.created ();
  
  HighchartsPolymerComponent highchartsPolymerComponent;
  
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
  @published String axisId;
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
  @published int axisOffset;
  @published bool opposite;
  @published List<Map> plotBands;
  @published List<hc.PlotLines> plotLines;
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
  
  @override 
  void attached () {
    highchartsPolymerComponent = this.parent;
    highchartsPolymerComponent.xAxis = (new hc.XAxis ()
         ..allowDecimals = allowDecimals 
         ..alternateGridColor = alternateGridColor
         ..categories = categories
         ..ceiling = ceiling
         ..dateTimeLabelFormats = dateTimeLabelFormats
         ..endOnTick = endOnTick
         ..events = events
         ..floor = floor
         ..gridLineColor = gridLineColor
         ..gridLineDashStyle = gridLineDashStyle
         ..gridLineWidth = gridLineWidth
         ..gridZIndex = gridZIndex
         ..id = id
         ..labels = labels
         ..color = color
         ..lineWidth = lineWidth
         ..linkedTo = linkedTo
         ..max = max 
         ..maxPadding = maxPadding
         ..min = min
         ..minPadding = minPadding
         ..minRange = minRange
         ..minTickInterval = minTickInterval
         ..minorGridLineColor = minorGridLineColor
         ..minorGridLineDashStyle = minorGridLineDashStyle
         ..minorGridLineWidth = minorGridLineWidth
         ..minorTickColor = minorTickColor
         ..minorTickInterval = minorTickInterval
         ..minorTickLength = minorTickLength
         ..minorTickPosition = minorTickPosition
         ..minorTickWidth = minorTickWidth
         ..offset = axisOffset
         ..opposite = opposite
         ..plotBands = plotBands
         ..plotLines = plotLines
         ..reversed = reversed
         ..showEmpty = showEmpty
         ..showFirstLabel = showFirstLabel
         ..showLastLabel = showLastLabel
         ..startOfWeek = startOfWeek
         ..startOnTick = startOnTick
         ..tickColor = tickColor
         ..tickInterval = tickInterval
         ..tickLength = tickLength
         ..tickPixelInterval = tickPixelInterval
         ..tickPosition = tickPosition
         ..tickPositioner = tickPositioner
         ..tickPositions = tickPositions
         ..tickWidth = tickWidth
         ..tickmarkPlacement = tickmarkPlacement
         ..title = (new hc.AxisTitle ()..text = title)
         ..type = type);
  }
}