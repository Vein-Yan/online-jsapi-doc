<h1 id="使用iconnector对接高德地图">使用iConnector对接高德地图</h1>
<hr>
<!-- toc -->
<ul class="atoc">
<li><a href="#iconnectoramapjs%E7%AE%80%E4%BB%8B">iConnectorAMap.js简介</a></li>
<li><a href="#%E5%87%86%E5%A4%87%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83">准备开发环境</a><ul>
<li><a href="#1-%E5%9F%BA%E4%BA%8E%E9%AB%98%E5%BE%B7%E5%9C%B0%E5%9B%BE-javascript-api%E7%9A%84%E5%9C%B0%E5%9B%BE%E5%BA%94%E7%94%A8">1. 基于高德地图 JavaScript API的地图应用</a></li>
<li><a href="#2-%E5%87%86%E5%A4%87supermap-gis%E6%9C%8D%E5%8A%A1">2. 准备SuperMap GIS服务</a></li>
<li><a href="#3-supermap%E7%9A%84javascript-api%E4%B8%8Eiconnectoramapjs">3. SuperMap的JavaScript API与iConnectorAMap.js</a></li>
</ul>
</li>
<li><a href="#%E7%A4%BA%E8%8C%83%E7%A8%8B%E5%BA%8F">示范程序</a><ul>
<li><a href="#%E7%A4%BA%E4%BE%8B1%EF%BC%9A%E5%9C%A8%E9%AB%98%E5%BE%B7%E5%9C%B0%E5%9B%BE%E4%B8%8A%EF%BC%8C%E5%8F%A0%E5%8A%A0supermap%E7%9A%84%E7%82%B9%E5%AF%86%E5%BA%A6%E4%B8%93%E9%A2%98%E5%9B%BE">示例1：在高德地图上，叠加SuperMap的点密度专题图</a><ul>
<li><a href="#step1-%E5%88%9B%E5%BB%BA%E5%9C%B0%E5%9B%BE%E7%AA%97%E5%8F%A3%E5%B9%B6%E5%8A%A0%E8%BD%BD%E9%AB%98%E5%BE%B7%E5%9C%B0%E5%9B%BE">Step1 创建地图窗口并加载高德地图</a></li>
<li><a href="#step2-%E4%BD%BF%E7%94%A8supermapincludejs%EF%BC%8C%E5%9F%BA%E4%BA%8Esupermap-rest%E6%9C%8D%E5%8A%A1%E4%B8%AD%E7%9A%84chinaprovincer%E5%9B%BE%E5%B1%82%EF%BC%8C%E5%88%B6%E4%BD%9C%E7%82%B9%E5%AF%86%E5%BA%A6%E4%B8%93%E9%A2%98%E5%9B%BE">Step2 使用SuperMap.Include.js，基于SuperMap REST服务中的"China_Province_R"图层，制作点密度专题图</a></li>
<li><a href="#step3-%E4%BD%BF%E7%94%A8iconnectoramapjs%E6%8A%8Astep2%E5%88%9B%E5%BB%BA%E7%9A%84supermap%E4%B8%93%E9%A2%98%E5%9B%BE%E5%8F%A0%E5%8A%A0%E5%88%B0step1%E5%88%9B%E5%BB%BA%E7%9A%84%E9%AB%98%E5%BE%B7%E5%9C%B0%E5%9B%BE%E4%B8%8A">Step3 使用iConnectorAMap.js把Step2创建的SuperMap专题图叠加到Step1创建的高德地图上</a></li>
<li><a href="#%E5%9C%A8%E7%BA%BF%E6%BC%94%E7%A4%BA%E4%B8%8E%E6%BA%90%E7%A0%81%E7%BC%96%E8%BE%91">在线演示与源码编辑</a></li>
</ul>
</li>
</ul>
</li>
</ul>
<!-- tocstop -->
<h3 id="iconnectoramapjs简介">iConnectorAMap.js简介</h3>
<p>如果您已经使用高德地图的JavaScript API构建了地图应用，您可以通过iConnectorAMap.js对接SuperMap的GIS服务。例如：在高德地图上叠加通过SuperMap发布的业务数据。</p>
<p>iConnectorAMap.js主要提供了地图叠加以及Geometry的转换，可以实现：在高德地图上，叠加SuperMap地图服务中的地图、专题图、查询结果，以及空间分析结果。</p>
<h3 id="准备开发环境">准备开发环境</h3>
<h4 id="1-基于高德地图-javascript-api的地图应用">1. 基于高德地图 JavaScript API的地图应用</h4>
<p>您可以使用高德地图的在线JavaScript API，使用方式：</p>
<pre><code class="lang-JavaScript">    &lt;script src=<span class="hljs-string">"http://webapi.amap.com/maps?v=1.2&amp;key=14bf161ae4e52fe25a972f6b7c9c0980"</span>&gt;<span class="xml"><span class="hljs-tag">&lt;/<span class="hljs-title">script</span>&gt;</span>
</span></code></pre>
<h4 id="2-准备supermap-gis服务">2. 准备SuperMap GIS服务</h4>
<p>您可以使用来自您的SuperMap iServer服务器的REST GIS服务，就像来自SuperMap技术资源中心的：<a href="http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。" target="_blank">http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。</a></p>
<p>您也可以将业务数据托管在SuperMap Online，然后使用发布的地图服务，例如：<a href="http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World" target="_blank">http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World</a></p>
<p>如果需要在线GIS服务器，您还可以在SuperMap Online租用GIS云主机，并发布您自己的GIS服务。</p>
<h4 id="3-supermap的javascript-api与iconnectoramapjs">3. SuperMap的JavaScript API与iConnectorAMap.js</h4>
<pre><code class="lang-JavaScript">    &lt;script src=<span class="hljs-string">"http://www.supermapol.com/resources/api/libs/SuperMap.Include.js"</span>&gt;<span class="xml"><span class="hljs-tag">&lt;/<span class="hljs-title">script</span>&gt;</span>
    <span class="hljs-tag">&lt;<span class="hljs-title">script</span> <span class="hljs-attribute">src</span>=<span class="hljs-value">"http://sandbox.runjs.cn/uploads/rs/3/dofmucai/iConnectorAMap.js"</span>&gt;</span><span class="undefined"></span><span class="hljs-tag">&lt;/<span class="hljs-title">script</span>&gt;</span>
</span></code></pre>
<h3 id="示范程序">示范程序</h3>
<h4 id="示例1：在高德地图上，叠加supermap的点密度专题图">示例1：在高德地图上，叠加SuperMap的点密度专题图</h4>
<h5 id="step1-创建地图窗口并加载高德地图">Step1 创建地图窗口并加载高德地图</h5>
<p>使用高德地图API创建地图窗口“map”，设置加载地图的中心点和比例尺、缩放级别、坐标系等。</p>
<pre><code class="lang-JavaScript">    <span class="hljs-keyword">var</span> opt = {
        center: <span class="hljs-keyword">new</span> AMap.LngLat(<span class="hljs-number">115</span>, <span class="hljs-number">35</span>),<span class="hljs-comment">//设置地图中心点</span>
        level: <span class="hljs-number">3</span>,<span class="hljs-comment">//初始地图缩放级别</span>
        zooms:[<span class="hljs-number">3</span>,<span class="hljs-number">6</span>],<span class="hljs-comment">//地图缩放级别范围</span>
        crs:<span class="hljs-string">"'EPSG4326"</span>
    };
    mapObj = <span class="hljs-keyword">new</span> AMap.Map(<span class="hljs-string">"map"</span>,opt);
</code></pre>
<h5 id="step2-使用supermapincludejs，基于supermap-rest服务中的chinaprovincer图层，制作点密度专题图">Step2 使用SuperMap.Include.js，基于SuperMap REST服务中的"China_Province_R"图层，制作点密度专题图</h5>
<pre><code class="lang-JavaScript">    <span class="hljs-comment">//创建制作点密度专题图服务类</span>
    <span class="hljs-keyword">var</span> themeService = <span class="hljs-keyword">new</span> SuperMap.REST.ThemeService(url, {eventListeners:{<span class="hljs-string">"processCompleted"</span>: themeCompleted, <span class="hljs-string">"processFailed"</span>: themeFailed}}),
            dotStyle = <span class="hljs-keyword">new</span> SuperMap.REST.ServerStyle({
                markerSize: <span class="hljs-number">3</span>,
                markerSymbolID: <span class="hljs-number">12</span>
            }),
            themeDotDensity = <span class="hljs-keyword">new</span> SuperMap.REST.ThemeDotDensity({
                dotExpression: <span class="hljs-string">"Pop_1994"</span>,
                value: <span class="hljs-number">5000000</span>,
                style: dotStyle
            }),
            themeParameters = <span class="hljs-keyword">new</span> SuperMap.REST.ThemeParameters({
                themes: [themeDotDensity],
                datasetNames: [<span class="hljs-string">"Countries"</span>],
                dataSourceNames: [<span class="hljs-string">"World"</span>]
            });
    <span class="hljs-comment">//向iserver发送请求</span>
    themeService.processAsync(themeParameters);
</code></pre>
<h5 id="step3-使用iconnectoramapjs把step2创建的supermap专题图叠加到step1创建的高德地图上">Step3 使用iConnectorAMap.js把Step2创建的SuperMap专题图叠加到Step1创建的高德地图上</h5>
<pre><code class="lang-JavaScript">    <span class="hljs-keyword">if</span>(themeEventArgs.result.resourceInfo.id) {
        <span class="hljs-keyword">var</span> canvasTiles =  SuperMap.Web.iConnector.AMap.getLayer(url,{layersID:themeEventArgs.result.resourceInfo.id});
        mapObj.addLayer(canvasTiles);
    }
</code></pre>
<h5 id="在线演示与源码编辑">在线演示与源码编辑</h5>
<p>在线演示：
<a href="http://runjs.cn/detail/pmkuutbr" target="_blank">http://runjs.cn/detail/pmkuutbr</a></p>
<p>源码编辑：
<a href="http://runjs.cn/code/pmkuutbr" target="_blank">http://runjs.cn/code/pmkuutbr</a></p>