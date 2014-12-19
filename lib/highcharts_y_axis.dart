library PolymerHighcharts.YAxis;

import 'package:polymer/polymer.dart';
import 'package:polymer_highcharts/highcharts_polymer_component.dart';
import 'package:highcharts_options/chart_options.dart' as hc;
import 'package:polymer_highcharts/highcharts_x_axis.dart';
import 'dart:html';

@CustomTag('highcharts-y-axis')
class HighchartsYAxis extends HighchartsXAxis {
  
  factory HighchartsYAxis() => new Element.tag('highcharts-y-axis');
  HighchartsYAxis.created () : super.created ();
  
  HighchartsPolymerComponent highchartsPolymerComponent;
  
  @published String maxColor;
  @published String minColor;
  @published Map stackLabels;
  
  @override 
  void attached () {
    highchartsPolymerComponent = this.parent;
    highchartsPolymerComponent.yAxis = (new hc.YAxis ()
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
         ..title = (new hc.AxisTitle ()..text = axisTitle)
         ..type = type
         ..maxColor = maxColor
         ..minColor = minColor
         ..stackLabels = stackLabels);
        
  }
}