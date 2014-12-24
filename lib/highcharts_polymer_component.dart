import 'package:polymer/polymer.dart';
import 'package:highcharts_options/chart_options.dart' as hc;
import 'package:polymer_highcharts/highcharts_series.dart';
import 'dart:html';
import 'dart:js';

@CustomTag('highcharts-polymer')
class HighchartsPolymerComponent extends PolymerElement {
  
  @published hc.HighChart chartOptions = new hc.HighChart();
  
  @published String chartTitle;
  @published String subtitle;
  @published bool creditsEnabled;
  @published String type;
  @published String borderColor;
  @published int borderWidth;
  @published int borderRadius;
  @published String backgroundColor;
  @published Map plotOptions;
  
  DivElement mainDiv;
  bool _domReady = false;
  bool _propertiesDirty = false;
  bool _seriesDirty = false;
  bool _chartCreated = false;
    
  Map<String, hc.Series> _seriesPositionDictionary = new Map<String, hc.Series> ();  
  
  List<Map> _pendingSeries = new List<Map> ();
  hc.XAxis _xAxis;
  hc.YAxis _yAxis;
  
  factory HighchartsPolymerComponent() => new Element.tag('highcharts-polymer');
  HighchartsPolymerComponent.created () : super.created ();
  
  void titleChanged (String oldValue) => _invalidateChartOptions();
  void subtitleChanged (String oldValue) => _invalidateChartOptions();
  void creditsEnabledChanged (bool oldValue) => _invalidateChartOptions();
  void typeChanged (String oldValue) => _invalidateChartOptions();
  void borderColorChanged (String oldValue) => _invalidateChartOptions();
  void borderWidthChanged (int oldValue) => _invalidateChartOptions();
  void borderRadiusChanged (int oldValue) => _invalidateChartOptions();
  void plotOptionsChanged (int oldValue) => _invalidateChartOptions();
  
  bool _chartOptionsDirty = false;
  
  void _invalidateChartOptions () {
    _chartOptionsDirty = true;
    _invalidateProperties();
  }
  
  void _commitChartOptions () {
    if (chartOptions != null) {
      if (title != null) {
        chartOptions.title = (new hc.Title ()..text = chartTitle);
      } 
      if (subtitle != null) {
        chartOptions.subtitle = (new hc.Subtitle ()..text = subtitle);
      } 
      if (creditsEnabled != null) {
        chartOptions.credits = (new hc.Credits()..enabled = creditsEnabled);
      }
      if (chartOptions.chart == null) {
        chartOptions.chart = new hc.Chart();
      }
      if (type != null) {
        chartOptions.chart.type = type;
      }
      if (borderColor != null) {
        chartOptions.chart.borderColor = borderColor;
      }
      if (borderWidth != null) {
        chartOptions.chart.borderWidth = borderWidth;
      }
      if (borderRadius != null) {
        chartOptions.chart.borderRadius = borderRadius;
      }
      if (plotOptions != null) {
        if (chartOptions.plotOptions == null) {
          chartOptions.plotOptions = new hc.PlotOptions();
        }
        chartOptions.plotOptions.moreOptions = plotOptions;
      }
      _chartOptionsDirty = false;
    }
    
  }
  
  @override 
  void attached () {
    mainDiv = $['hcDiv'] as DivElement;
    _domReady = true;
    _chartOptionsDirty = true;
    _invalidateProperties ();
  }
  
  List<HighchartsSeries> _findSeriesInDOM () {
    List<HighchartsSeries> out = new List<HighchartsSeries> ();
    List<Element> elements = this.querySelectorAll('highcharts-series');
    elements.forEach((Element e) {
      out.add(e as HighchartsSeries);
    });
    return out;
  }
  
  void notifyNewSeries () {
    _seriesDirty = true;
    _invalidateProperties();
  }
  
  void _commitSeries () {
    if (chartOptions != null) {
      if (chartOptions.series == null) {
        chartOptions.series = new List<hc.Series> ();
      }
      chartOptions.series.clear();
      List<HighchartsSeries> seriesInDOM = _findSeriesInDOM ();
      seriesInDOM.forEach((HighchartsSeries highchartsSeries) {
        chartOptions.series.add(highchartsSeries.getSeries());
      });
    }
  }
  
  void set xAxis (hc.XAxis xAxis) {
    if (chartOptions != null) {
      chartOptions.xAxis = xAxis;
    }
    else {
      _xAxis = xAxis;
      _invalidateProperties ();
    }
  }
  
  void set yAxis (hc.YAxis yAxis) {
      if (chartOptions != null) {
        chartOptions.yAxis = yAxis;
      }
      else {
        _yAxis = yAxis;
        _invalidateProperties ();
      }
    }
  
  void chartOptionsChanged (hc.HighChart oldChartOptions) {
    _invalidateProperties ();
  }
  
  void _listenToChartOptionsChanges (hc.HighChart chartOptions) {
    chartOptions.changes.listen((records) {
      _invalidateProperties();
    });
  }
  
  void _invalidateProperties () {
    if (!_propertiesDirty) {
      _propertiesDirty = true;
      window.animationFrame.then((_) { _commitProperties(); });
    }
  }
  
  void _commitProperties () {
    if (_domReady && _propertiesDirty && chartOptions != null) {
      if (_seriesDirty) {
        _commitSeries();
        _seriesDirty = false;
      }
      _createChart ();
    }
    _propertiesDirty = false;
  }
  
  void _createChart () {
    if (_chartOptionsDirty)
      _commitChartOptions();
    if (_xAxis != null) {
      chartOptions.xAxis = _xAxis;
    }
    if (_yAxis != null) {
      chartOptions.yAxis = _yAxis;
    }
    _listenToChartOptionsChanges (chartOptions);
    if (chartOptions.chart == null) 
      chartOptions.chart = new hc.Chart ();
    chartOptions.chart.renderTo = mainDiv;
    mainDiv.children.clear();
    context['myChart'] = new JsObject(context['Highcharts']['Chart'], [chartOptions.toJsObject()]);
  }
  
}