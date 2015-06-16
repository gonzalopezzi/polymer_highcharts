# Changelog

## 0.0.1

* Initial version, created by Stagehand.

## 0.2.1

* Bugfix setting chartOptions and chartTitle
* Added legendEnabled property
* Configurable colors in highcharts-series
* Require 0.2.1 version of highcharts_options 
* Multiple axis optimizations
* Some optimizations in multiple axes and avoiding chart creation when not necessary. If the data has the same number of series and X axes, the data is updated instead of recreating again the whole chart 
* Support for Internet Explorer 10 has been improved
* Allow dynamic series to have no series at all using highcharts-no-series element
* Fix axesDirty returning false when we had different number of axes

## 0.2.1+8

* Added DEBUG mode, it logs the highcharts configuration object to console, when the static variable DEBUG is set to true 