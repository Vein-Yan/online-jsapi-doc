# 使用iConnector对接高德地图
---
<!-- toc -->
### iConnectorAMap.js简介

如果您已经使用高德地图的JavaScript API构建了地图应用，您可以通过iConnectorAMap.js对接SuperMap的GIS服务。例如：在高德地图上叠加通过SuperMap发布的业务数据。

iConnectorAMap.js主要提供了地图叠加以及Geometry的转换，可以实现：在高德地图上，叠加SuperMap地图服务中的地图、专题图、查询结果，以及空间分析结果。


### 准备开发环境

#### 1. 基于高德地图 JavaScript API的地图应用

您使用高德地图的在线JavaScript API构建的应用，使用方式：

```JavaScript
	<script src="http://webapi.amap.com/maps?v=1.3&key=14bf161ae4e52fe25a972f6b7c9c0980"></script>
```

#### 2. 准备SuperMap GIS服务

您可以使用来自您的SuperMap iServer服务器的REST GIS服务，例如来自SuperMap技术资源中心的：http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。

您也可以将您的业务数据托管在SuperMap Online，然后使用发布的地图服务，例如：http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World

如果需要在线GIS服务器，您还可以在SuperMap Online租用GIS云主机，并发布您自己的GIS服务。

#### 3. SuperMap的JavaScript API

iClient for JavaScript与iConnectorAMap.js

```JavaScript
	<script src="http://www.supermapol.com/resources/api/libs/SuperMap.Include.js"></script>
	<script src="http://www.supermapol.com/resources/api/iconnector/iConnectorAMap.js"></script>
```
### 示例1：在高德地图上叠加SuperMap点密度专题图

**Step1 初始化高德地图**

使用高德地图API创建地图窗口“map”，设置加载地图的中心点和比例尺、缩放级别、坐标系等。

```JavaScript
	var opt = {
		center: new AMap.LngLat(115, 35),//设置地图中心点
		level: 3,//初始地图缩放级别
		zooms:[3,6],//地图缩放级别范围
		crs:"'EPSG4326"
	};
	mapObj = new AMap.Map("map",opt);
```

**Step2 制作SuperMap点密度专题图**

使用SuperMap.Include.js，基于SuperMap REST服务中的"China_Province_R"图层，制作点密度专题图。
		
```JavaScript
	//创建制作点密度专题图服务类
	var themeService = new SuperMap.REST.ThemeService(url, {eventListeners:{"processCompleted": themeCompleted, "processFailed": themeFailed}}),
			dotStyle = new SuperMap.REST.ServerStyle({
				markerSize: 3,
				markerSymbolID: 12
			}),
			themeDotDensity = new SuperMap.REST.ThemeDotDensity({
				dotExpression: "Pop_1994",
				value: 5000000,
				style: dotStyle
			}),
			themeParameters = new SuperMap.REST.ThemeParameters({
				themes: [themeDotDensity],
				datasetNames: ["Countries"],
				dataSourceNames: ["World"]
			});
	//向iserver发送请求
	themeService.processAsync(themeParameters);
```

**Step3 把SuperMap专题图转换后叠加到高德地图上**

使用iConnectorAMap.js把Step2创建的SuperMap专题图叠加到Step1创建的高德地图上。
		
```JavaScript
	if(themeEventArgs.result.resourceInfo.id) {
		var canvasTiles =  SuperMap.Web.iConnector.AMap.getLayer(url,{layersID:themeEventArgs.result.resourceInfo.id});
		mapObj.addLayer(canvasTiles);
	}
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/pmkuutbr)
* [源码编辑](http://runjs.cn/code/pmkuutbr)

### 示例2：在高德地图上叠加SuperMap分段专题图

**Step1 初始化高德地图**

```JavaScript
	var map =new  AMap.Map("map",{
		center: new AMap.LngLat(112, 39.90923),//设置地图中心点
		level: 4,//初始地图默认显示级别
	})
```

**Step2 制作SuperMap分段专题图**

通过iClient for JavaScript API使用SuperMap REST 地图服务，基于China地图中的China_Province_R图层，根据SMAREA字段创建分段专题图。

```JavaScript
	var layer,
	url = "http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China";
	var themeService = new SuperMap.REST.ThemeService(url,
			{eventListeners:{"processCompleted": themeCompleted, "processFailed": themeFailed}}),
			graStyle = new SuperMap.REST.ThemeGraduatedSymbolStyle({
				positiveStyle: new SuperMap.REST.ServerStyle({
					markerSize: 50,
					markerSymbolID: 0,
					lineColor: new SuperMap.REST.ServerColor(255,165,0),
					fillBackColor: new SuperMap.REST.ServerColor(255,0,0)
				})
			}),
			themeGraduatedSymbol = new SuperMap.REST.ThemeGraduatedSymbol({
				expression: "SMAREA",
				baseValue: 3000000000000,
				graduatedMode: SuperMap.REST.GraduatedMode.CONSTANT,
				flow: new SuperMap.REST.ThemeFlow({
					flowEnabled: true
				}),
				style: graStyle
			}),
			themeParameters = new SuperMap.REST.ThemeParameters({
				themes: [themeGraduatedSymbol],
				datasetNames: ["China_Province_R"],
				dataSourceNames: ["China400"]
			});
	
	themeService.processAsync(themeParameters);
```

**Step3 把SuperMap专题图转换后叠加到高德地图上**

```JavaScript
	function themeCompleted(themeEventArgs) {
		if(themeEventArgs.result.resourceInfo.id) {
			var id =  themeEventArgs.result.resourceInfo.id;
			var tileLayer = SuperMap.Web.iConnector.AMap.getLayer(url,{layersID:id});	
		}
		tileLayer.setMap(map);
	}
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/xihjgnun)
* [源码编辑](http://runjs.cn/code/xihjgnun)


### 示例3：在高德地图上叠加SuperMap点 

**Step1 初始化高德地图**

```JavaScript
	var opt = {
		center: new AMap.LngLat(116.39674135,39.91713004),//设置地图中心点
		level: 4//初始地图缩放级别
	}
	mapObj = new AMap.Map("map",opt);
```

**Step2 初始化一个点，并纠偏为高德地图坐标**

```JavaScript
	var poi = {x:116.39674135,y:39.91713004};
	var myLatlng = SuperMap.Web.iConnector.AMap.transferPoint([poi],new SuperMap.Projection("EPSG:4326"))[0];
```

**Step3 将纠偏后的点作为Marker加载到高德地图上**

```JavaScript
	var marker =new AMap.Marker({
		id:"marker",
		position:myLatlng,
		offset:new AMap.Pixel(-10.5,-32), //基点为图片左上角，设置相对基点的图片位置偏移量，向左向下为负
		draggable:false   //不可拖动
	});
	marker.setMap(mapObj);
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/eyeio9kq)
* [源码编辑](http://runjs.cn/code/eyeio9kq)

### 示例4：把SuperMap面几何对象添加到高德地图 

**Step1 初始化高德地图 **

```JavaScript
	var mapObj;
	var opt = {
		center: new AMap.LngLat(116.39674135,39.91713004),//设置地图中心点
		level: 3//初始地图缩放级别
	}
	mapObj = new AMap.Map("map",opt);
```

**Step2 SuperMap SQL查询返回面对象**

通过iClient for JavaScript API调用SuperMap REST 地图服务进行SQL查询，本例将在Countries@World.1图层中查询人口和面积均满足条件（"Pop_1994>1000000000 and SmArea>900"）的要素。 完成查询后，返回查询结果几何对象。

```JavaScript
	var url="http://support.supermap.com.cn:8090/iserver/services/map-world/rest/maps/World";
	function queryBySQL() {
		
		var queryParam, queryBySQLParams, queryBySQLService;
		queryParam = new SuperMap.REST.FilterParameter({
			name: "Countries@World.1",
			attributeFilter: "Pop_1994>1000000000 and SmArea>900"
		});
		queryBySQLParams = new SuperMap.REST.QueryBySQLParameters({
			queryParams: [queryParam]
		});
		queryBySQLService = new SuperMap.REST.QueryBySQLService(url, {
			eventListeners: {"processCompleted": processCompleted, "processFailed": processFailed}});
		queryBySQLService.processAsync(queryBySQLParams);
	}
	function processCompleted(queryEventArgs) {
		var i, j, feature,
				result = queryEventArgs.result;
		if (result && result.recordsets) {
			for (i=0; i<result.recordsets.length; i++) {
				if (result.recordsets[i].features) {
					for (j=0; j<result.recordsets[i].features.length; j++) {
						feature = result.recordsets[i].features[j];
						var polygon = feature.geometry;
						getPoints(polygon);
					}
				}
			}
		}
	}
```

**Step3 通过iConnectorBaidu.js纠偏并叠加到百度地图上**

```JavaScript
	if(geometry.CLASS_NAME === 'SuperMap.Geometry.MultiPolygon' ||
		 geometry.CLASS_NAME === 'SuperMap.Geometry.MultiLineString' ||
		 geometry.CLASS_NAME === 'SuperMap.Geometry.MultiPoint'){
		for(var i = 0,len = geometry.components.length;i<len;i++){
			getPoints(geometry.components[i]);
		}
		return;
	}

	var regions = SuperMap.Web.iConnector.AMap.transferPolygon([geometry],new SuperMap.Projection("EPSG:4326"));
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/vaxzvlrp)
* [源码编辑](http://runjs.cn/code/vaxzvlrp)

### 示例5：在高德地图上叠加SuperMap缓冲区

**Step1 初始化高德地图并绘制用于分析的线**

在进行缓冲区分析前，需要先准备用于分析的线。本例为了展示线的位置，将该线纠偏后叠加在地图上。

```JavaScript
var map;
var points = [
	new SuperMap.Geometry.Point(116.39674135,39.91713004),
	new SuperMap.Geometry.Point(104.02682248,30.69939851)
];
var polyLine = new SuperMap.Geometry.LineString(points);     //点构成线
function init()
{
	var opt = {
		center: new AMap.LngLat(116.4, 36),//设置地图中心点
		level: 5//初始地图缩放级别
	}
			map = new AMap.Map("map",opt);
	var gLine = SuperMap.Web.iConnector.AMap.transferLine([polyLine])[0];
	gLine.setMap(map);
}
```

**Step2 进行SuperMap缓冲区分析返回缓冲区面**

通过iClient for JavaScript API调用SuperMap REST 空间分析服务进行缓冲区分析，并将生成的缓冲区返回。

```JavaScript
	var regions,url ="http://support.supermap.com.cn:8090/iserver/services/spatialanalyst-changchun/restjsr/spatialanalyst";
	//缓冲区分析
	function bufferAnalystProcess()
	{
		if(regions)
		{
			map.removeLayer(regions);
		}
		var bufferServiceByGeometry = new SuperMap.REST.BufferAnalystService(url),
				
				bufferDistance = new SuperMap.REST.BufferDistance({
					value: 1
				}),
				
				bufferSetting = new SuperMap.REST.BufferSetting({
					endType: SuperMap.REST.BufferEndType.ROUND,
					leftDistance: bufferDistance,
					rightDistance: bufferDistance,
					semicircleLineSegment: 10
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
		
	}
	function bufferAnalystCompleted(BufferAnalystEventArgs)
		{
			var bufferResultGeometry = BufferAnalystEventArgs.result.resultGeometry;
			addGeometry(bufferResultGeometry,map);
		}
```

**Step3 缓冲区面对象纠偏并叠加到高德地图**

通过iConnectorAMap.js，对缓冲区结果中的面对像进行纠偏，如果是多面（MultiPolygon），则转为普通的面对象。然后通过高德地图的setMap方法，把纠偏后的面叠加到地图上。

```JavaScript
function addGeometry(geometry,map){
		if(geometry.CLASS_NAME === 'SuperMap.Geometry.MultiPolygon'){
			for(var i = 0,len = geometry.components.length;i<len;i++){
				addGeometry(geometry.components[i],map);
			}
			return;
		}
		regions = SuperMap.Web.iConnector.AMap.transferPolygon([geometry]);
		regions[0].setMap(map); //生成的缓冲区加载到地图
}
```
**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/hxgpdmz4)
* [源码编辑](http://runjs.cn/code/hxgpdmz4)



