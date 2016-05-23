<h1 id="使用iconnector对接google地图应用">使用iConnector对接Google地图应用</h1>
<hr>
<!-- toc -->
<ul class="atoc">
<li><a href="#iconnectorgooglejs%E7%AE%80%E4%BB%8B">iConnectorGoogle.js简介</a></li>
<li><a href="#%E5%87%86%E5%A4%87%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83">准备开发环境</a><ul>
<li><a href="#1-%E5%9F%BA%E4%BA%8Egoogle%E5%9C%B0%E5%9B%BE-javascript-api%E7%9A%84%E5%9C%B0%E5%9B%BE%E5%BA%94%E7%94%A8">1. 基于Google地图 JavaScript API的地图应用</a></li>
<li><a href="#2-%E5%87%86%E5%A4%87supermap-gis%E6%9C%8D%E5%8A%A1">2. 准备SuperMap GIS服务</a></li>
<li><a href="#3-supermap%E7%9A%84javascript-api%E4%B8%8Eiconnectorgooglejs">3. SuperMap的JavaScript API与iConnectorGoogle.js</a></li>
</ul>
</li>
<li><a href="#%E7%A4%BA%E8%8C%83%E7%A8%8B%E5%BA%8F">示范程序</a><ul>
<li><a href="#%E7%A4%BA%E4%BE%8B1%EF%BC%9A%E5%9C%A8google%E5%9C%B0%E5%9B%BE%E4%B8%8A%EF%BC%8C%E5%8F%A0%E5%8A%A0supermap%E7%9A%84%E5%88%86%E6%AE%B5%E4%B8%93%E9%A2%98%E5%9B%BE">示例1：在Google地图上，叠加SuperMap的分段专题图</a><ul>
<li><a href="#step1-%E5%88%9B%E5%BB%BA%E5%9C%B0%E5%9B%BE%E7%AA%97%E5%8F%A3%E5%B9%B6%E5%8A%A0%E8%BD%BDgoogle%E5%9C%B0%E5%9B%BE">Step1 创建地图窗口并加载Google地图</a></li>
<li><a href="#step2-%E4%BD%BF%E7%94%A8supermapincludejs%EF%BC%8C%E5%9F%BA%E4%BA%8Esupermap-rest%E6%9C%8D%E5%8A%A1%E4%B8%AD%E7%9A%84chinaprovincer%E5%9B%BE%E5%B1%82%EF%BC%8C%E5%88%B6%E4%BD%9C%E5%88%86%E6%AE%B5%E4%B8%93%E9%A2%98%E5%9B%BE">Step2 使用SuperMap.Include.js，基于SuperMap REST服务中的"China_Province_R"图层，制作分段专题图</a></li>
<li><a href="#step3-%E4%BD%BF%E7%94%A8iconnectorgooglejs%E6%8A%8Astep2%E5%88%9B%E5%BB%BA%E7%9A%84supermap%E4%B8%93%E9%A2%98%E5%9B%BE%E5%8F%A0%E5%8A%A0%E5%88%B0step1%E5%88%9B%E5%BB%BA%E7%9A%84google%E5%9C%B0%E5%9B%BE%E4%B8%8A">Step3 使用iConnectorGoogle.js把Step2创建的SuperMap专题图叠加到Step1创建的Google地图上</a></li>
<li><a href="#%E5%9C%A8%E7%BA%BF%E6%BC%94%E7%A4%BA%E4%B8%8E%E6%BA%90%E7%A0%81%E7%BC%96%E8%BE%91">在线演示与源码编辑</a></li>
</ul>
</li>
</ul>
</li>
</ul>
<!-- tocstop -->
<h3 id="iconnectorgooglejs简介">iConnectorGoogle.js简介</h3>
<p>如果您已经使用Google地图的JavaScript API构建了地图应用，您可以通过iConnectorGoogle.js对接SuperMap的GIS服务。例如：在Google地图上叠加通过SuperMap发布的业务数据。</p>
<p>iConnectorGoogle.js主要提供了地图叠加以及Geometry的转换，可以实现：在Google地图上，叠加SuperMap地图服务中的地图、专题图、查询结果，以及空间分析结果。</p>
<h3 id="准备开发环境">准备开发环境</h3>
<h4 id="1-基于google地图-javascript-api的地图应用">1. 基于Google地图 JavaScript API的地图应用</h4>
<p>您可以使用Google地图的在线JavaScript API，使用方式：</p>
<pre><code class="lang-JavaScript">    &lt;script src=<span class="hljs-string">"https://maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=false"</span>&gt;<span class="xml"><span class="hljs-tag">&lt;/<span class="hljs-title">script</span>&gt;</span>
</span></code></pre>
<h4 id="2-准备supermap-gis服务">2. 准备SuperMap GIS服务</h4>
<p>您可以使用来自您的SuperMap iServer服务器的REST GIS服务，就像来自SuperMap技术资源中心的：<a href="http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。" target="_blank">http://support.supermap.com.cn:8090/iserver/services/map-china400/rest/maps/China。</a></p>
<p>您也可以将业务数据托管在SuperMap Online，然后使用发布的地图服务，例如：<a href="http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World" target="_blank">http://www.supermapol.com/iserver/services/vm3sbiax/rest/maps/World</a></p>
<p>如果需要在线GIS服务器，您还可以在SuperMap Online租用GIS云主机，并发布您自己的GIS服务。</p>
<h4 id="3-supermap的javascript-api与iconnectorgooglejs">3. SuperMap的JavaScript API与iConnectorGoogle.js</h4>
<pre><code class="lang-JavaScript">    &lt;script src=<span class="hljs-string">"http://www.supermapol.com/resources/api/libs/SuperMap.Include.js"</span>&gt;<span class="xml"><span class="hljs-tag">&lt;/<span class="hljs-title">script</span>&gt;</span>
    <span class="hljs-tag">&lt;<span class="hljs-title">script</span> <span class="hljs-attribute">src</span>=<span class="hljs-value">"http://sandbox.runjs.cn/uploads/rs/3/dofmucai/iConnectorGoogle.js"</span>&gt;</span><span class="undefined"></span><span class="hljs-tag">&lt;/<span class="hljs-title">script</span>&gt;</span>
</span></code></pre>
<h3 id="示范程序">示范程序</h3>
<h4 id="示例1：在google地图上，叠加supermap的分段专题图">示例1：在Google地图上，叠加SuperMap的分段专题图</h4>
<h5 id="step1-创建地图窗口并加载google地图">Step1 创建地图窗口并加载Google地图</h5>
<p>使用Google地图API创建地图窗口“map-canvas”，并设置加载地图的中心点和比例尺级别，
创建地图如：map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);</p>
<pre><code class="lang-JavaScript">    <span class="hljs-keyword">var</span> myLatlng = <span class="hljs-keyword">new</span> google.maps.LatLng(<span class="hljs-number">0</span>, <span class="hljs-number">0</span>);
    <span class="hljs-keyword">var</span> mapOptions = {
        center: myLatlng,
        zoom: <span class="hljs-number">1</span>,
        streetViewControl: <span class="hljs-literal">true</span>,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = <span class="hljs-keyword">new</span> google.maps.Map(<span class="hljs-built_in">document</span>.getElementById(<span class="hljs-string">'map-canvas'</span>),
            mapOptions);
</code></pre>
<h5 id="step2-使用supermapincludejs，基于supermap-rest服务中的chinaprovincer图层，制作分段专题图">Step2 使用SuperMap.Include.js，基于SuperMap REST服务中的"China_Province_R"图层，制作分段专题图</h5>
<pre><code class="lang-JavaScript">    <span class="hljs-keyword">var</span> themeService = <span class="hljs-keyword">new</span> SuperMap.REST.ThemeService(url, {eventListeners:{<span class="hljs-string">"processCompleted"</span>: themeCompleted, <span class="hljs-string">"processFailed"</span>: themeFailed}}),
        style1 = <span class="hljs-keyword">new</span> SuperMap.REST.ServerStyle({
            fillForeColor: <span class="hljs-keyword">new</span> SuperMap.REST.ServerColor(<span class="hljs-number">137</span>,<span class="hljs-number">203</span>,<span class="hljs-number">187</span>),
            lineColor: <span class="hljs-keyword">new</span> SuperMap.REST.ServerColor(<span class="hljs-number">0</span>,<span class="hljs-number">0</span>,<span class="hljs-number">0</span>),
            lineWidth: <span class="hljs-number">0.1</span>
        }),
        style2 = <span class="hljs-keyword">new</span> SuperMap.REST.ServerStyle({
            fillForeColor: <span class="hljs-keyword">new</span> SuperMap.REST.ServerColor(<span class="hljs-number">233</span>,<span class="hljs-number">235</span>,<span class="hljs-number">171</span>),
            lineColor: <span class="hljs-keyword">new</span> SuperMap.REST.ServerColor(<span class="hljs-number">0</span>,<span class="hljs-number">0</span>,<span class="hljs-number">0</span>),
            lineWidth: <span class="hljs-number">0.1</span>
        }),
        style3 = <span class="hljs-keyword">new</span> SuperMap.REST.ServerStyle({
            fillForeColor: <span class="hljs-keyword">new</span> SuperMap.REST.ServerColor(<span class="hljs-number">135</span>,<span class="hljs-number">157</span>,<span class="hljs-number">157</span>),
            lineColor: <span class="hljs-keyword">new</span> SuperMap.REST.ServerColor(<span class="hljs-number">0</span>,<span class="hljs-number">0</span>,<span class="hljs-number">0</span>),
            lineWidth: <span class="hljs-number">0.1</span>
        }),
        themeRangeIteme1 = <span class="hljs-keyword">new</span> SuperMap.REST.ThemeRangeItem({
            start: <span class="hljs-number">0</span>,
            end: <span class="hljs-number">500000000000</span>,
            style: style1
        }),
        themeRangeIteme2 = <span class="hljs-keyword">new</span> SuperMap.REST.ThemeRangeItem({
            start: <span class="hljs-number">500000000000</span>,
            end: <span class="hljs-number">1000000000000</span>,
            style: style2
        }),
        themeRangeIteme3 = <span class="hljs-keyword">new</span> SuperMap.REST.ThemeRangeItem({
            start: <span class="hljs-number">1000000000000</span>,
            end:  <span class="hljs-number">3000000000000</span>,
            style: style3
        }),
        themeRange = <span class="hljs-keyword">new</span> SuperMap.REST.ThemeRange({
            rangeExpression: <span class="hljs-string">"SMAREA"</span>,
            rangeMode: SuperMap.REST.RangeMode.EQUALINTERVAL,
            items: [themeRangeIteme1,themeRangeIteme2,themeRangeIteme3]
        }),
        themeParameters = <span class="hljs-keyword">new</span> SuperMap.REST.ThemeParameters({
            datasetNames: [<span class="hljs-string">"China_Province_R"</span>],
            dataSourceNames: [<span class="hljs-string">"China400"</span>],
            joinItems: <span class="hljs-literal">null</span>,
            themes: [themeRange]
        });
    themeService.processAsync(themeParameters);
</code></pre>
<h5 id="step3-使用iconnectorgooglejs把step2创建的supermap专题图叠加到step1创建的google地图上">Step3 使用iConnectorGoogle.js把Step2创建的SuperMap专题图叠加到Step1创建的Google地图上</h5>
<pre><code class="lang-JavaScript">    <span class="hljs-keyword">if</span>(themeEventArgs.result.resourceInfo.id) {
        map.overlayMapTypes.insertAt(
                <span class="hljs-number">0</span>, SuperMap.Web.iConnector.Google.getLayer(url,{layersID:themeEventArgs.result.resourceInfo.id}));
    }
</code></pre>
<h5 id="在线演示与源码编辑">在线演示与源码编辑</h5>
<p>在线演示：
<a href="http://runjs.cn/detail/nk6mvwfi" target="_blank">http://runjs.cn/detail/nk6mvwfi</a></p>
<p>源码编辑：
<a href="http://runjs.cn/code/nk6mvwfi" target="_blank">http://runjs.cn/code/nk6mvwfi</a></p>