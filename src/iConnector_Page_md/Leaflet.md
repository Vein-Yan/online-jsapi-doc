# 使用iConnector对接Leaflet地图应用
---
<!-- toc -->
### iConnectorLeaflet.js简介

如果您已经使用Leaflet构建了地图应用，您可以通过iConnectorLeaflet.js对接SuperMap的GIS服务。例如：在Leaflet构建的在线地图上叠加SuperMap的缓冲区分析结果。

iConnectorLeaflet.js主要提供了地图叠加以及Geometry的转换，可以实现：在使用Leaflet的API出的地图上，叠加SuperMap地图服务中的地图、专题图、查询结果，以及空间分析结果。


### 准备开发环境

#### 1. 基于Leaflet API的地图应用

您可使用下载在本地的API，或在线API：

```JavaScript
	<script src="http://cdn.leafletjs.com/leaflet/v0.7.7/leaflet.js"></script>
```

#### 2. 准备SuperMap GIS服务

您可以使用来自您的SuperMap iServer服务器的REST GIS服务，就像来自SuperMap技术资源中心的：http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。

您也可以将数据托管在SuperMap Online，使用发布的地图服务，例如：http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World

如果需要在线GIS服务器，您还可以在SuperMap Online租用GIS云主机，并发布您自己的GIS服务。

#### 3. SuperMap的JavaScript API与iConnectorLeaflet.js

```JavaScript
	<script src="http://www.supermapol.com/resources/api/libs/SuperMap.Include.js"></script>
    <script src="http://sandbox.runjs.cn/uploads/rs/3/dofmucai/iConnectorLeaflet.js"></script>
```

### 示范程序

#### 示例1：使用Leaflet的API，加载来自SuperMap的地图

##### Step1 使用Leaflet API创建地图窗口

使用Leaflet的map模块API创建地图窗口“map”，如：map = L.map('map').setView([38, 115], 5)。其中，.setView([38, 115], 5)指定了地图的中心点和比例尺级别。
需要指出的是，虽然本例使用的地图本身的坐标系是EPSG Code为3857的WebMercator，但是Leaflet API设置中心点的参数格式为：[<Number> latitude, <Number> longitude,]，而不是地图本身的单位。

```JavaScript
	map = L.map('map').setView([38, 115], 5);
```

##### Step2 使用iConnectorLeaflet.js加载SuperMap地图服务中的地图
SuperMap.Web.iConnector.Leaflet.getLayer创建图层，并使用来自SuperMap的地图。
		
```JavaScript
	var map,url = "http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China";
		function init()
		{
				
			var canvasTiles =  SuperMap.Web.iConnector.Leaflet.getLayer(url);
			canvasTiles.addTo(map);
		}
```

##### 在线演示与源码编辑

在线演示：
http://runjs.cn/detail/cy9rirrf

源码编辑：
http://runjs.cn/code/cy9rirrf		

#### 示例2：使用Leaflet的API，在OpenStreetMap上叠加SuperMap的地图

##### Step1 使用Leaflet API创建地图窗口

```
	map = L.map('map').setView([38, 115], 5);
```

##### Step2 使用Leaflet API加载OpenStreetMap

```JavaScript
	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
		maxZoom: 18
	}).addTo(map);
```

##### Step3 使用iConnectorLeaflet.js叠加SuperMap地图

```JavaScript
	var canvasTiles =  SuperMap.Web.iConnector.Leaflet.getLayer(url);
	canvasTiles.addTo(map);
```

##### 在线演示与源码编辑

在线演示：
http://runjs.cn/detail/bniri8f6

源码编辑：
http://runjs.cn/code/bniri8f6
