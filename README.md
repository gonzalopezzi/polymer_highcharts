Polymer Highcharts
-------------------
Use Highcharts in your polymer projects. With polymer components you can add charts to your 
projects easier than ever.  

How does it work?
-----------------
First of all, add the dependency to your **pubspec.yaml**: 
```
dependencies: 
  polymer_highcharts: any
```

Add this lines to the main html of your application (index.html) in the head section.
```
<script src="../../packages/polymer_highcharts/js/standalone-framework.js"></script>
<script src="../../packages/polymer_highcharts/js/highcharts.js"></script>
<script src="../../packages/polymer_highcharts/js/highcharts-more.js"></script>
<script src="../../packages/polymer_highcharts/js/highcharts.src.SHADOWDOMFIX.js"></script>
```

Then, add the imports to your html file 
```
<link rel="import" href="../../packages/polymer/polymer.html">
<link rel="import" href="../../packages/polymer_highcharts/highcharts_polymer_component.html">
<link rel="import" href="../../packages/polymer_highcharts/highcharts_series.html">
<link rel="import" href="../../packages/polymer_highcharts/highcharts_x_axis.html">
<link rel="import" href="../../packages/polymer_highcharts/highcharts_y_axis.html">
```
And just use the components:
```
<highcharts-polymer 
      title="Title" subtitle="Monthly Average Temperature" 
      type="line" borderColor="#CCC" creditsEnabled="false"
      borderWidth="1" borderRadius="8" backgroundColor="rgba(0,0,0,0)">
  <highcharts-x-axis categories="['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic']"></highcharts-x-axis>
  <highcharts-y-axis title="Temperatura (ºC)"></highcharts-y-axis>
  <highcharts-series name="Ponferrada"
      type="column"
      numData="[17.0, 16.9, 19.5, 24.5, 28.2, 31.5, 35.2, 36.5, 33.3, 28.3, 23.9, 19.6]"></highcharts-series>
  <highcharts-series name="Tokyo"
      type="line"
      numData="[7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]"></highcharts-series>
  <highcharts-series name="New York"
      type="line"
      numData="[-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]"></highcharts-series>
</highcharts-polymer>
```

Samples
----------
You can find full code samples in the [Polymer Highcharts Samples Site](highcharts-samples.gonzalopezzi.com)
Or you can also take a look at the [github site of the samples](https://github.com/gonzalopezzi/polymer_highcharts_samples), just in case you want to clone it and see it running live. 

Disclaimer
----------
*This is just a work in progress. This is just a piece of software to help people use Highcharts in their Dart projects, but the author is not part of the Highcharts team. *
*Keep in mind that if you want to use Highcharts in commercial applications, you will have to acquire a developer licence* 
