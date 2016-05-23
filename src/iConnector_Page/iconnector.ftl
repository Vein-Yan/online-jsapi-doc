<h2 id="认识supermap-iconnector">认识SuperMap iConnector</h2>
<hr>
<!-- toc -->
<ul class="atoc">
<li><a href="#iconnector%E7%AE%80%E4%BB%8B">iConnector简介</a></li>
<li><a href="#iconnector%E4%B8%BB%E8%A6%81%E5%8A%9F%E8%83%BD">iConnector主要功能</a><ul>
<li><a href="#%E5%8A%9F%E8%83%BD%E5%88%97%E8%A1%A8">功能列表</a></li>
<li><a href="#%E6%94%AF%E6%8C%81%E7%9A%84%E7%AC%AC%E4%B8%89%E6%96%B9javascript-api">支持的第三方JavaScript API</a></li>
</ul>
</li>
<li><a href="#%E4%BA%86%E8%A7%A3%E6%9B%B4%E5%A4%9A">了解更多</a></li>
</ul>
<!-- tocstop -->
<h3 id="iconnector简介">iConnector简介</h3>
<p>如果：</p>
<ul>
<li>您已经开发了一个GIS应用（如地图应用）</li>
<li>因为功能升级，已有的GIS应用不能满足需求，而需要使用SuperMap GIS服务，如专业的地图服务、空间分析服务</li>
<li>但是您希望可以重用已有应用的客户端代码（如基于Leaflet JavaScript API开发的应用），而不是从零开始重新开发</li>
</ul>
<p>遇到上述问题，您可以使用SuperMap提供的连接器工具——SuperMap iConnector（以下简称iConnector）。</p>
<p>iConnector是一款基于SuperMap iClient for JavaScript实现的连接SuperMap GIS服务与第三方JS地图应用的开源工具。通过iConnector，您可以便捷地重用已有的GIS应用代码，并根据需求对接SuperMap iServer所提供的专业GIS服务。</p>
<p>iConnector在GitHub开源：<a href="https://github.com/SuperMap/iConnector" target="_blank">https://github.com/SuperMap/iConnector</a></p>
<p>SuperMap在线JS库：<a href="http://www.supermapol.com/resources/api/libs/SuperMap.Include.js" target="_blank">http://www.supermapol.com/resources/api/libs/SuperMap.Include.js</a></p>
<h3 id="iconnector主要功能">iConnector主要功能</h3>
<h4 id="功能列表">功能列表</h4>
<ol>
<li>在基于第三方JavaScript API的地图上，叠加SuperMap iServer提供的地图</li>
<li>在基于第三方JavaScript API的地图上，添加SuperMap专题图</li>
<li>在基于第三方JavaScript API的地图上，叠加SuperMap iServer地图服务的查询结果Geometry</li>
<li>在基于第三方JavaScript API的地图上，叠加SuperMap iServer空间分析服务的分析结果</li>
</ol>
<h4 id="支持的第三方javascript-api">支持的第三方JavaScript API</h4>
<ul>
<li><p>Leaflet</p>
<ul>
<li>在线JS库：
<a href="http://cdn.leafletjs.com/leaflet/v0.7.7/leaflet.js" target="_blank">http://cdn.leafletjs.com/leaflet/v0.7.7/leaflet.js</a></li>
<li>iConnector对接库：
iConnectorLeaflet.js</li>
</ul>
</li>
<li><p>Google Maps</p>
<ul>
<li>在线JS库：
<a href="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&amp;callback=initMap" target="_blank">https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&amp;callback=initMap</a></li>
<li>iConnector对接库：</li>
</ul>
</li>
<li><p>百度地图</p>
<ul>
<li>在线JS库：
<a href="http://api.map.baidu.com/api?v=2.0&amp;ak=您的密钥" target="_blank">http://api.map.baidu.com/api?v=2.0&amp;ak=您的密钥</a></li>
<li>iConnector对接库：</li>
</ul>
</li>
<li><p>高德地图</p>
<ul>
<li>在线JS库：
<a href="http://webapi.amap.com/maps?v=1.3&amp;key=您申请的key值" target="_blank">http://webapi.amap.com/maps?v=1.3&amp;key=您申请的key值</a></li>
<li>iConnector对接库：</li>
</ul>
</li>
<li><p>天地图</p>
<ul>
<li>在线JS库：
<a href="http://api.tianditu.com/js/maps.js" target="_blank">http://api.tianditu.com/js/maps.js</a></li>
<li>iConnector对接库：</li>
</ul>
</li>
<li><p>ArcGIS</p>
<ul>
<li>在线JS库：
<a href="http://serverapi.arcgisonline.com/jsapi/arcgis/3.5/" target="_blank">http://serverapi.arcgisonline.com/jsapi/arcgis/3.5/</a></li>
<li>iConnector对接库：</li>
</ul>
</li>
<li><p>CartoDB</p>
<ul>
<li>在线JS库：
<a href="http://libs.cartocdn.com/cartodb.js/v3/3.11/cartodb.js" target="_blank">http://libs.cartocdn.com/cartodb.js/v3/3.11/cartodb.js</a></li>
<li>iConnector对接库：</li>
</ul>
</li>
<li><p>Mapbox</p>
<ul>
<li>在线JS库：
<a href="https://api.mapbox.com/mapbox.js/v2.4.0/mapbox.js" target="_blank">https://api.mapbox.com/mapbox.js/v2.4.0/mapbox.js</a></li>
<li>iConnector对接库：</li>
</ul>
</li>
<li><p>OpenLayer3</p>
<ul>
<li>在线JS库：
<a href="http://openlayers.org/en/v3.15.1/build/ol.js" target="_blank">http://openlayers.org/en/v3.15.1/build/ol.js</a></li>
<li>iConnector对接库：</li>
</ul>
</li>
<li><p>Polymaps</p>
<ul>
<li>在线JS库：
<a href="http://polymaps.org/polymaps.min.js?2.5.1" target="_blank">http://polymaps.org/polymaps.min.js?2.5.1</a></li>
<li>iConnector对接库：</li>
</ul>
</li>
</ul>
<h3 id="了解更多">了解更多</h3>
<p>如果您需要使用iConnector：</p>
<ul>
<li>您可以访问 API参考 查看详细的接口说明</li>
<li>您可以访问iConnector对接Leaflet、Google Maps、百度地图、高德地图的在线开发指南与示范程序</li>
<li>您还可以访问iConnector在GitHub的开源代码：<a href="https://github.com/SuperMap/iConnector" target="_blank">https://github.com/SuperMap/iConnector</a></li>
</ul>