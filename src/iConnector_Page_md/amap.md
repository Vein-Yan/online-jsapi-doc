# 使用iConnector对接高德地图
---
<!-- toc -->
### iConnectorAMap.js简介

如果您已经使用高德地图的JavaScript API构建了地图应用，您可以通过iConnectorAMap.js对接SuperMap的GIS服务。例如：在高德地图上叠加通过SuperMap发布的业务数据。

iConnectorAMap.js主要提供了地图叠加以及Geometry的转换，可以实现：在高德地图上，叠加SuperMap地图服务中的地图、专题图、查询结果，以及空间分析结果。


### 准备开发环境

#### 1. 基于高德地图 JavaScript API的地图应用

您可以使用高德地图的在线JavaScript API，使用方式：

```JavaScript
	<script src="http://webapi.amap.com/maps?v=1.2&key=14bf161ae4e52fe25a972f6b7c9c0980"></script>
```

#### 2. 准备SuperMap GIS服务

您可以使用来自您的SuperMap iServer服务器的REST GIS服务，就像来自SuperMap技术资源中心的：http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。

您也可以将业务数据托管在SuperMap Online，然后使用发布的地图服务，例如：http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World

如果需要在线GIS服务器，您还可以在SuperMap Online租用GIS云主机，并发布您自己的GIS服务。

#### 3. SuperMap的JavaScript API与iConnectorAMap.js

```JavaScript
	<script src="http://www.supermapol.com/resources/api/libs/SuperMap.Include.js"></script>
	<script src="http://sandbox.runjs.cn/uploads/rs/3/dofmucai/iConnectorAMap.js"></script>
```
### 示范程序

#### 示例1：在高德地图上，叠加SuperMap的点密度专题图

##### Step1 创建地图窗口并加载高德地图

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

##### Step2 使用SuperMap.Include.js，基于SuperMap REST服务中的"China_Province_R"图层，制作点密度专题图
		
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

##### Step3 使用iConnectorAMap.js把Step2创建的SuperMap专题图叠加到Step1创建的高德地图上
		
```JavaScript
	if(themeEventArgs.result.resourceInfo.id) {
		var canvasTiles =  SuperMap.Web.iConnector.AMap.getLayer(url,{layersID:themeEventArgs.result.resourceInfo.id});
		mapObj.addLayer(canvasTiles);
	}
```

##### 在线演示与源码编辑

在线演示：
http://runjs.cn/detail/pmkuutbr

源码编辑：
http://runjs.cn/code/pmkuutbr


