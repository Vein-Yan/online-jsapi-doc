### SuperMap iClient for JavaScript简介
---
### 产品介绍

SuperMap iClient for JavaScript 是一款使用JavaScript编写的浏览器端的地图应用开发SDK，是在服务式GIS架构体系中， 面向HTML5的应用开发，支持多终端、跨浏览器的客户端开发平台。 其有如下特点：
- 灵活的交互设计与丰富的数据呈现方式，基于 HTML 5 用于绘画的新元素 Canvas 实现了地图图片的高效、稳定呈现；
- 支持多终端跨浏览器访问，以及多源地图数据，包括OGC的标准服务、SuperMap iServer地图服务、超图云地图服务以及主流的互联网地图——百度地图、谷歌地图和天地图；
- 支持原生安卓应用的开发，基于 PhoneGap 开源开发框架实现地图离线缓存的插 件化,可将已有的地图应用直接打包生成支持 Android 的应用程序，满足用户在离线状态下的地图应用；
- 支持大数据量交互、渲染、可视化，UTFGrid图层为大数据量交互效果问题提供了解决方案，麻点图为大数据量渲染提供了解决方案；
- 支持丰富的可视化效果，包括矢量瓦片客户端配图、客户端生成专题图，以及动态的时空数据的展示。

SuperMap在线JS库：http://www.supermapol.com/resources/api/libs/SuperMap.Include.js

SuperMap iClient for JavaScript开源地址：https://github.com/SuperMap/iClient-for-JavaScript

### 主要功能

#### 地图服务
SuperMap iClient for JavaScript支持多种地图服务的添加，包括：
- SuperMap云服务地图
- SuperMap iServer分块缓存地图
- SuperMap iServer分块动态地图
- 矢量要素图层（渲染器支持VML、SVG、Canvas和Canvas2四种）
- 标注图层（Marker）
- Elements图层（将html的element元素叠加到地图上）
- 聚合图层
- 热点格网图层
- 热点渲染图层
- 前端专题图层（包括标签专题图、单值专题图、分段专题图和统计专题图）
- 前端矢量分块渲染图层（可使用CartoCSS修改地图样式）
- UTFGrid图层（用于快速响应交互并提供属性信息的图层）
- OGC服务图层（WMS、WMTS等）
- 时空数据图层（实现地图上的动态效果）

##### 地图交互
除了基本的地图交互操作——地图缩放、漫游，以及图层控制之外，还提供了以下的交互操作：
- 鹰眼操作
- 比例尺显示
- 矢量要素的绘制、编辑、选择和拖拽操作
- 麻点图选择操作
- UTFGrid图层交互
- 卷帘操作
- 定位
- 聚合选择操作
- 鼠标位置显示
- 地图版权信息显示

##### 量算功能
- 距离量算
- 面积量算

#### 数据服务

##### 数据编辑
- 增加、删除、修改要素

##### 数据查询
- 距离查询
- 几何对象查询
- SQL查询
- 范围查询
- WFS查询

#### GIS分析服务
SuperMap iClient for JavaScript提供了一套简单易用的API，供用户调用由SuperMap iServer发布出来的分析服务，并在地图上展示。SuperMap iClient for JavaScript提供了绝大部分的GIS功能，包括量算功能、数据查询功能、空间分析功能、交通网络分析功能和交通换乘功能。

##### 空间分析
- 缓冲区分析
- 叠加分析
- 表面分析
- 动态分析
- 空间关系分析
- 点密度插值分析
- 克吕金插值分析
- 离散点插值分析
- 反距离加权插值分析
- 点定里程
- 里程定点
- 里程定线
- 地形曲率分析
- 栅格代数
- 核密度分析

##### 网络分析
- 最近设施分析
- 最佳路径分析
- 服务区分析
- 选址分析
- 旅行商分析
- 多旅行商分析
- 耗费矩阵分析

##### 交通换乘分析
- 公交换乘

更多内容请访问[SuperMap iClient for JavaScript类参考](http://www.supermapol.com/developer/jsapi.html#jsapi)和[SuperMap iClient for JavaScript示例](http://www.supermapol.com/developer/jsapi.html#examples)
