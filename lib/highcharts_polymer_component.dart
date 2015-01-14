library highcharts_polymer_component;

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
  @published Map plotOptions;
  
  @published bool alignTicks;
  @published bool animation;
  @published String backgroundColor;
  @published String borderColor;
  @published int borderRadius;
  @published int borderWidth;
  @published String className;
  @published String defaultSeriesType;
  /* TODO: @published String events; */
  @published int height;
  @published bool ignoreHiddenSeries;
  @published bool inverted;
  @published List<int> margin;
  @published int marginBottom;
  @published int marginLeft;
  @published int marginRight;
  @published int marginTop;
  @published String pinchType;
  @published String plotBackgroundColor;
  @published String plotBackgroundImage;
  @published String plotBorderColor;
  @published String plotBorderWidth;
  @published bool plotShadow;
  @published bool polar;
  @published bool reflow;
  @published String renderTo; 
  /* TODO: @published String resetZoomButton; */
  @published String selectionMarkerFill;
  @published bool shadow;
  @published bool showAxes;
  @published List<int> spacing;
  @published int spacingBottom;
  @published int spacingLeft;
  @published int spacingRight;
  @published int spacingTop;
  @published Map chartStyle;
  @published String type;
  @published int width; 
  @published String zoomType;
  
  DivElement mainDiv;
  bool _domReady = false;
  bool _propertiesDirty = false;
  bool _seriesDirty = false;
  bool _chartCreated = false;
  
  bool _updateableSeries = false;
    
  Map<String, HighchartsSeries> _seriesDictionary = new Map<String, HighchartsSeries> ();
  List<HighchartsSeries> _previousSeries = new List<HighchartsSeries> ();
  
  List<Map> _pendingSeries = new List<Map> ();
  hc.XAxis _xAxis;
  hc.YAxis _yAxis;
  
  List<hc.XAxis> _xAxes;
  List<hc.YAxis> _yAxes; 
  
  JsObject jsHighchart = null;
  
  factory HighchartsPolymerComponent() => new Element.tag('highcharts-polymer');
  HighchartsPolymerComponent.created () : super.created ();
  
  void titleChanged (String oldValue) => _invalidateChartOptions();
  void subtitleChanged (String oldValue) => _invalidateChartOptions();
  void creditsEnabledChanged (bool oldValue) => _invalidateChartOptions();
  void plotOptionsChanged (int oldValue) => _invalidateChartOptions();
  
  void alignTicksChanged (String oldValue) => _invalidateChartOptions();
  void animationChanged (String oldValue) => _invalidateChartOptions();
  void backgroundColorChanged (String oldValue) => _invalidateChartOptions();
  void borderColorChanged (String oldValue) => _invalidateChartOptions();
  void borderRadiusChanged (String oldValue) => _invalidateChartOptions();
  void borderWidthChanged (String oldValue) => _invalidateChartOptions();
  void classNameChanged (String oldValue) => _invalidateChartOptions();
  void defaultSeriesTypeChanged (String oldValue) => _invalidateChartOptions();
  /* TODO: void eventsChanged (String oldValue) => _invalidateChartOptions();*/
  void heightChanged (String oldValue) => _invalidateChartOptions();
  void ignoreHiddenSeriesChanged (String oldValue) => _invalidateChartOptions();
  void invertedChanged (String oldValue) => _invalidateChartOptions();
  void marginChanged (String oldValue) => _invalidateChartOptions();
  void marginBottomChanged (String oldValue) => _invalidateChartOptions();
  void marginLeftChanged (String oldValue) => _invalidateChartOptions();
  void marginRightChanged (String oldValue) => _invalidateChartOptions();
  void marginTopChanged (String oldValue) => _invalidateChartOptions();
  void pinchTypeChanged (String oldValue) => _invalidateChartOptions();
  void plotBackgroundColorChanged (String oldValue) => _invalidateChartOptions();
  void plotBackgroundImageChanged (String oldValue) => _invalidateChartOptions();
  void plotBorderColorChanged (String oldValue) => _invalidateChartOptions();
  void plotBorderWidthChanged (String oldValue) => _invalidateChartOptions();
  void plotShadowChanged (String oldValue) => _invalidateChartOptions();
  void polarChanged (String oldValue) => _invalidateChartOptions();
  void reflowChanged (String oldValue) => _invalidateChartOptions();
  void renderToChanged  (String oldValue) => _invalidateChartOptions();
  /*TODO: void resetZoomButtonChanged (String oldValue) => _invalidateChartOptions(); */
  void selectionMarkerFillChanged (String oldValue) => _invalidateChartOptions();
  void shadowChanged (String oldValue) => _invalidateChartOptions();
  void showAxesChanged (String oldValue) => _invalidateChartOptions();
  void spacingChanged (String oldValue) => _invalidateChartOptions();
  void spacingBottomChanged (String oldValue) => _invalidateChartOptions();
  void spacingLeftChanged (String oldValue) => _invalidateChartOptions();
  void spacingRightChanged (String oldValue) => _invalidateChartOptions();
  void spacingTopChanged (String oldValue) => _invalidateChartOptions();
  void chartStyleChanged (String oldValue) => _invalidateChartOptions();
  void typeChanged (String oldValue) => _invalidateChartOptions();
  void widthChanged  (String oldValue) => _invalidateChartOptions();
  void zoomTypeChanged  (String oldValue) => _invalidateChartOptions();
  
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
      
      
      
      if (chartOptions.chart.alignTicks == null) chartOptions.chart.alignTicks = alignTicks;
      if (chartOptions.chart.animation == null) chartOptions.chart.animation = animation;
      if (chartOptions.chart.backgroundColor == null) chartOptions.chart.backgroundColor = backgroundColor;
      if (chartOptions.chart.borderColor == null) chartOptions.chart.borderColor = borderColor;
      if (chartOptions.chart.borderRadius == null) chartOptions.chart.borderRadius = borderRadius;
      if (chartOptions.chart.borderWidth == null) chartOptions.chart.borderWidth = borderWidth;
      if (chartOptions.chart.className == null) chartOptions.chart.className = className;
      if (chartOptions.chart.defaultSeriesType == null) chartOptions.chart.defaultSeriesType = defaultSeriesType;
      /* TODO: if (chartOptions.chart.events == null) chartOptions.chart.events = events;*/
      if (chartOptions.chart.height == null) chartOptions.chart.height = height;
      if (chartOptions.chart.ignoreHiddenSeries == null) chartOptions.chart.ignoreHiddenSeries = ignoreHiddenSeries;
      if (chartOptions.chart.inverted == null) chartOptions.chart.inverted = inverted;
      if (chartOptions.chart.margin == null) chartOptions.chart.margin = margin;
      if (chartOptions.chart.marginBottom == null) chartOptions.chart.marginBottom = marginBottom;
      if (chartOptions.chart.marginLeft == null) chartOptions.chart.marginLeft = marginLeft;
      if (chartOptions.chart.marginRight == null) chartOptions.chart.marginRight = marginRight;
      if (chartOptions.chart.marginTop == null) chartOptions.chart.marginTop = marginTop;
      if (chartOptions.chart.pinchType == null) chartOptions.chart.pinchType = pinchType;
      if (chartOptions.chart.plotBackgroundColor == null) chartOptions.chart.plotBackgroundColor = plotBackgroundColor;
      if (chartOptions.chart.plotBackgroundImage == null) chartOptions.chart.plotBackgroundImage = plotBackgroundImage;
      if (chartOptions.chart.plotBorderColor == null) chartOptions.chart.plotBorderColor = plotBorderColor;
      if (chartOptions.chart.plotBorderWidth == null) chartOptions.chart.plotBorderColor = plotBorderColor;
      if (chartOptions.chart.plotShadow == null) chartOptions.chart.plotShadow = plotShadow;
      if (chartOptions.chart.polar == null) chartOptions.chart.polar = polar;
      if (chartOptions.chart.reflow == null) chartOptions.chart.reflow = reflow;
      /* TODO: if (chartOptions.chart.resetZoomButton == null) chartOptions.chart.resetZoomButton = resetZoomButton; */
      if (chartOptions.chart.selectionMarkerFill == null) chartOptions.chart.selectionMarkerFill = selectionMarkerFill;
      if (chartOptions.chart.shadow == null) chartOptions.chart.shadow = shadow;
      if (chartOptions.chart.showAxes == null) chartOptions.chart.showAxes = showAxes;
      if (chartOptions.chart.spacing == null) chartOptions.chart.spacing = spacing;
      if (chartOptions.chart.spacingBottom == null) chartOptions.chart.spacingBottom = spacingBottom;
      if (chartOptions.chart.spacingLeft == null) chartOptions.chart.spacingLeft = spacingLeft;
      if (chartOptions.chart.spacingRight == null) chartOptions.chart.spacingRight = spacingRight;
      if (chartOptions.chart.spacingTop == null) chartOptions.chart.spacingTop = spacingTop;
      if (chartOptions.chart.style == null) chartOptions.chart.style = chartStyle;
      if (chartOptions.chart.type == null) chartOptions.chart.type = type;
      if (chartOptions.chart.width  == null) chartOptions.chart.width = width;
      if (chartOptions.chart.zoomType  == null) chartOptions.chart.zoomType = zoomType;
      
      
      
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
  
  bool _updateable (List<HighchartsSeries> seriesInDOM, List<HighchartsSeries> prevSeries) {
    bool updateable = true;
    if (_previousSeries != null && seriesInDOM != null && 
        seriesInDOM.length == prevSeries.length) {
      Map<String, HighchartsSeries> previousIndexed = new Map<String, HighchartsSeries> ();
      _previousSeries.forEach((HighchartsSeries series) {
        if (series.id != null)
          previousIndexed[series.id] = series;  
      });  
      seriesInDOM.forEach((HighchartsSeries hcSeries) {
        updateable = updateable && previousIndexed[hcSeries.id] != null;
      });
    }
    else {
      updateable = false;
    }
    return updateable;
  }
  
  void _commitSeries (List<HighchartsSeries> seriesInDOM) {
    if (chartOptions != null) {
      if (chartOptions.series == null) {
        chartOptions.series = new List<hc.Series> ();
      }
      chartOptions.series.clear();
      seriesInDOM.forEach((HighchartsSeries highchartsSeries) {
        _seriesDictionary[highchartsSeries.id] = highchartsSeries;
        chartOptions.series.add(highchartsSeries.getSeries());
      });
    }
    _previousSeries = seriesInDOM;
  }
  
  void _updateSeries (List<HighchartsSeries> seriesInDOM) {
    seriesInDOM.forEach ((HighchartsSeries hcSeries) {
      JsObject jsSeries = jsHighchart.callMethod("get", [hcSeries.id]);
      jsSeries.callMethod("setData", [hcSeries.getSeries().getJsData()]);
      hcSeries.getSeries().setJsChart(jsHighchart);
    });
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
  
  void set xAxes (List<hc.XAxis> xAxes) {
    if (chartOptions != null) {
      chartOptions.xAxes = xAxes;
    }
    else {
      _xAxes = xAxes;
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
  
  void set yAxes (List<hc.YAxis> yAxes) {
    if (chartOptions != null) {
      chartOptions.yAxes = yAxes;
    }
    else {
      _yAxes = yAxes;
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
      List<HighchartsSeries> seriesInDOM = _findSeriesInDOM ();
      if (_seriesDirty) {
        _updateableSeries = _updateable(seriesInDOM, _previousSeries);
        if (_updateableSeries) {
          _updateSeries(seriesInDOM);
        }  
        else {
          _commitSeries(seriesInDOM);
          _createChart ();
        }
        _seriesDirty = false;
      }
      
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
    if (_xAxes != null && _xAxes.length > 0) {
      chartOptions.xAxes = _xAxes;
    }
    if (_yAxes != null && _yAxes.length > 0) {
      chartOptions.yAxes = _yAxes;
    }
    _listenToChartOptionsChanges (chartOptions);
    if (chartOptions.chart == null) 
      chartOptions.chart = new hc.Chart ();
    chartOptions.chart.renderTo = mainDiv;
    mainDiv.children.clear();
    jsHighchart = new JsObject(context['Highcharts']['Chart'], [chartOptions.toJsObject()]);
    chartOptions.setJsChart (jsHighchart);
    context['myChart'] = jsHighchart;
  }
  
}