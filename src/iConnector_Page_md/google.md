#### 使用iConnector对接Google地图应用
---
<!-- toc -->
#### iConnectorGoogle.js简介

如果您已经使用Google地图的JavaScript API构建了地图应用，您可以通过iConnectorGoogle.js对接SuperMap的GIS服务。例如：在Google地图上叠加通过SuperMap发布的业务数据。

iConnectorGoogle.js主要提供了地图叠加以及Geometry的转换，可以实现：在Google地图上，叠加SuperMap地图服务中的地图、专题图、查询结果，以及空间分析结果。


#### 准备开发环境

##### 1. 基于Google地图 JavaScript API的地图应用

您可以使用Google地图的在线JavaScript API，使用方式：

```JavaScript
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
```

##### 2. 准备SuperMap GIS服务

您可以使用来自您的SuperMap iServer服务器的REST GIS服务，例如来自SuperMap技术资源中心的：http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China

您也可以将数据托管在SuperMap Online，使用发布的地图服务，例如：http://www.supermapol.com/iserver/services/map_China4003/rest/maps?key=IbooSg6gIBmhIRaesVgjSED0 ，具体的数据托管与发布方式请参考：[在线发布GIS服务并使用](http://blog.supermapol.com/GettingStarted/PublishServices.html)。

本文将以上述REST服务为例，介绍如何使用iConnector对接SuperMap REST服务与第三方地图。

如果需要在线GIS服务器，您还可以在SuperMap Online租用GIS云主机，并发布您自己的GIS服务。

##### 3. SuperMap的JavaScript API

包括iClient for JavaScript与iConnectorGoogle.js两部分：

```JavaScript
	<script src="http://www.supermapol.com/resources/api/libs/SuperMap.Include.js"></script>
	<script src="http://www.supermapol.com/resources/api/iconnector/iConnectorGoogle.js"></script>
```

#### 示例1：在Google地图上叠加SuperMap分段专题图

**Step1 初始化Google地图**

使用Google地图API创建地图窗口“map-canvas”，并设置加载地图的中心点和比例尺级别，
创建地图如：map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

```JavaScript
	var myLatlng = new google.maps.LatLng(0, 0);
	var mapOptions = {
		center: myLatlng,
		zoom: 1,
		streetViewControl: true,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	map = new google.maps.Map(document.getElementById('map-canvas'),
			mapOptions);
```

**Step2 制作SuperMap分段专题图**

使用SuperMap.Include.js，基于SuperMap REST服务中的"China_Province_R"图层，制作分段专题图。

```JavaScript
	var themeService = new SuperMap.REST.ThemeService(url, {eventListeners:{"processCompleted": themeCompleted, "processFailed": themeFailed}}),
		style1 = new SuperMap.REST.ServerStyle({
			fillForeColor: new SuperMap.REST.ServerColor(137,203,187),
			lineColor: new SuperMap.REST.ServerColor(0,0,0),
			lineWidth: 0.1
		}),
		style2 = new SuperMap.REST.ServerStyle({
			fillForeColor: new SuperMap.REST.ServerColor(233,235,171),
			lineColor: new SuperMap.REST.ServerColor(0,0,0),
			lineWidth: 0.1
		}),
		style3 = new SuperMap.REST.ServerStyle({
			fillForeColor: new SuperMap.REST.ServerColor(135,157,157),
			lineColor: new SuperMap.REST.ServerColor(0,0,0),
			lineWidth: 0.1
		}),
		themeRangeIteme1 = new SuperMap.REST.ThemeRangeItem({
			start: 0,
			end: 500000000000,
			style: style1
		}),
		themeRangeIteme2 = new SuperMap.REST.ThemeRangeItem({
			start: 500000000000,
			end: 1000000000000,
			style: style2
		}),
		themeRangeIteme3 = new SuperMap.REST.ThemeRangeItem({
			start: 1000000000000,
			end:  3000000000000,
			style: style3
		}),
		themeRange = new SuperMap.REST.ThemeRange({
			rangeExpression: "SMAREA",
			rangeMode: SuperMap.REST.RangeMode.EQUALINTERVAL,
			items: [themeRangeIteme1,themeRangeIteme2,themeRangeIteme3]
		}),
		themeParameters = new SuperMap.REST.ThemeParameters({
			datasetNames: ["China_Province_R"],
			dataSourceNames: ["China400"],
			joinItems: null,
			themes: [themeRange]
		});
	themeService.processAsync(themeParameters);
```

**Step3 把SuperMap专题图转换后叠加到Google地图上**

使用iConnectorGoogle.js把Step2创建的SuperMap专题图叠加到Step1创建的Google地图上。
		
```JavaScript
	if(themeEventArgs.result.resourceInfo.id) {
		map.overlayMapTypes.insertAt(
				0, SuperMap.Web.iConnector.Google.getLayer(url,{layersID:themeEventArgs.result.resourceInfo.id}));
	}
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/nk6mvwfi)
* [源码编辑](http://runjs.cn/code/nk6mvwfi)

#### 示例2：在Google地图上绘制来自SuperMap的Geometry

**Step1 初始化POI点**

创建一个poi点，并通过iConnectorGoogle.js转为Google地图能识别的点myLatlng。

```JavaScript
	var poi = {x:116.397,y:39.913};
	var myLatlng = SuperMap.Web.iConnector.Google.transferPoint([poi],new SuperMap.Projection("EPSG:4326"))[0];
```

**Step2 以转换后的POI为中心点初始化Google地图**

```JavaScript
	var mapOptions = {
		zoom: 7,
		center: myLatlng,
		mapTypeId: google.maps.MapTypeId.TERRAIN
	}
	var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
```

**Step3 在地图上标注换后的POI**

```JavaScript
	var marker = new google.maps.Marker({
		position: myLatlng,
		map: map
	});
```

**Step4 绘制并加载SuperMap线**

* 通过SuperMap iClient for JavaScript API创建一条线line1

```JavaScript
	var points1 = [
		new SuperMap.Geometry.Point(115,40.5),
		new SuperMap.Geometry.Point(116.5,41.5),
		new SuperMap.Geometry.Point(118,40.5)
	];
	var line1 = new SuperMap.Geometry.LineString(points1);
```

* 通过iConnectorGoogle.js将line1转为Leaflet格式的线gLine

```JavaScript
	var gLine = SuperMap.Web.iConnector.Google.transferLine([line1])[0];
```

* 通过Google地图JS API把gLine绘制在地图上并设置显示颜色

```JavaScript
	var options = {strokeColor: '#FF0000'};
	gLine.setOptions(options);
	gLine.setMap(map);
```

**Step5 绘制并加载SuperMap面**

* 通过SuperMap iClient for JavaScript API创建一个由线围成的面polygon

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

* 通过iConnectorGoogle.js将polygon转为Google格式的面gPolygon

```JavaScript
	var gPolygon = SuperMap.Web.iConnector.Google.transferPolygon([polygon])[0];
```

* 通过Google地图JS API把gPolygon绘制在地图上并设置显示颜色

```JavaScript
	var options = {strokeColor: '#FF0000'};
	gPolygon.setOptions(options);
	gPolygon.setMap(map);
```
**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/vwwjkoks)
* [源码编辑](http://runjs.cn/code/vwwjkoks)

