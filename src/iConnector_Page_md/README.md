## 认识SuperMap iConnector
---
<!-- toc -->
### iConnector简介

如果：
* 您已经开发了一个GIS应用（如地图应用）
* 因为功能升级，已有的GIS应用不能满足需求，而需要使用SuperMap GIS服务，如专业的地图服务、空间分析服务
* 但是您希望可以重用已有应用的客户端代码（如基于Leaflet JavaScript API开发的应用），而不是从零开始重新开发

遇到上述问题，您可以使用SuperMap提供的连接器工具——SuperMap iConnector（以下简称iConnector）。

iConnector是一款基于SuperMap iClient for JavaScript实现的连接SuperMap GIS服务与第三方JS地图应用的开源工具。通过iConnector，您可以便捷地重用已有的GIS应用代码，并根据需求对接SuperMap iServer所提供的专业GIS服务。

iConnector在GitHub开源：https://github.com/SuperMap/iConnector

SuperMap在线JS库：http://www.supermapol.com/resources/api/libs/SuperMap.Include.js

### iConnector主要功能

#### 功能列表
1. 在基于第三方JavaScript API的地图上，叠加SuperMap iServer提供的地图
2. 在基于第三方JavaScript API的地图上，添加SuperMap专题图
3. 在基于第三方JavaScript API的地图上，叠加SuperMap iServer地图服务的查询结果Geometry
4. 在基于第三方JavaScript API的地图上，叠加SuperMap iServer空间分析服务的分析结果

#### 支持的第三方JavaScript API

* Leaflet
 * [在线JS库](http://cdn.leafletjs.com/leaflet/v0.7.7/leaflet.js)
 * [iConnectorLeaflet.js](http://www.supermapol.com/resources/api/iconnector/iConnectorLeaflet.js)
* Google Maps
 * [在线JS库](https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap)
 * [iConnectorGoogle.js](http://www.supermapol.com/resources/api/iconnector/iConnectorGoogle.js)
* 百度地图
 * [在线JS库](http://api.map.baidu.com/api?v=2.0&ak=您的密钥)
 * [iConnectorBaidu.js](http://www.supermapol.com/resources/api/iconnector/iConnectorBaidu.js)
* 高德地图
 * [在线JS库](http://webapi.amap.com/maps?v=1.3&key=您申请的key值)
 * [iConnectorAMap.js](http://www.supermapol.com/resources/api/iconnector/iConnectorAMap.js)
* 天地图
 * [在线JS库](http://api.tianditu.com/js/maps.js)
 * iConnector对接库：
* ArcGIS
 * [在线JS库](http://serverapi.arcgisonline.com/jsapi/arcgis/3.5/)
 * iConnector对接库：
* CartoDB
 * [在线JS库](http://libs.cartocdn.com/cartodb.js/v3/3.11/cartodb.js)
 * iConnector对接库：
* Mapbox
 * [在线JS库](https://api.mapbox.com/mapbox.js/v2.4.0/mapbox.js)
 * iConnector对接库：
* OpenLayer3
 * [在线JS库](http://openlayers.org/en/v3.15.1/build/ol.js)
 * iConnector对接库：
* Polymaps
 * [在线JS库](http://polymaps.org/polymaps.min.js?2.5.1)
 * iConnector对接库：

### 了解更多

如果您需要使用iConnector：
* 您可以访问 API参考 查看详细的接口说明
* 您可以访问iConnector对接Leaflet、Google Maps、百度地图、高德地图的在线开发指南与示范程序
* 您还可以访问iConnector在GitHub的开源代码：https://github.com/SuperMap/iConnector
