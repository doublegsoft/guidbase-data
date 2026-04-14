<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/guidbase4dart.ftl" as guidbase4dart>
<#import "/$/gux.ftl" as gux>
<#if license??>
${dart.license(license)}
</#if>
<#assign methods = {}>
const String host4Image = "http://192.168.0.207:9098";

const String host4Api = "http://192.168.0.207:9098";
<#list app.pages as page>
  <#list page.pageWidgets as widget>
    <#if !widget.type??><#continue></#if>
    <#if widget.type == "list_view" || widget.type == "grid_view">
      <#if !widget.options["url"]??><#continue></#if>
      <#assign url = widget.options["url"]>
      <#assign objname = guidbase.get_object_from_url(url)>
      <#if methods[objname]??><#continue></#if>
      <#assign methods += {objname: objname}>
      <#list widget.widgets as child>
        <#if child.type == "tile">
          <#assign tile = child>
        </#if>
      </#list>
      <#if !tile??><#continue></#if>
      
///
/// 获取【${widget.options["title"]!"对象名称"}】列表。
///
Future<List<Map<String,dynamic>>> fetch${dart.nameType(guidbase.pluralize_widget_object(widget))}(Map<String,dynamic> params) async {
  int limit = (params['limit']) ?? 15;
  List<Map<String,dynamic>> ret = [];
  for (int i = 0; i < limit; i++) {
    ret.add({
      <#list tile.widgets as grandson>
<@guidbase4dart.print_dart_declare_testdata widget=grandson indent=6 />    
      </#list> 
    });
  }
  return ret;
}
    </#if>
  </#list>
</#list>

///
/// 获取【系统公告】消息列表。
///
Future<List<Map<String,dynamic>>> fetchApplicationNotifications() async {
  return [{
    "content":"这是第一条消息",
  },{
    "content":"这是第二条消息",
  },{
    "content":"这是第三条消息",
  }];
}