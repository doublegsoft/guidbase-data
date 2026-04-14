<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/gux.ftl" as gux>
const sdk = {
  options: {},
};
<#assign options = {}>
<#list app.pages as page>
  <#list page.pageWidgets as widget>
    <#if widget.container.type == "editable_form" && 
         widget.type?? && widget.id?? && widget.type == "select" && 
         !options[(widget.options["object"] + "#" + widget.options["attribute"])]??>
      <#if widget.options["values"]??>
        <#assign values = widget.options["values"]>
        <#assign pairs = values?substring(1,values?length-1)?split(",")>
sdk.options['${widget.options["object"]}#${widget.options["attribute"]}'] = {
  values: [
        <#list pairs as pair>
          <#assign strs = pair?split(":")>
    {value: '${strs[0]?trim}', text: '${strs[1]?trim}'}<#if pair?index != pairs?size - 1>,</#if>
        </#list>
  ],
};        
      <#else>
sdk.options['${widget.options["object"]}#${widget.options["attribute"]}'] = {
  values: [
    {value: '1', text: 'A'},
    {value: '2', text: 'B'}
  ],
};      
      </#if>
      <#assign options = options + {(widget.options["object"] + "#" + widget.options["attribute"]): ""}>
    </#if>
  </#list>
</#list>
<#assign fetchMethods = {}>
<#list app.pages as page>
  <#list page.pageWidgets as widget>
    <#if widget.type?? &&
         (widget.type == "readonly_form") &&
         !fetchMethods[widget.id]??>
      <#assign objname = guidbase.get_object_from_url(widget.options["url"]!"module/object/action")>

/*!
**
*/
sdk.fetch${js.nameType(guidbase.pluralize_widget_object(widget))} = async function (params) {
  let ret = [];
  for (let i = 0; i < 15; i++) {
    ret.push({
      ${js.nameVariable(objname + "_id")}: String(i),
      <#list widget.widgets as child>
<#--      
<@gux.print_js_declare_testdata widget=child indent=6 />
-->  
      </#list>
    });
  }
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(ret);
    }, 500);
  });
};
      <#assign fetchMethods = fetchMethods + {widget.id: ""}>
    </#if>
  </#list>
</#list>
<#assign fetchMethods = {}>
<#list app.pages as page>
  <#list page.pageWidgets as widget>
    <#if widget.type?? &&
         (widget.type == "readonly_form") &&
         !fetchMethods[widget.id]??>
      <#assign objname = guidbase.get_object_from_url(widget.options["url"]!"module/object/action")>
/*!
**
*/
sdk.fetch${js.nameType(guidbase.get_widget_object(widget))} = async function (params) {
  let ret = {
    ${js.nameVariable(objname + "_id")}: '1',
      <#list widget.widgets as child>
<#--      
<@gux.print_js_declare_testdata widget=child indent=4 />    
-->
      </#list>
  };
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(ret);
    }, 500);
  });
};
      <#assign fetchMethods = fetchMethods + {widget.id: ""}>
    </#if>
  </#list>
</#list>

/*!
** 获取应用程序【系统广告】信息。
*/
sdk.fetchApplicationAdvertisements = async function (params) {
  let ret = [{
    imagePath: 'https://picsum.photos/750/300',
  },{
    imagePath: 'https://picsum.photos/751/300',
  },{
    imagePath: 'https://picsum.photos/752/300',
  }];
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(ret);
    }, 500);
  });
};

/*!
** 获取应用程序【通知公告】信息。
*/
sdk.fetchApplicationNotifications = async function (params) {
  let ret = [{
    content: '这是一条系统通知，您可以在后台修改通知内容。',
  },{
    content: '通知告诉大家，注意低代码平台的扩展性和个性化建设。',
  },{
    content: '我们一起来搞低代码。',
  },{
    content: '我们一起利用LLM Agent来搞低代码。',
  }];
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(ret);
    }, 500);
  });
};

/*!
** 获取应用程序【特色服务】信息。
*/
sdk.fetchApplicationFeatures = async function (params) {
  let ret = [{
    imagePath: 'https://picsum.photos/158/158',
  },{
    imagePath: 'https://picsum.photos/159/159',
  },{
    imagePath: 'https://picsum.photos/160/160',
  },{
    imagePath: 'https://picsum.photos/161/161',
  },{
    imagePath: 'https://picsum.photos/162/162',
  }];
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(ret);
    }, 500);
  });
};

/*!
** 获取应用程序【历史搜索】信息。
*/
sdk.fetchSearchCriteria = async function (params) {
  let ret = {
    history: [{
      text: '历史搜索1',
    },{
      text: '历史搜索2',
    },{
      text: '历史搜索3',
    },{
      text: '历史搜索4',
    }],
    category: [{
      text: '类别搜索1',
    },{
      text: '类别搜索2',
    },{
      text: '类别搜索3',
    },{
      text: '类别搜索4',
    }],
  };
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(ret);
    }, 500);
  });
};