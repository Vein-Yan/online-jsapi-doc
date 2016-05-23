# 使用iConnector对接百度地图应用
---
<!-- toc -->
### iConnectorBaidu.js简介

如果您已经使用百度地图的JavaScript API构建了地图应用，您可以通过iConnectorBaidu.js对接SuperMap的GIS服务。例如：在百度地图上叠加通过SuperMap发布的业务数据。

iConnectorBaidu.js主要提供了地图叠加以及Geometry的转换，可以实现：在百度地图上，叠加SuperMap地图服务中的地图、专题图、查询结果，以及空间分析结果。


### 准备开发环境

#### 1. 基于百度地图 JavaScript API的地图应用

您可以使用百度地图的在线JavaScript API，使用方式：

```JavaScript
	<script src="http://api.map.baidu.com/api?v=2.0&ak=您的密钥"></script>
```

#### 2. 准备SuperMap GIS服务

您可以使用来自您的SuperMap iServer服务器的REST GIS服务，就像来自SuperMap技术资源中心的：http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。

您也可以将业务数据托管在SuperMap Online，然后使用发布的地图服务，例如：http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World

如果需要在线GIS服务器，您还可以在SuperMap Online租用GIS云主机，并发布您自己的GIS服务。

#### 3. SuperMap的JavaScript API与iConnectorBaidu.js

```JavaScript
	<script src="http://www.supermapol.com/resources/api/libs/SuperMap.Include.js"></script>
	<script src="http://sandbox.runjs.cn/uploads/rs/3/dofmucai/iConnectorBaidu.js"></script>
```

### 示范程序

#### 示例1：在百度地图上，叠加SuperMap的等级符号专题图

##### Step1 创建地图窗口并加载百度地图

使用百度地图API创建地图窗口“allmap”，添加基础地图控件如比例尺缩放控件等，并设置加载地图的中心点和比例尺级别，
如：map.centerAndZoom(new BMap.Point(116, 39), 4)。

```JavaScript
    var map = new BMap.Map('allmap');
    map.addControl(new BMap.ScaleControl());
    map.addControl(new BMap.NavigationControl());
    map.enableScrollWheelZoom(true);
    map.centerAndZoom(new BMap.Point(116, 39), 4);
```

##### Step2 使用SuperMap.Include.js，基于SuperMap REST服务中的"China_Province_R"图层，制作等级符号专题图
		
```JavaScript
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

##### Step3 使用iConnectorBaidu.js把Step2创建的SuperMap专题图叠加到Step1创建的百度地图上
		
```JavaScript
	if(themeEventArgs.result.resourceInfo.id) {
		var id =  themeEventArgs.result.resourceInfo.id;
		var tileLayer = SuperMap.Web.iConnector.Baidu.getLayer(url,{layersID:id});

		map.addTileLayer(tileLayer);
	}
```

##### 在线演示与源码编辑

在线演示：
http://runjs.cn/detail/cac308zy

源码编辑：
http://runjs.cn/code/cac308zy

