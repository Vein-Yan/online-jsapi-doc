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

您可以使用来自您的SuperMap iServer服务器的REST GIS服务，例如来自SuperMap技术资源中心的：http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。

您也可以将业务数据托管在SuperMap Online，然后使用发布的地图服务，例如：http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World

如果需要在线GIS服务器，您还可以在SuperMap Online租用GIS云主机，并发布您自己的GIS服务。

#### 3. SuperMap的JavaScript API

iClient for JavaScript与iConnectorBaidu.js

```JavaScript
	<script src="http://www.supermapol.com/resources/api/libs/SuperMap.Include.js"></script>
	<script src="http://www.supermapol.com/resources/api/iconnector/iConnectorBaidu.js"></script>
```

### 示例1：在百度地图上叠加SuperMap等级符号专题图

**Step1 初始化百度地图**

使用百度地图API创建地图窗口“allmap”，添加基础地图控件如比例尺缩放控件等，并设置加载地图的中心点和比例尺级别，
如：map.centerAndZoom(new BMap.Point(116, 39), 4)。

```JavaScript
    var map = new BMap.Map('allmap');
    map.addControl(new BMap.ScaleControl());
    map.addControl(new BMap.NavigationControl());
    map.enableScrollWheelZoom(true);
    map.centerAndZoom(new BMap.Point(116, 39), 4);
```

**Step2 制作SuperMap等级符号专题图**

使用SuperMap.Include.js，基于SuperMap REST服务中的"China_Province_R"图层，制作等级符号专题图。
		
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

**Step3 转换SuperMap专题图并叠加到百度地图**

使用iConnectorBaidu.js把Step2创建的SuperMap专题图叠加到Step1创建的百度地图上。
		
```JavaScript
	if(themeEventArgs.result.resourceInfo.id) {
		var id =  themeEventArgs.result.resourceInfo.id;
		var tileLayer = SuperMap.Web.iConnector.Baidu.getLayer(url,{layersID:id});

		map.addTileLayer(tileLayer);
	}
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/cac308zy)
* [源码编辑](http://runjs.cn/code/cac308zy)

### 示例2：在百度地图上添加GPS点、线

由于百度地图本身对坐标进行了偏移加密，使用标准WGS84坐标系的GPS点，或由国家测绘局制订的GCJ-02坐标系的GPS点时，需要进行纠偏处理才能叠加到百度地图上。

iConnectorBaidu.js封装了相关的纠偏算法，可以通过transferPoint来调用。

**Step1 初始化百度地图**

设置中心点并添加控件。

```JavaScript
	var map = new BMap.Map("allmap");
	map.centerAndZoom(new BMap.Point(116.404, 39.915), 15);
	map.enableScrollWheelZoom();
```

**Step2 初始化GCJ-02坐标的GPS点**

```JavaScript
var points = [  new BMap.Point(116.3786889372559,39.90762965106183),
				new BMap.Point(116.38632786853032,39.90795884517671),
				new BMap.Point(116.39534009082035,39.907432133833574),
				new BMap.Point(116.40624058825688,39.90789300648029),
				new BMap.Point(116.41413701159672,39.90795884517671),
				new BMap.Point(116.42413701159672,39.90795884517671),
				new BMap.Point(116.43413701159672,39.90795884517671),
				new BMap.Point(116.44413701159672,39.90795884517671),
				new BMap.Point(116.45413701159672,39.90795884517671),
				new BMap.Point(116.46413701159672,39.90795884517671),
				new BMap.Point(116.47413701159672,39.90795884517671),
				new BMap.Point(116.48413701159672,39.90795884517671),
				new BMap.Point(116.49413701159672,39.90795884517671),
				new BMap.Point(116.50413701159672,39.90795884517671),
				new BMap.Point(116.51413701159672,39.90795884517671),
				new BMap.Point(116.52413701159672,39.90795884517671),
				new BMap.Point(116.53413701159672,39.90795884517671),
				new BMap.Point(116.54413701159672,39.90795884517671),
				new BMap.Point(116.55413701159672,39.90795884517671),
				new BMap.Point(116.56413701159672,39.90795884517671),
				new BMap.Point(116.57413701159672,39.90795884517671),
				new BMap.Point(116.58413701159672,39.90795884517671)
			 ];
```

**Step3 对点进行坐标纠偏**

通过iConnectorBaidu.js，把GPS点的坐标转为百度坐标系下的坐标值。

```JavaScript
setTimeout(function(){
	SuperMap.Web.iConnector.Baidu.transferPoint(points,new SuperMap.Projection("EPSG:4326"),acallback,2); //进行坐标转换。参数2，表示是从GCJ-02坐标到百度坐标。
}, 1000);  //一秒之后开始执行
```

其中，new SuperMap.Projection("EPSG:4326")，是指在转换前先将GPS的坐标纠正为标准WGS84坐标，参数“2”标识了转换的原坐标。transferPoint支持以下两种坐标转换到百度坐标：
* 2代表国家测绘局制订的GCJ-02，Google Maps、高德地图、腾讯地图使用
* 0代表标准的WGS84坐标

**Step4 在百度地图上把转换后的点标注**

```JavaScript
	var points = []
			for(var index in xyResults){
				var point = xyResults[index];
				points.push(point);
				var marker = new BMap.Marker(point);
				map.addOverlay(marker);
			}
```

**Step5 把转换后点连接成线并添加到百度地图**

为添加的线设置颜色、宽度、透明度等样式。

```JavaScript
	var line =new BMap.Polyline(points, {strokeColor:"blue", strokeWeight:6, strokeOpacity:0.5});
	map.addOverlay(line);
}
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/fluk7vgx)
* [源码编辑](http://runjs.cn/code/fluk7vgx)

### 示例3 在百度地图上添加GPS面

与示例2在百度地图上添加GPS点和线类似，本例将在百度地图上添加纠偏后的GPS面。

**Step1 初始化百度地图**

```JavaScript
    var map = new BMap.Map("allmap");
    map.centerAndZoom(new BMap.Point(116.387, 39.907), 15);
```

**Step2 创建由创建GCJ-02坐标的GPS点组成的面**

```JavaScript
    var points = [new BMap.Point(116.3786889372559,39.90762965106183),
        new BMap.Point(116.38632786853032,39.90795884517671),
        new BMap.Point(116.38534009082035,39.897432133833574),
        new BMap.Point(116.37624058825688,39.89789300648029)

    ];
    var polygon = new BMap.Polygon(points);
```

**Step3 把GPS面纠偏为百度坐标系**

通过iConnectorBaidu.js，把GPS面的坐标转为百度坐标系下的坐标值。

```JavaScript
    setTimeout(function(){
        SuperMap.Web.iConnector.Baidu.transferPolygon([polygon],new SuperMap.Projection("EPSG:4326"),acallback,2);  //进行坐标转换。参数2，表示是从GCJ-02坐标到百度坐标。
    }, 1000);  //一秒之后开始执行
```

**Step4 把转换后的GPS面添加到百地图上**

```JavaScript
    function acallback(polygons){
        map.addOverlay(polygons[0]);
    }
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/73c8aqk1)
* [源码编辑](http://runjs.cn/code/73c8aqk1)

### 示例4 在百度地图上添加SuperMap距离查询结果点

同样因为百度地图的坐标偏移，在百度地图上叠加SuperMap几何对象时，也需要进行纠偏处理。
本例将把SuperMap距离查询结果（点），转换坐标后叠加在百度地图上

**Step1 初始化百度地图**

```JavaScript
	//地图初始化
	var map = new BMap.Map("allmap");  //创建百度地图
	var center = new BMap.Point(116.404, 32);
	map.centerAndZoom(center,4);                     // 初始化地图,设置中心点坐标和地图级别。
	map.enableScrollWheelZoom();  //设置可以使用滚轮控制地图放大缩小
```

**Step2 初始化用于距离查询的点**

```JavaScript
	var point = new BMap.Point(116.404, 39.915);    // 创建点坐标
	var iconself = new BMap.Icon('http://sandbox.runjs.cn/uploads/rs/3/dofmucai/marker.png',new BMap.Size(35,30));
	var marker = new BMap.Marker(point,{
	   icon:iconself
	});
	marker.disableMassClear();
	map.addOverlay(marker); 
```

**Step3 执行SuperMap距离查询**

通过iClient for JavaScript API调用SuperMap REST 地图服务进行距离查询。

```JavaScript
	var url="http://support.supermap.com.cn:8090/iserver/services/map-world/rest/maps/World"; 
	var centerPoint = new SuperMap.Geometry.Point(116.404, 39.915);//构造一个点的几何图形
	var queryByDistanceParams = new SuperMap.REST.QueryByDistanceParameters({
		queryParams: new Array(new SuperMap.REST.FilterParameter({name: "Capitals@World.1"})),//设置数据源及参数
		returnContent: true,
		distance: 30,
		geometry:centerPoint
	});
	var queryByDistanceService = new SuperMap.REST.QueryByDistanceService(url);//距离查询服务
	  queryByDistanceService.events.on({
		"processCompleted": bufferCompleted,
		"processFailed":bufferFailed
	 });
	queryByDistanceService.processAsync(queryByDistanceParams); //发送请求
```

**Step4 对查询结果点进行纠偏处理**

把查询结果放入数据，并通过iConnectorBaidu.js转为百度支持的点坐标。

```JavaScript
	var i, j, result = queryEventArgs.result;
	var points = [];  //新建一个数组
	for(i = 0;i < result.recordsets.length; i++) {
		for(j = 0; j < result.recordsets[i].features.length; j++)
		{
			 var point = result.recordsets[i].features[j].geometry,
			 size = new SuperMap.Size(44, 33),
			 offset = new SuperMap.Pixel(-(size.w/2), -size.h),
			 icon = new SuperMap.Icon("marker.png", size, offset);
			 points.push(point);  //将距离查询后的点都放入数组
		}
	}
	SuperMap.Web.iConnector.Baidu.transferPoint(points,new SuperMap.Projection("EPSG:4326"),acallback,2);//将supermap的点转换为百度的点
```

**Step5 在百度地图上标注纠偏后的查询结果**

```JavaScript
	function acallback(xyResults){//BMap.Point对象的数组（xyResults），接收转换的点
		var points = []
		for(var index in xyResults){
			var point = xyResults[index];
			points.push(point);
			var marker1 = new BMap.Marker(point);
			map.addOverlay(marker1);
			
		}
	}
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/tla28w74)
* [源码编辑](http://runjs.cn/code/tla28w74)

### 示例5 在百度地图上添加SuperMap SQL查询的线

本例将把SuperMap SQL查询的结果线对象，纠偏后叠加在百度地图上。

**Step1 初始化百度地图**

```JavaScript
	//地图初始化
    var map = new BMap.Map("allmap");            // 创建Map实例
    var point = new BMap.Point(116.404, 32);    // 创建点坐标
    map.centerAndZoom(point,5);                     // 初始化地图,设置中心点坐标和地图级别。
    map.enableScrollWheelZoom();                            //启用滚轮放大缩小
```

**Step2 执行SuperMap SQL查询**

通过iClient for JavaScript API调用SuperMap REST 地图服务进行SQL查询，本例将在Rivers@World图层中查询SMID为66的要素。
完成查询后，返回查询结果几何对象。

```JavaScript
	var url="http://support.supermap.com.cn:8090/iserver/services/map-world/rest/maps/World";
    function queryBySQL() {

        var queryParam, queryBySQLParams, queryBySQLService;
        queryParam = new SuperMap.REST.FilterParameter({
            name: "Rivers@World",
            attributeFilter: "SMID=66"
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
                        var line = feature.geometry;
                        getPoints(line);
                    }
                }
            }
        }
    }
```

**Step3 通过iConnectorBaidu.js纠偏**

通过transferLine可以把SuperMap线几何对象转为相应的百度坐标值。

```JavaScript
        if(geometry.CLASS_NAME === 'SuperMap.Geometry.MultiPolygon' ||
            geometry.CLASS_NAME === 'SuperMap.Geometry.MultiLineString' ||
            geometry.CLASS_NAME === 'SuperMap.Geometry.MultiPoint'){
            for(var i = 0,len = geometry.components.length;i<len;i++){
                getPoints(geometry.components[i]);
            }
            return;
        }
        SuperMap.Web.iConnector.Baidu.transferLine([geometry],new SuperMap.Projection("EPSG:4326"),translateCallback);
```

**Step4 把纠偏后的SuperMap线加载到百度地图上**

```JavaScript
	map.addOverlay(polyline[0]);
```

**在线演示与源码编辑**

您可以在线访问完整代码、体验演示效果，也可以直接在线编辑源码并实时查看效果。

* [在线演示](http://runjs.cn/detail/irwxvxzm)
* [源码编辑](http://runjs.cn/code/irwxvxzm)

此外，SuperMap面对像的纠偏和叠加方式与点、线类似，本文将不再详细介绍，示范程序请参考：

* [在线演示](http://runjs.cn/detail/6jpdxgxk)
* [源码编辑](http://runjs.cn/code/6jpdxgxk)
