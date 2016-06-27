#### JavaScript API 简介
---
基础云平台在线 JavaScript API，是一套由 JavaScript 语言编写的 云GIS应用程序接口。 支持多种数据与地图来源，支持多终端，跨浏览器的地图应用开发，可帮助您在网站中构建功能丰富、交互性强的地图应用，快速实现浏览器上美观、流畅的地图呈现。

SuperMap 在线 JavaScript API 包含 iClient for JavaScript 和 iConnector 两个部分。

#### SuperMap iClient for JavaScript

是一套基于 JavaScript 语言编写的 GIS 客户端应用开发包，支持多源数据地图，支持多终端，跨浏览器，可快速实现浏览器上美观、流畅的地图呈现。

#### SuperMap iConnector

是一款连接SuperMap GIS服务与第三方JS地图应用的开源工具。通过iConnector，您可以便捷地重用已有的GIS应用代码，并根据需求对接SuperMap的专业REST GIS服务。

#### 开发授权（申请key）

如果需要使用SuperMap Online的在线服务、API等资源进行在线Web开发，您需要先申请密钥key。key是服务的口令标识，由24位随机字母+数字组成，是一种在线服务的保护机制。

开发授权可用于两类服务：

* 基础GIS服务，每个key的使用限额：免费5000次请求/天。

SuperMap Online提供了基础GIS服务，如路径导航、地理编码、公交换乘等，面向开发者免费使用。只要申请了key，您就可以直接访问使用这些GIS服务。

* 用户上传数据后发布的REST地图服务，每个key的限额：免费5000次请求/天（请求一张瓦片即为一次请求）。

也就是说，您上传的数据可以发布为REST地图服务，但开发时并不能直接使用服务。您需要在开发应用前，对您的服务生成key，然后通过key使用服务。因为没有key就不能使用您的地图服务，所以开发授权机制可在访问层面保证您的地图服务的安全性。

更多详细内容请访问：[开发授权详解](http://blog.supermapol.com/GettingStarted/key.html)。