import 'package:polymer/polymer.dart';
import 'package:highcharts_options/chart_options.dart' as hc;
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
  
  DivElement mainDiv;
  bool _domReady = false;
  bool _propertiesDirty = false;
    
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
  
  bool _chartOptionsDirty = false;
  
  void _invalidateChartOptions () {
    _chartOptionsDirty = true;
    _invalidateProperties();
  }
  
  void _commitChartOptions () {
    if (chartOptions != null) {
      if (title != null) {
        chartOptions.title = (new hc.Title ()..text = title);
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
      _chartOptionsDirty = false;
    }
    
  }
  
  @override 
  void attached () {
    mainDiv = new DivElement ();
    this.shadowRoot.children.add(mainDiv);
    _domReady = true;
    _chartOptionsDirty = true;
    _invalidateProperties ();
  }
  
  void addSeries (String uid, hc.Series series) {
    if (_seriesPositionDictionary[uid] != null) {
      chartOptions.series.remove(_seriesPositionDictionary[uid]);
    }
    if (chartOptions != null) {
      if (chartOptions.series == null) {
        chartOptions.series = new List<hc.Series> ();
      }
      chartOptions.series.add(series);
      _seriesPositionDictionary [uid] = series;
    }
    else {
      _pendingSeries.add({uid:uid, series: series});
      _invalidateProperties();
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
      _createChart ();
    }
    _propertiesDirty = false;
  }
  
  void _addPendingSeries () {
    if (_pendingSeries != null) {
      _pendingSeries.forEach((Map map) {
        this.addSeries(map["uid"], map["series"]);
      });
    }
  }
  
  void _createChart () {
    /* This is the old way. This requires JQuery. It has been replaced by the standalone-framework (https://github.com/highslide-software/highcharts.com/blob/master/js/adapters/standalone-framework.src.js)
    context.callMethod(r'$', ["#chart-container-$_chartID"]).callMethod('highcharts', [new JsObject.jsify(_chartOptions.toMap())]);
    */
    _addPendingSeries ();
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
    context['myChart'] = new JsObject(context['Highcharts']['Chart'], [chartOptions.toJsObject()]);
  }
  
}