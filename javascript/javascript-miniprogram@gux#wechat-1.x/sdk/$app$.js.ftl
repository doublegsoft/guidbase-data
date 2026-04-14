<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/gux.ftl" as gux>
<#import "/$/guidbase4js.ftl" as guidbase4js>
const app = getApp();
const sdk = {
  options: {},
  host4Image: app.host,
  host4Api: app.host,
};
const { xhr } = require('@/vendor/gux/common/xhr');
<#assign options = {}>
<#assign methods = {}>
<#list app.pages as page>
  <#list page.pageWidgets as widget>
    <#if widget.type?? && widget.id?? && widget.type == 'select' && !options[widget.id]??>
sdk.options['${js.nameVariable(widget.id)}'] = {
  values: [
    {value: '1', text: 'A'},
    {value: '2', text: 'B'}
  ]
};
      <#assign options = options + {widget.id: ""}>
    </#if>
  </#list>
</#list>

/*!
** 获取应用程序【系统广告】信息。
*/
sdk.fetchApplicationAdvertisements = async function (params) {
  return xhr.post({
    url: '/api/v3/common/script/stdbiz/ams/application_advertisement/find',
    params: {
      applicationId: sdk.APPID,
      status: 'IP',
    },
  });
};
<#assign methods += {"fetchApplicationAdvertisements":""}>

/*!
** 获取应用程序【通知公告】信息。
*/
sdk.fetchApplicationNotifications = async function (params) {
  return xhr.post({
    url: '/api/v3/common/script/stdbiz/ams/application_notification/find',
    params: {
      applicationId: sdk.APPID,
      status: 'IP',
    },
  });
};
<#assign methods += {"fetchApplicationNotifications":""}>

/*!
** 获取应用程序【特色服务】信息。
*/
sdk.fetchApplicationFeatures = async function (params) {
  return xhr.post({
    url: '/api/v3/common/script/stdbiz/ams/application_feature/find',
    params: {
      applicationId: sdk.APPID,
      status: 'IP',
    },
  });
};
<#assign methods += {"fetchApplicationFeatures":""}>

/*!
** 获取应用程序【历史搜索】信息。
*/
sdk.fetchSearchCriteria = async function (params) {
  return xhr.post({
    url: '/api/v3/common/script/stdbiz/pim/search_criterion/find',
    params: params,
  });
};
<#assign methods += {"fetchSearchCriteria":""}>

sdk.fetchArticle = async (params) => {
  if (!params.articleId) return;
  return xhr.post({
    url: sdk.host4Api + '/api/v3/common/script/stdbiz/cm/article/find',
    params: {
      articleId: params.articleId,
    },
  });
};
<#assign methods += {"fetchArticle":""}>
<#list app.pages as page>
  <#list page.pageWidgets as widget>
    <#-- 对表单单独处理保存操作和读取操作，可能存在需要特殊处理的表单 -->
    <#if widget.type?? && (widget.type == "readonly_form" || widget.type == "editable_form")>
      <#assign objfull = (widget.options["object"]!"object")>  
      <#assign appname = guidbase.get_app_from_object(objfull)>   
      <#assign modname = guidbase.get_module_from_object(objfull)>
      <#assign objname = guidbase.get_object_from_object(objfull)>   
      <#if !methods["fetch"+js.nameType(objname)]??>
      
/*!
** 获取单个【${objname}】数据。
*/      
sdk.fetch${js.nameType(objname)} = async (params) => {
  if (!params.${js.nameVariable(objname + "_id")})
    throw 'no params.${js.nameVariable(objname + "_id")} found';
  let resp = await xhr.post({
    url: sdk.host4Api + '/api/v3/common/script/${appname}/${modname}/${objname}/find',
    params: {
      ...params,
      <#if widget.options["meta"]??>
      '//${appname}/${modname}/${objname}_meta/find': {
        _result_name: 'metas',
        ${js.nameVariable(objname + "_id")}: params.${js.nameVariable(objname + "_id")},
      },
      <#elseif widget.options["pivot"]??>
        <#assign pivotObjName = guidbase.get_object_from_object(widget.options["pivot"])>
      '//${appname}/${modname}/${pivotObjName}/find': {
        _result_name: '${js.nameVariable(guidbase.pluralize_object(pivotObjName))}',
        ${js.nameVariable(pivotObjName + "_id")}: params.${js.nameVariable(pivotObjName + "_id")},
      },
      <#elseif widget.options["extend"]??>
        <#assign extendObjName = guidbase.get_object_from_object(widget.options["extend"])>
      '<<${appname}/${modname}/${pivotObjName}/find': {
        _source_field: '${js.nameVariable(objname + "_id")}',
        _target_field: '${js.nameVariable(extendObjName + "_id")}',
        ${js.nameVariable(extendObjName + "_id")}: params.${js.nameVariable(extendObjName + "_id")},
      },
      </#if>
    },
  });
  if (resp.error) throw resp.error;
  let ret = resp.data;
      <#if widget.options["meta"]??>
  ret = {};    
        <#assign metaObjName = widget.options["meta"]>
  for (let item of resp.data.metas) {
    ret[item.propertyName] = item.propertyValue;      
  }  
      <#elseif widget.options["pivot"]??>  
        <#assign pivotKeyName = widget.options["pivotkey"]>
        <#assign pivotValName = widget.options["pivotval"]>
  ret = {};  
        <#assign pivotObjName = guidbase.get_object_from_object(widget.options["pivot"])>
  for (let item of resp.data.${js.nameVariable(guidbase.pluralize_object(pivotObjName))}) {
    ret[item.${pivotKeyName}] = item.${pivotValName};      
  }     
      <#elseif widget.options["extend"]??>
      </#if>  
  return ret;    
};     
      <#assign methods += {"fetch"+js.nameType(objname):""}>
      </#if>
      <#if !methods["save"+js.nameType(objname)]??>

/*!
** 保存【${objname}】数据。
*/      
sdk.save${js.nameType(objname)} = async (params) => {
      <#if widget.options["meta"]??>
  let metas = [];    
        <#list widget.widgets as child>
          <#if !child.options["meta"]??><#continue></#if>
  metas.push({
    ${js.nameVariable(objname + "_id")}: params.${js.nameVariable(objname + "_id")} || '${r"${"}${js.nameVariable(objname + "_id")}}',
    propertyName: '${js.nameVariable(child.id)}',
    propertyValue: params.${js.nameVariable(child.id)},
  });      
        </#list>      
      <#elseif widget.options["pivot"]??>
        <#assign pivotObjName = guidbase.get_object_from_object(widget.options["pivot"])>
        <#assign pivotKeyName = widget.options["pivotkey"]>
        <#assign pivotValName = widget.options["pivotval"]>
  let ${js.nameVariable(guidbase.pluralize_object(pivotObjName))} = [];
        <#list widget.widgets as child>
  ${js.nameVariable(guidbase.pluralize_object(pivotObjName))}.push({
    ${js.nameVariable(objname + "_id")}: params.${js.nameVariable(objname + "_id")} || '${r"${"}${js.nameVariable(objname + "_id")}}',
    ${js.nameVariable(pivotKeyName)}: '${js.nameVariable(child.id)}',
    ${js.nameVariable(pivotValName)}: params.${js.nameVariable(child.id)},
  });      
        </#list>
      </#if>
  return xhr.post({
    url: sdk.host4Api + '/api/v3/common/script/${appname}/${modname}/${objname}/merge',
    params: {
      ...params,
      <#if widget.options["meta"]??>
      '||${appname}/${modname}/${objname}_meta/merge': metas,
      <#elseif widget.options["pivot"]??>
      '||${appname}/${modname}/${pivotObjName}/merge': ${js.nameVariable(guidbase.pluralize_object(pivotObjName))},
      <#elseif widget.options["extend"]??>
      '||${appname}/${widget.options["extend"]}/merge': {
        ...params,
      },
      </#if>
    },
  });
};    
      <#assign methods += {"save"+js.nameType(objname):""}>
      </#if>
      <#continue>
    </#if>
    <#if !widget.options["url"]?? || !widget.options["url"]?starts_with("/")><#continue></#if>
    <#assign url = widget.options["url"]>
    <#assign sdkmethod = guidbase.url_to_method_sdk(url)>
    <#assign apiurl = guidbase.url_to_api_url(url)>
    <#if methods[sdkmethod]??><#continue></#if>
    <#assign objname = guidbase.get_object_from_url(url)>
    <#assign pluralname = guidbase.pluralize_object(objname)>    
    <#if sdkmethod?starts_with("paginate") && !methods["fetch"+js.nameType(pluralname)]??>

/*!
** 获取多个【${objname}】数据。
*/      
sdk.fetch${js.nameType(pluralname)} = async (params) => {
  if (!params.limit) params.limit = 15;
  if (!params.start) params.start = 0;
  return xhr.post({
    url: sdk.host4Api + '${apiurl}',
    params: {
      ...params,
    },
  });
};      
      <#assign methods += {"fetch"+js.nameType(pluralname):""}>     
    <#elseif sdkmethod?starts_with("find") && !methods["fetch"+js.nameType(pluralname)]??>   
         
/*!
** 获取单个【${objname}】数据。
*/      
sdk.fetch${js.nameType(objname)} = async (params) => {
  if (!params.${js.nameVariable(objname + "_id")})
    throw 'no params.${js.nameVariable(objname + "_id")} found';
  return xhr.post({
    url: sdk.host4Api + '${apiurl}',
    params: {
      ...params,
    },
  });
};     
      <#assign methods += {"fetch"+js.nameType(objname):""}>   
    <#else>
      
/*!
** 【${apiurl}】
*/      
sdk.${js.nameVariable(sdkmethod)} = async (params) => {
  return xhr.post({
    url: sdk.host4Api + '${apiurl}',
    params: {
      ...params,
    },
  });
};      
      <#assign methods += {js.nameVariable(sdkmethod):""}>
    </#if>
  </#list>
</#list>

module.exports = { sdk };