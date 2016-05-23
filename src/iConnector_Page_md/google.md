# 使用iConnector对接Google地图应用
---
<!-- toc -->
### iConnectorGoogle.js简介

如果您已经使用Google地图的JavaScript API构建了地图应用，您可以通过iConnectorGoogle.js对接SuperMap的GIS服务。例如：在Google地图上叠加通过SuperMap发布的业务数据。

iConnectorGoogle.js主要提供了地图叠加以及Geometry的转换，可以实现：在Google地图上，叠加SuperMap地图服务中的地图、专题图、查询结果，以及空间分析结果。


### 准备开发环境

#### 1. 基于Google地图 JavaScript API的地图应用

您可以使用Google地图的在线JavaScript API，使用方式：

```JavaScript
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
```

#### 2. 准备SuperMap GIS服务

您可以使用来自您的SuperMap iServer服务器的REST GIS服务，就像来自SuperMap技术资源中心的：http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。

您也可以将业务数据托管在SuperMap Online，然后使用发布的地图服务，例如：http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World

如果需要在线GIS服务器，您还可以在SuperMap Online租用GIS云主机，并发布您自己的GIS服务。

#### 3. SuperMap的JavaScript API与iConnectorGoogle.js

```JavaScript
	<script src="http://www.supermapol.com/resources/api/libs/SuperMap.Include.js"></script>
	<script src="http://sandbox.runjs.cn/uploads/rs/3/dofmucai/iConnectorGoogle.js"></script>
```

### 示范程序

#### 示例1：在Google地图上，叠加SuperMap的分段专题图

##### Step1 创建地图窗口并加载Google地图

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

##### Step2 使用SuperMap.Include.js，基于SuperMap REST服务中的"China_Province_R"图层，制作分段专题图

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

##### Step3 使用iConnectorGoogle.js把Step2创建的SuperMap专题图叠加到Step1创建的Google地图上
		
```JavaScript
	if(themeEventArgs.result.resourceInfo.id) {
		map.overlayMapTypes.insertAt(
				0, SuperMap.Web.iConnector.Google.getLayer(url,{layersID:themeEventArgs.result.resourceInfo.id}));
	}
```

##### 在线演示与源码编辑

在线演示：
http://runjs.cn/detail/nk6mvwfi

源码编辑：
http://runjs.cn/code/nk6mvwfi

