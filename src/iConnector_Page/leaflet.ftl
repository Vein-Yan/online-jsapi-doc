<h1 id="使用iconnector对接leaflet地图应用">使用iConnector对接Leaflet地图应用</h1>
<hr>
<!-- toc -->
<ul class="atoc">
<li><a href="#iconnectorleafletjs%E7%AE%80%E4%BB%8B">iConnectorLeaflet.js简介</a></li>
<li><a href="#%E5%87%86%E5%A4%87%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83">准备开发环境</a><ul>
<li><a href="#1-%E5%9F%BA%E4%BA%8Eleaflet-api%E7%9A%84%E5%9C%B0%E5%9B%BE%E5%BA%94%E7%94%A8">1. 基于Leaflet API的地图应用</a></li>
<li><a href="#2-%E5%87%86%E5%A4%87supermap-gis%E6%9C%8D%E5%8A%A1">2. 准备SuperMap GIS服务</a></li>
<li><a href="#3-supermap%E7%9A%84javascript-api%E4%B8%8Eiconnectorleafletjs">3. SuperMap的JavaScript API与iConnectorLeaflet.js</a></li>
</ul>
</li>
<li><a href="#%E7%A4%BA%E8%8C%83%E7%A8%8B%E5%BA%8F">示范程序</a><ul>
<li><a href="#%E7%A4%BA%E4%BE%8B1%EF%BC%9A%E4%BD%BF%E7%94%A8leaflet%E7%9A%84api%EF%BC%8C%E5%8A%A0%E8%BD%BD%E6%9D%A5%E8%87%AAsupermap%E7%9A%84%E5%9C%B0%E5%9B%BE">示例1：使用Leaflet的API，加载来自SuperMap的地图</a><ul>
<li><a href="#step1-%E4%BD%BF%E7%94%A8leaflet-api%E5%88%9B%E5%BB%BA%E5%9C%B0%E5%9B%BE%E7%AA%97%E5%8F%A3">Step1 使用Leaflet API创建地图窗口</a></li>
<li><a href="#step2-%E4%BD%BF%E7%94%A8iconnectorleafletjs%E5%8A%A0%E8%BD%BDsupermap%E5%9C%B0%E5%9B%BE%E6%9C%8D%E5%8A%A1%E4%B8%AD%E7%9A%84%E5%9C%B0%E5%9B%BE">Step2 使用iConnectorLeaflet.js加载SuperMap地图服务中的地图</a></li>
<li><a href="#%E5%9C%A8%E7%BA%BF%E6%BC%94%E7%A4%BA%E4%B8%8E%E6%BA%90%E7%A0%81%E7%BC%96%E8%BE%91">在线演示与源码编辑</a></li>
</ul>
</li>
<li><a href="#%E7%A4%BA%E4%BE%8B2%EF%BC%9A%E4%BD%BF%E7%94%A8leaflet%E7%9A%84api%EF%BC%8C%E5%9C%A8openstreetmap%E4%B8%8A%E5%8F%A0%E5%8A%A0supermap%E7%9A%84%E5%9C%B0%E5%9B%BE">示例2：使用Leaflet的API，在OpenStreetMap上叠加SuperMap的地图</a><ul>
<li><a href="#step1-%E4%BD%BF%E7%94%A8leaflet-api%E5%88%9B%E5%BB%BA%E5%9C%B0%E5%9B%BE%E7%AA%97%E5%8F%A3">Step1 使用Leaflet API创建地图窗口</a></li>
<li><a href="#step2-%E4%BD%BF%E7%94%A8leaflet-api%E5%8A%A0%E8%BD%BDopenstreetmap">Step2 使用Leaflet API加载OpenStreetMap</a></li>
<li><a href="#step3-%E4%BD%BF%E7%94%A8iconnectorleafletjs%E5%8F%A0%E5%8A%A0supermap%E5%9C%B0%E5%9B%BE">Step3 使用iConnectorLeaflet.js叠加SuperMap地图</a></li>
<li><a href="#%E5%9C%A8%E7%BA%BF%E6%BC%94%E7%A4%BA%E4%B8%8E%E6%BA%90%E7%A0%81%E7%BC%96%E8%BE%91">在线演示与源码编辑</a></li>
</ul>
</li>
</ul>
</li>
</ul>
<!-- tocstop -->
<h3 id="iconnectorleafletjs简介">iConnectorLeaflet.js简介</h3>
<p>如果您已经使用Leaflet构建了地图应用，您可以通过iConnectorLeaflet.js对接SuperMap的GIS服务。例如：在Leaflet构建的在线地图上叠加SuperMap的缓冲区分析结果。</p>
<p>iConnectorLeaflet.js主要提供了地图叠加以及Geometry的转换，可以实现：在使用Leaflet的API出的地图上，叠加SuperMap地图服务中的地图、专题图、查询结果，以及空间分析结果。</p>
<h3 id="准备开发环境">准备开发环境</h3>
<h4 id="1-基于leaflet-api的地图应用">1. 基于Leaflet API的地图应用</h4>
<p>您可使用下载在本地的API，或在线API：</p>
<pre><code class="lang-JavaScript">    &lt;script src=<span class="hljs-string">"http://cdn.leafletjs.com/leaflet/v0.7.7/leaflet.js"</span>&gt;<span class="xml"><span class="hljs-tag">&lt;/<span class="hljs-title">script</span>&gt;</span>
</span></code></pre>
<h4 id="2-准备supermap-gis服务">2. 准备SuperMap GIS服务</h4>
<p>您可以使用来自您的SuperMap iServer服务器的REST GIS服务，就像来自SuperMap技术资源中心的：<a href="http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。" target="_blank">http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。</a></p>
<p>您也可以将数据托管在SuperMap Online，使用发布的地图服务，例如：<a href="http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World" target="_blank">http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World</a></p>
<p>如果需要在线GIS服务器，您还可以在SuperMap Online租用GIS云主机，并发布您自己的GIS服务。</p>
<h4 id="3-supermap的javascript-api与iconnectorleafletjs">3. SuperMap的JavaScript API与iConnectorLeaflet.js</h4>
<pre><code class="lang-JavaScript">    &lt;script src=<span class="hljs-string">"http://www.supermapol.com/resources/api/libs/SuperMap.Include.js"</span>&gt;<span class="xml"><span class="hljs-tag">&lt;/<span class="hljs-title">script</span>&gt;</span>
    <span class="hljs-tag">&lt;<span class="hljs-title">script</span> <span class="hljs-attribute">src</span>=<span class="hljs-value">"http://sandbox.runjs.cn/uploads/rs/3/dofmucai/iConnectorLeaflet.js"</span>&gt;</span><span class="undefined"></span><span class="hljs-tag">&lt;/<span class="hljs-title">script</span>&gt;</span>
</span></code></pre>
<h3 id="示范程序">示范程序</h3>
<h4 id="示例1：使用leaflet的api，加载来自supermap的地图">示例1：使用Leaflet的API，加载来自SuperMap的地图</h4>
<h5 id="step1-使用leaflet-api创建地图窗口">Step1 使用Leaflet API创建地图窗口</h5>
<p>使用Leaflet的map模块API创建地图窗口“map”，如：map = L.map('map').setView([38, 115], 5)。其中，.setView([38, 115], 5)指定了地图的中心点和比例尺级别。
需要指出的是，虽然本例使用的地图本身的坐标系是EPSG Code为3857的WebMercator，但是Leaflet API设置中心点的参数格式为：[<number> latitude, <number> longitude,]，而不是地图本身的单位。</number></number></p>
<pre><code class="lang-JavaScript">    map = L.map(<span class="hljs-string">'map'</span>).setView([<span class="hljs-number">38</span>, <span class="hljs-number">115</span>], <span class="hljs-number">5</span>);
</code></pre>
<h5 id="step2-使用iconnectorleafletjs加载supermap地图服务中的地图">Step2 使用iConnectorLeaflet.js加载SuperMap地图服务中的地图</h5>
<p>SuperMap.Web.iConnector.Leaflet.getLayer创建图层，并使用来自SuperMap的地图。</p>
<pre><code class="lang-JavaScript">    <span class="hljs-keyword">var</span> map,url = <span class="hljs-string">"http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China"</span>;
        <span class="hljs-function"><span class="hljs-keyword">function</span> <span class="hljs-title">init</span>(<span class="hljs-params"></span>)
        </span>{

            <span class="hljs-keyword">var</span> canvasTiles =  SuperMap.Web.iConnector.Leaflet.getLayer(url);
            canvasTiles.addTo(map);
        }
</code></pre>
<h5 id="在线演示与源码编辑">在线演示与源码编辑</h5>
<ul>
<li><a href="http://runjs.cn/detail/cy9rirrf" target="_blank">在线演示</a></li>
<li><a href="http://runjs.cn/code/cy9rirrf" target="_blank">源码编辑</a></li>
</ul>
<h4 id="示例2：使用leaflet的api，在openstreetmap上叠加supermap的地图">示例2：使用Leaflet的API，在OpenStreetMap上叠加SuperMap的地图</h4>
<h5 id="step1-使用leaflet-api创建地图窗口">Step1 使用Leaflet API创建地图窗口</h5>
<pre><code>    map = L.map('map').setView([38, 115], 5);
</code></pre><h5 id="step2-使用leaflet-api加载openstreetmap">Step2 使用Leaflet API加载OpenStreetMap</h5>
<pre><code class="lang-JavaScript">    L.tileLayer(<span class="hljs-string">'http://{s}.tile.osm.org/{z}/{x}/{y}.png'</span>, {
        attribution: <span class="hljs-string">'Map data &amp;copy; &lt;a href="http://openstreetmap.org"&gt;OpenStreetMap&lt;/a&gt; contributors, &lt;a href="http://creativecommons.org/licenses/by-sa/2.0/"&gt;CC-BY-SA&lt;/a&gt;, Imagery © &lt;a href="http://cloudmade.com"&gt;CloudMade&lt;/a&gt;'</span>,
        maxZoom: <span class="hljs-number">18</span>
    }).addTo(map);
</code></pre>
<h5 id="step3-使用iconnectorleafletjs叠加supermap地图">Step3 使用iConnectorLeaflet.js叠加SuperMap地图</h5>
<pre><code class="lang-JavaScript">    <span class="hljs-keyword">var</span> canvasTiles =  SuperMap.Web.iConnector.Leaflet.getLayer(url);
    canvasTiles.addTo(map);
</code></pre>
<h5 id="在线演示与源码编辑">在线演示与源码编辑</h5>
<ul>
<li><a href="http://runjs.cn/detail/bniri8f6" target="_blank">在线演示</a></li>
<li><a href="http://runjs.cn/code/bniri8f6" target="_blank">源码编辑</a></li>
</ul>