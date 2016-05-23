//fs为nodejs自带的文件读写接口
var fs = require('fs');
//cheerio，可在服务端使用jquery方法的库
var cheerio = require('cheerio');

//var markdown_html = require('gitbook-markdown');

//要处理的文件
var files = [
{name:'amap-ftl',type:'ftl',path:'./src/iConnector_Page/amap.ftl'},
{name:'baidu-ftl',type:'ftl',path:'./src/iConnector_Page/baidu.ftl'},
{name:'google-ftl',type:'ftl',path:'./src/iConnector_Page/google.ftl'},
{name:'leaflet-ftl',type:'ftl',path:'./src/iConnector_Page/Leaflet.ftl'},
{name:'readme-ftl',type:'ftl',path:'./src/iConnector_Page/readme.ftl'},
{name:'javascript-api-ftl',type:'ftl',path:'./src/iConnector_Page/javascript-api.ftl'},
{name:'iconector-ftl',type:'ftl',path:'./src/iConnector_Page/iconnector.ftl'},
{name:'amap-api',type:'html',path:'./src/iConnector_API/iConnectorAMap-js.html'},
{name:'baidu-api',type:'html',path:'./src/iConnector_API/iConnectorBaidu-js.html'},
{name:'google-api',type:'html',path:'./src/iConnector_API/iConnectorGoogle-js.html'},
{name:'leaflet-api',type:'html',path:'./src/iConnector_API/iConnectorLeaflet-js.html'}
];
//目标目录
var dist_path = './dist/';

function handleData(name,data){
	var lines = data.split('\n');
	var result = 'var ' + name + '= [';
	for(var i = 0, len = lines.length; i < len; i++){
		var line = lines[i];
		line = trim(line);
		line = changeQuote(line);
		if(line){
			line = "'" + line + "'";
			result += '\n';
			result += (i === (len -1)) ? line : (line + ' , ');
		}
	}
	result += '];';
	return result;
}
function hanldeHtml(name,html,selector){
	//加载html页面成dom对象
	var $ = cheerio.load(html);
	var content = $(selector);
	//使用html接口将content对象转化为字符串，所以先将其附到一个div上，再执行html方法
	var html = $('<div></div>').append(content).html();
	console.log(html);
	return handleData(name,html);
}

/*function handleMarkdown(name,data){
	var result = markdown_html.page(data);
	return handleData(name,result.content);
}*/

//jquery的trim实现，用于去掉字符串两边的空格，换行符等
function trim(str){
	 return str.replace(/(^\s*)|(\s*$)/g, '');
}

function changeQuote(str){
	return str.replace(/'/g,'\\"');
}

for(var i = 0,len = files.length;i<len;i++){
	var file = files[i];
	var name = file.name, type = file.type, path = file.path;
	console.log(path);
	fs.readFile(path,'utf8',function(name,type){
		return function(err,data){
			if(err) throw err;
			var n = name.replace('-','_');
			var new_data = '';
			switch(type){
				case 'html':
				    new_data = hanldeHtml(n,data,'#Content');
				    break;
				case 'ftl':
				    data = '<section class="normal" id="section-">' + data + '</section>';
				    new_data = hanldeHtml(n,data,'#section-');
				    break;
				default:
				    new_data = handleData(n,data);
				    break;
			}
		    var n_path = dist_path + '/' + type + '/';
		    if(!fs.existsSync(n_path)){
		    	fs.mkdirSync(n_path);
		    }
		    fs.writeFile(n_path + name + '.js', new_data, function(err){
		    	if(err) throw err;
		    });
		};
	}(name,type));
}

