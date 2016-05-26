//fs为nodejs自带的文件读写接口
var fs = require('fs');
//cheerio，可在服务端使用jquery方法的库
var cheerio = require('cheerio');

//压缩文件夹
var ZipZipTop = require("zip-zip-top");

//var markdown_html = require('gitbook-markdown');

//要处理的文件
var files = [
{name:'amap-md',type:'desc',path:'./src/iConnector_Page/html/amap.html'},
{name:'baidu-md',type:'desc',path:'./src/iConnector_Page/html/baidu.html'},
{name:'google-md',type:'desc',path:'./src/iConnector_Page/html/google.html'},
{name:'leaflet-md',type:'desc',path:'./src/iConnector_Page/html/Leaflet.html'},
{name:'readme-md',type:'desc',path:'./src/iConnector_Page/html/jsApi.html'},
{name:'javascript-api-md',type:'desc',path:'./src/iConnector_Page/html/iclientforjs.html'},
{name:'iconector-md',type:'desc',path:'./src/iConnector_Page/html/index.html'},
{name:'amap-api',type:'api',path:'./src/iConnector_API/iConnectorAMap-js.html'},
{name:'baidu-api',type:'api',path:'./src/iConnector_API/iConnectorBaidu-js.html'},
{name:'google-api',type:'api',path:'./src/iConnector_API/iConnectorGoogle-js.html'},
{name:'leaflet-api',type:'api',path:'./src/iConnector_API/iConnectorLeaflet-js.html'}
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
function handleHtml(name,html,type){
	//加载html页面成dom对象
	var $ = cheerio.load(html);
	var content;
	switch(type){
		case 'api':
			content = $('#Content');
			break;
		case 'desc':
			content = $('#section-');
			content.find('script,footer').remove();
			break;
		default:
			content = $;
			break;
	}
	
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
var counter = files.length;
for(var i = 0,len = files.length;i<len;i++){
	var file = files[i];
	var name = file.name, type = file.type, path = file.path;
	console.log(path);
	fs.readFile(path,'utf8',function(name,type){
		return function(err,data){
			if(err) throw err;
			var n = name.replace(/-/gi,'_');
			var new_data = '';
			switch(type){
				case 'api':
				    new_data = handleHtml(n,data,type);
				    break;
				case 'desc':
				    new_data = handleHtml(n,data,type);
				    break;
				default:
				    new_data = handleData(n,data);
				    break;
			}
		    var n_path = dist_path + type + '/';
		    if(!fs.existsSync(dist_path)){
		    	fs.mkdirSync(dist_path);
		    }
		    if(!fs.existsSync(n_path)){
		    	fs.mkdirSync(n_path);
		    }
            fs.writeFile(n_path + name + '.js', new_data, function(err) {
                if (err) throw err;
                counter--;
                if (counter === 0) {
                    //完成后对文件进行压缩
                    var zip4 = new ZipZipTop();
                    zip4.zipFolder(dist_path, function(err) {
                        if (err) {
                            console.log(err);
                        }
                        zip4.writeToFile(dist_path + "dist.zip", function(err) {
                            if (err) {
                                return console.log(err);
                            }
                            console.log("Done");
                        });
                    });
                    return;
                }
            });
		};
	}(name,type));
}

