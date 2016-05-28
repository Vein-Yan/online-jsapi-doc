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

您可以使用来自您的SuperMap iServer服务器的REST GIS服务，例如来自SuperMap技术资源中心的：http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。

您也可以将数据托管在SuperMap Online，使用发布的地图服务，例如：http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World

如果需要在线GIS服务器，您还可以在SuperMap Online租用GIS云主机，并发布您自己的GIS服务。

#### 3. SuperMap的JavaScript API

iClient for JavaScript与iConnectorLeaflet.js

```JavaScript
	<script src="http://www.supermapol.com/resources/api/libs/SuperMap.Include.js"></script>
	<script src="http://www.supermapol.com/resources/api/iconnector/iConnectorLeaflet.js"></script>
```

### 示例1：使用Leaflet API加载SuperMap地图服务

**Step1 初始化地图窗口**

使用Leaflet的map模块API创建地图窗口“map”，如：map = L.map('map').setView([38, 115], 5)。其中，.setView([38, 115], 5)指定了地图的中心点和比例尺级别。
需要指出的是，虽然本例使用的地图本身的坐标系是EPSG Code为3857的WebMercator，但是Leaflet API设置中心点的参数格式为：[<Number> latitude, <Number> longitude,]，而不是地图本身的单位。

```JavaScript
	map = L.map('map').setView([38, 115], 5);
```

**Step2 加载SuperMap地图服务中的地图**

iConnectorLeaflet.js 提供了 SuperMap.Web.iConnector.Leaflet.getLayer来创建图层，图层数据来源为SuperMap的REST地图服务。然后可以通过Leaflet的addTo接口叠加到地图上。
		
```JavaScript
	var map,url = "http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China";
		function init()
		{
			var canvasTiles =  SuperMap.Web.iConnector.Leaflet.getLayer(url);
			canvasTiles.addTo(map);
		}
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/cy9rirrf)
* [源码编辑](http://runjs.cn/code/cy9rirrf)

### 示例2：在OpenStreetMap上叠加SuperMap的地图

**Step1 初始化地图窗口加载OpenStreetMap**

```JavaScript
	var map = L.map('map').setView([38, 115], 5);
	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
		maxZoom: 18
	}).addTo(map);
```

**Step2 使用iConnectorLeaflet.js转换SuperMap地图**

```JavaScript
	var canvasTiles =  SuperMap.Web.iConnector.Leaflet.getLayer(url);
	canvasTiles.addTo(map);
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/bniri8f6)
* [源码编辑](http://runjs.cn/code/bniri8f6)

### 示例3：在OpenStreetMap上绘制SuperMap几何对象

**Step1 使用Leaflet API初始化地图窗口**

```JavaScript
	var map = L.map('map').setView([40,116], 7);
	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		attribution: 'Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
		maxZoom: 18
	}).addTo(map);
```	

**Step2 加载SuperMap点对象**

* 通过SuperMap JS API创建point
```JavaScript
	var point = new SuperMap.Geometry.Point(116.397,39.913);
```
* 通过iConnectorLeaflet.js，把上述point转为Leaflet格式的点myLatlng
	
```JavaScript	
    var myLatlng = SuperMap.Web.iConnector.Leaflet.transferPoint([point])[0]; 
```
* 通过Leaflet API把转换后的点myLatlng加载到底图上
```JavaScript
	L.marker(myLatlng).addTo(map)
                      .bindPopup("<b>Hello world!</b><br/>I am a popup.").openPopup();
```

**Step3 加载SuperMap线对象gLine**

* 通过SuperMap JS API创建由点串组成的线line1
```JavaScript
	var points1 = [
		new SuperMap.Geometry.Point(115,40.5),
		new SuperMap.Geometry.Point(116.5,41.5),
		new SuperMap.Geometry.Point(118,40.5)

	];
	var line1 = new SuperMap.Geometry.LineString(points1);
```
* 通过iConnectorLeaflet.js，把上述line1转为Leaflet格式的线gLine
	
```JavaScript	
    var gLine = SuperMap.Web.iConnector.Leaflet.transferLine([line1])[0];
```
* 通过Leaflet API把转换后的线gLine加载到底图上
```JavaScript
	gLine.addTo(map);
```

**Step4 加载SuperMap面对象gPolygon**

* 通过SuperMap JS API创建polygon，一个多边形由线的相交部门合围而成
```JavaScript
	var points2 = [
                new SuperMap.Geometry.Point(116.5,41.5),
                new SuperMap.Geometry.Point(115.5,38.5),
                new SuperMap.Geometry.Point(118,40.5),
                new SuperMap.Geometry.Point(115,40.5),
                new SuperMap.Geometry.Point(118,38.5),
                new SuperMap.Geometry.Point(116.5,41.5)
            ];
    var line2 = new SuperMap.Geometry.LinearRing(points2);
    var polygon = new SuperMap.Geometry.Polygon([line2]);  
```
* 通过iConnectorLeaflet.js，把上述polygon转为Leaflet格式的面gPolygon
```JavaScript	
    var gPolygon = SuperMap.Web.iConnector.Leaflet.transferPolygon([polygon])[0];
```

* 通过Leaflet API把转换后的线gPolygon加载到底图上
```JavaScript
	gPolygon.addTo(map);
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/wix82fok)
* [源码编辑](http://runjs.cn/code/wix82fok)
	
### 示例4：在OpenStreetMap上叠加SuperMap距离查询结果

**Step1 初始化地图窗口**

```JavaScript
	map = L.map('map').setView([51.505, -0.09], 1);
	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		attribution: 'Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
		maxZoom: 18
	}).addTo(map);
	L.marker([ 39.915,116.404]).addTo(map)//设置点加载到地图中
	 .openPopup();
```	

**Step2 SuperMap距离查询**

查询距离指定点centerPoint距离为40（使用地图单位度）的所有首都（图层Capitals@World.1），然后返回查询结果对象。

```JavaScript
	var url = "http://support.supermap.com.cn:8090/iserver/services/map-world/rest/maps/World";
	function queryByDistance() {
		var centerPoint = new SuperMap.Geometry.Point(116.404,39.915);
		var queryByDistanceParams = new SuperMap.REST.QueryByDistanceParameters({
			queryParams: new Array(new SuperMap.REST.FilterParameter({name: "Capitals@World.1"})),
			returnContent: true,
			distance: 40,
			geometry: centerPoint
		});
		
		var queryByDistanceService = new SuperMap.REST.QueryByDistanceService(url);
		queryByDistanceService.events.on({
			"processCompleted": processCompleted,
			"processFailed": processFailed
						});
		queryByDistanceService.processAsync(queryByDistanceParams);
	}
```

**Step3 把查询结果转换并叠加到地图上**

获取上述距离查询的结果点对象的坐标，依次标注在地图上，并使用自定义的Marker。
	
```JavaScript	
	function processCompleted(queryEventArgs) {
		var i, j, result = queryEventArgs.result;
		var points = [];
		for(i = 0;i < result.recordsets.length; i++) {
			for(j = 0; j < result.recordsets[i].features.length; j++) {
				var point = result.recordsets[i].features[j].geometry,
					size = new SuperMap.Size(44, 33),
					offset = new SuperMap.Pixel(-(size.w/2), -size.h);
				points.push(point);
				var resultIcon = L.icon({
					iconUrl: 'http://sandbox.runjs.cn/uploads/rs/3/dofmucai/markerbig.png'
				});
				L.marker([point.y,point.x],{icon: resultIcon}).addTo(map);
			}
			
		}
	}
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/bibjevac)
* [源码编辑](http://runjs.cn/code/bibjevac)

### 示例5：在OpenStreetMap上叠加SuperMap缓冲区

**Step1 初始化OpenStreetMap地图**

```JavaScript
	var map = L.map('map').setView([40,116], 8);
	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
	attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
	maxZoom: 18
	}).addTo(map);
```

**Step2 绘制一条线并加载到地图上**

初始化两个点，构建为SuperMap线polyLine。通过iConnectorLeaflet.js将线polyLine转换（transferLine）为兼容OpenStreetMap坐标的线gLine，并加载到地图上。

```JavaScript
	var points = [ 
		new SuperMap.Geometry.Point(116.5,41.5),
		new SuperMap.Geometry.Point(118,40.5)
	];
	var polyLine = new SuperMap.Geometry.LineString(points);
	var gLine = SuperMap.Web.iConnector.Leaflet.transferLine([polyLine])[0];
	gLine.addTo(map); 
```

**Step3 构建SuperMap缓冲区**

使用SuperMap iClient for JavaScript API调用在线的空间分析服务，返回分析结果中的缓冲区面对象。

```JavaScript
	var url ="http://support.supermap.com.cn:8090/iserver/services/spatialanalyst-changchun/restjsr/spatialanalyst";

	var bufferServiceByGeometry = new SuperMap.REST.BufferAnalystService(url),

	bufferDistance = new SuperMap.REST.BufferDistance({
		value: 0.1
	}),

	bufferSetting = new SuperMap.REST.BufferSetting({
		endType: SuperMap.REST.BufferEndType.ROUND,
		leftDistance: bufferDistance,
		rightDistance: bufferDistance,
		semicircleLineSegment: 1
	}),

	geoBufferAnalystParam = new SuperMap.REST.GeometryBufferAnalystParameters({
		sourceGeometry: polyLine,
		bufferSetting: bufferSetting
	});

	bufferServiceByGeometry.events.on(
	{
		"processCompleted": bufferAnalystCompleted
	});
	bufferServiceByGeometry.processAsync(geoBufferAnalystParam);
```

**Step4 转换缓冲区并叠加到地图上**

通过iConnectorLeaflet.js将生成的缓冲区转换（transferPolygon）为Leaflet支持的格式的面对象，然后添加到地图上。

```JavaScript
	var bufferResultGeometry = BufferAnalystEventArgs.result.resultGeometry;
	var regions = SuperMap.Web.iConnector.Leaflet.transferPolygon([bufferResultGeometry])[0];
	regions.addTo(map);//生成的缓冲区加载到地图
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/ptxnf641)
* [源码编辑](http://runjs.cn/code/ptxnf641)