<#--
 ###############################################################################
 ### 公共函数
 ###############################################################################
 -->
<#function has_toolbar_of_widget widget>
  <#list widget.widgets as child>
    <#if child.type?? && child.type == "toolbar">
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function> 

<#function get_toolbar_of_widget widget>
  <#list widget.widgets as child>
    <#if child.type?? && child.type == "toolbar">
      <#return child>
    </#if>
  </#list>
</#function> 

<#--
 ###############################################################################
 ### 【编辑表单】字段中options配置项的一致的输出函数
 ###############################################################################
 -->
<#macro print_js_declare_editable_form_field_options widget indent>
  <#if !widget.type??><#return></#if>
  <#if widget.type == "select">
${""?left_pad(indent)}options: {
    <#if widget.id?ends_with("_id")>
${""?left_pad(indent)}  url: '', 
${""?left_pad(indent)}  fields: {text: '${js.nameVariable(widget.id)?replace("Id", "Name")}', vallue: '${js.nameVariable(widget.id)}'},
    <#else>
${""?left_pad(indent)}  values: [{
${""?left_pad(indent)}    text: '选项A', value: 'A',
${""?left_pad(indent)}  },{
${""?left_pad(indent)}    text: '选项B', value: 'B',
${""?left_pad(indent)}  },{
${""?left_pad(indent)}    text: '选项C', value: 'C',
${""?left_pad(indent)}  }],     
    </#if>
${""?left_pad(indent)}},  
  </#if>
</#macro>

<#--
 ###############################################################################
 ### 【分页表格】列中display方法的一致的输出函数
 ###############################################################################
 -->
<#macro print_js_declare_pagination_table_column_display widget indent>
  <#if widget.type == 'text'>
${""?left_pad(indent)}td.innerHTML = row.${js.nameVariable(widget.id)};  
  <#elseif widget.type == 'date'>
${""?left_pad(indent)}td.innerHTML = moment(row.${js.nameVariable(widget.id)}).format('YYYY年MM月DD日');  
  </#if>
  <#list widget.widgets as child>
    <#local url = child.options["url"]!"">
    <#if child.type == "button">
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** ${child.options["title"]!"未定义"}
${""?left_pad(indent)}*/
${""?left_pad(indent)}let ${js.nameVariable(child.id!"Unknown")} = dom.templatize(`
${""?left_pad(indent)}  <a class="btn btn-sm btn-link">${child.options["title"]!"标题"}</a>
${""?left_pad(indent)}`, row);
${""?left_pad(indent)}dom.bind(${js.nameVariable(child.id!"Unknown")}, 'click', ev => {
      <#if url?contains("/delete") || url?contains("/remove")>
${""?left_pad(indent)}  dialog.confirm('确定删除该条信息？', () => {
${""?left_pad(indent)}    this.${js.nameVariable(guidbase.url_to_method_name(url))}(row);
${""?left_pad(indent)}  });      
      <#else>
${""?left_pad(indent)}  this.${js.nameVariable(guidbase.url_to_method_name(url))}(row);
      </#if>
${""?left_pad(indent)}}); 
${""?left_pad(indent)}td.appendChild(${js.nameVariable(child.id!"Unknown")});
    </#if>
  </#list>
</#macro>

<#--
 ###############################################################################
 ### 【数据瓦片】构造方法
 ###############################################################################
 -->
<#macro print_js_declare_tile widgets indent>
  <#local rows = 1>
  <#list widgets as widget>
    <#if (widget.options["level"]!"") == "quinary" ||  
         (widget.options["level"]!"") == "senary" ||
         (widget.options["level"]!"") == "septenary">
      <#local rows = rows + 1>   
    </#if>     
  </#list>
${""?left_pad(indent)}let ret = dom.templatize(`
  <#if rows == 1>
${""?left_pad(indent)}  <div class="gx-d-flex" style="align-items: center;">
<@print_js_declare_tile_first_row widgets=widgets indent=indent+4 />
${""?left_pad(indent)}  </div>
  <#else>
${""?left_pad(indent)}  <div>
${""?left_pad(indent)}    <div class="gx-d-flex" style="align-items: center;">
<@print_js_declare_tile_first_row widgets=widgets indent=indent+6 />
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="gx-d-flex">
<@print_js_declare_tile_second_row widgets=widgets indent=indent+6 />
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}`, row);
${""?left_pad(indent)}return ret;
</#macro>

<#macro print_js_declare_tile_first_row widgets indent>
  <#local hasPrimarySection = false>
  <#list widgets as widget>
    <#if (widget.options["level"]!"") == "image" || (widget.options["level"]!"") == "avatar">
${""?left_pad(indent)}<div style="width: 72px;">
${""?left_pad(indent)}  <image src="{{${js.nameVariable(widget.id)}}}" class="gx-wh-64">
${""?left_pad(indent)}</div>  
    </#if>
    <#if (widget.options["level"]!"") == "primary" || 
         (widget.options["level"]!"") == "secondary" ||
         (widget.options["level"]!"") == "tertiary">
      <#local hasPrimarySection = true>   
    </#if>     
  </#list>
  <#if hasPrimarySection>   
${""?left_pad(indent)}<div>  
  <#list widgets as widget>
    <#if (widget.options["level"]!"") == "primary">
${""?left_pad(indent)}  <div class="gx-text-primary">{{${js.nameVariable(widget.id)}}}</div>
    <#elseif (widget.options["level"]!"") == "secondary">
${""?left_pad(indent)}  <div class="gx-text-secondary gx-fs-12">{{${js.nameVariable(widget.id)}}}</div>
    <#elseif (widget.options["level"]!"") == "teriary">
${""?left_pad(indent)}  <div class="gx-text-secondary gx-fs-10">{{${js.nameVariable(widget.id)}}}</div>
    <#elseif (widget.options["level"]!"") == "quaternary">
${""?left_pad(indent)}  <div class="gx-text-secondary gx-fs-10">{{${js.nameVariable(widget.id)}}}</div>
    </#if>
  </#list>
${""?left_pad(indent)}</div>  
  </#if>
  <#list widgets as widget>
    <#if (widget.options["level"]!"") == "accent">
${""?left_pad(indent)}<div class="gx-ml-auto">
${""?left_pad(indent)}  <div class="gx-fs-16 gx-fb">{{${js.nameVariable(widget.id)}}}</div>
${""?left_pad(indent)}</div>  
    </#if>
  </#list>
</#macro>

<#macro print_js_declare_tile_second_row widgets indent> 
  <#list widgets as widget>
    <#if (widget.options["level"]!"") == "quinary">
${""?left_pad(indent)}<div class="d-flex">
${""?left_pad(indent)}  <i class="fas fa-star"></i>
${""?left_pad(indent)}  <span class="ms-auto">{{${js.nameVariable(widget.id)}}}</span>
${""?left_pad(indent)}</div>
    <#elseif (widget.options["level"]!"") == "senary">
${""?left_pad(indent)}<div class="d-flex">
${""?left_pad(indent)}  <i class="fas fa-star"></i>
${""?left_pad(indent)}  <span class="ms-auto">{{${js.nameVariable(widget.id)}}}</span>
${""?left_pad(indent)}</div>
    <#elseif (widget.options["level"]!"") == "septenary">
${""?left_pad(indent)}<div class="d-flex">
${""?left_pad(indent)}  <i class="fas fa-star"></i>
${""?left_pad(indent)}  <span class="ms-auto">{{${js.nameVariable(widget.id)}}}</span>
${""?left_pad(indent)}</div>
    </#if>
  </#list>
</#macro>

<#macro print_html_declare_tile widgets indent>
  <#local rows = 1>
  <#list widgets as widget>
    <#if (widget.options["level"]!"") == "quinary" ||  
         (widget.options["level"]!"") == "senary" ||
         (widget.options["level"]!"") == "septenary">
      <#local rows = rows + 1>   
    </#if>     
  </#list>
  <#if rows == 1>
${""?left_pad(indent)}<div class="gx-d-flex" style="align-items: center;">
<@print_html_declare_tile_first_row widgets=widgets indent=indent+2 />
${""?left_pad(indent)}</div>
  <#else>
${""?left_pad(indent)}<div>
${""?left_pad(indent)}  <div class="gx-d-flex" style="align-items: center;">
<@print_html_declare_tile_first_row widgets=widgets indent=indent+4 />
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="gx-d-flex">
<@print_html_declare_tile_second_row widgets=widgets indent=indent+4 />
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
  </#if>
</#macro>

<#macro print_html_declare_tile_first_row widgets indent>
  <#local hasPrimarySection = false>
  <#list widgets as widget>
    <#if (widget.options["level"]!"") == "image" || (widget.options["level"]!"") == "avatar">
${""?left_pad(indent)}<div style="width: 72px;">
${""?left_pad(indent)}  <image src="${widget.options["image"]!""}" class="gx-wh-64">
${""?left_pad(indent)}</div>  
    </#if>
    <#if (widget.options["level"]!"") == "primary" || 
         (widget.options["level"]!"") == "secondary" ||
         (widget.options["level"]!"") == "tertiary">
      <#local hasPrimarySection = true>   
    </#if>     
  </#list>
  <#if hasPrimarySection>   
${""?left_pad(indent)}<div>  
  <#list widgets as widget>
    <#if (widget.options["level"]!"") == "primary">
${""?left_pad(indent)}  <div class="gx-text-primary">${widget.options["title"]!"标题"}</div>
    <#elseif (widget.options["level"]!"") == "secondary">
${""?left_pad(indent)}  <div class="gx-text-secondary gx-fs-12">${widget.options["title"]!"标题"}</div>
    <#elseif (widget.options["level"]!"") == "teriary">
${""?left_pad(indent)}  <div class="gx-text-secondary gx-fs-10">${widget.options["title"]!"标题"}</div>
    <#elseif (widget.options["level"]!"") == "quaternary">
${""?left_pad(indent)}  <div class="gx-text-secondary gx-fs-10">${widget.options["title"]!"标题"}</div>
    </#if>
  </#list>
${""?left_pad(indent)}</div>  
  </#if>
  <#list widgets as widget>
    <#if (widget.options["level"]!"") == "accent">
${""?left_pad(indent)}<div class="gx-ml-auto">
${""?left_pad(indent)}  <div class="gx-fs-16 gx-fb">${widget.options["title"]!"标题"}</div>
${""?left_pad(indent)}</div>  
    </#if>
  </#list>
</#macro>

<#macro print_html_declare_tile_second_row widgets indent> 
  <#list widgets as widget>
    <#if (widget.options["level"]!"") == "quinary">
${""?left_pad(indent)}<div class="d-flex">
${""?left_pad(indent)}  <i class="fas fa-star"></i>
${""?left_pad(indent)}  <span class="ms-auto">${widget.options["title"]!"标题"}</span>
${""?left_pad(indent)}</div>
    <#elseif (widget.options["level"]!"") == "senary">
${""?left_pad(indent)}<div class="d-flex">
${""?left_pad(indent)}  <i class="fas fa-star"></i>
${""?left_pad(indent)}  <span class="ms-auto">${widget.options["title"]!"标题"}</span>
${""?left_pad(indent)}</div>
    <#elseif (widget.options["level"]!"") == "septenary">
${""?left_pad(indent)}<div class="d-flex">
${""?left_pad(indent)}  <i class="fas fa-star"></i>
${""?left_pad(indent)}  <span class="ms-auto">${widget.options["title"]!"标题"}</span>
${""?left_pad(indent)}</div>
    </#if>
  </#list>
</#macro>

<#--
 ###############################################################################
 ### 【工具栏位】
 ###############################################################################
 -->
<#macro print_js_declare_toolbar widget indent>
  <#list widget.widgets as child>
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** ${child.options["note"]!"TODO：此处添加注释"}
${""?left_pad(indent)}*/
${""?left_pad(indent)}dom.bind(this.${js.nameVariable(child.id)}, 'click', ev => {
    <#local url = child.options["url"]!"module/object/action">
${""?left_pad(indent)}  this.${js.nameVariable(guidbase.url_to_method_name(url))}({});
${""?left_pad(indent)}});
  </#list>
</#macro>

<#macro print_js_fields_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_toolbar widget indent>
    <#list widget.widgets as child>
    <#if child.type == "button">
      <#if !child.options??><#continue></#if>
      <#if !child.options["url"]??><#continue></#if>
      <#local url = child.options["url"]>
      <#local params = guidbase.get_params_from_url(url)>
      
/*!
** ${child.options["note"]!"TODO：添加你的注释"}
*/
Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}.prototype.${js.nameVariable(guidbase.url_to_method_name(url))} = function (model) {
      <#if url?substring(0,1) == "#">
  ajax.overlay({
    url: 'html/${guidbase.get_uri_from_url(url)}.html',
    title: model.${js.nameVariable(guidbase.get_object_from_url(url))}Name + '详情',
    success: () => {
      ${js.nameVariable(guidbase.url_to_page_name(url))}.show({
      <#list params as param>
        <#if param?index != 0>
      },{    
        </#if>
        ${param.name}: model.${param.name},
      </#list>
      });
    },
  });    
      <#elseif url?substring(0,1) == "%">
  ajax.sidebar({
    url: 'html/${guidbase.get_uri_from_url(url)}.html',
    title: (model.${js.nameVariable(guidbase.get_object_from_url(url))}Name || '新增') + '信息',
    actions: [{
      title: '保存',
      classes: 'btn btn-sm btn-primary',
      onClick: ev => {
        
      },
    },{
      title: '关闭',
      classes: 'btn btn-sm btn-success',
      onClick: ev => { dom.close('sidebar'); },
    }],
    success: () => {
      ${js.nameVariable(guidbase.url_to_page_name(url))}.show({
      <#list params as param>
        <#if param?index != 0>
      },{    
        </#if>
        ${param.name}: model.${param.name},
      </#list>
      });
    },
  });     
      <#elseif url?substring(0,1) == "^">
  ajax.dialog({
    url: 'html/${guidbase.get_uri_from_url(url)}.html',
    success: () => {
      ${js.nameVariable(guidbase.url_to_page_name(url))}.show({
      <#list params as param>
        <#if param?index != 0>
      },{    
        </#if>
        ${param.name}: model.${param.name},
      </#list>
      });
    },
  });     
      <#else>
  xhr.post({
    url: '${guidbase.get_uri_from_url(url)}',
    params: {
      <#list params as param>
        <#if param?index != 0>
    },{    
        </#if>
      ${param.name}: model.${param.name},
      </#list>
    },
  }).then(data => {
  
  });    
      </#if>
};
    </#if>
  </#list>
</#macro>

<#macro print_html_declare_toolbar widget indent>
  <#list widget.widgets as child>
${""?left_pad(indent)}<a widget-id="${js.nameVariable(child.id)}" class="btn btn-sm btn-outline-primary mr-2">${child.options["title"]!"未定义"}</a>
  </#list>
</#macro>

<#--
 ###############################################################################
 ### 【编辑表单】
 ###############################################################################
 -->
<#macro print_js_declare_editable_form widget indent>
${""?left_pad(indent)}this.${js.nameVariable(widget.id)} = new EditableForm({
${""?left_pad(indent)}  fields:[{
  <#list widget.widgets![] as child>
    <#if !child.id??><#continue></#if>
    <#if child?index != 0>
${""?left_pad(indent)}  },{
    </#if>   
${""?left_pad(indent)}    name: '${js.nameVariable(child.id)}',     
${""?left_pad(indent)}    title: '${child.options["title"]!""}', 
${""?left_pad(indent)}    input: '${child.type}',
<@print_js_declare_editable_form_field_options widget=child indent=indent+4 />
  </#list>
${""?left_pad(indent)}  }],
${""?left_pad(indent)}});
${""?left_pad(indent)}this.${js.nameVariable(widget.id)}.render(this.widget${js.nameType(widget.id)});
</#macro>

<#macro print_js_fields_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_editable_form widget indent>
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_editable_form widget indent>
${""?left_pad(indent)}<div widget-id="widget${js.nameType(widget.id)}" class="gx-p-16"></div>
</#macro>

<#--
 ###############################################################################
 ### 【只读表单】
 ###############################################################################
 -->
<#macro print_js_declare_readonly_form widget indent>
${""?left_pad(indent)}this.${js.nameVariable(widget.id)} = new ReadonlyForm({
${""?left_pad(indent)}  columnCount: 3,
${""?left_pad(indent)}  fields:[{
  <#list widget.widgets![] as child>
    <#if !child.id??><#continue></#if>
    <#if child?index != 0>
${""?left_pad(indent)}  },{
    </#if>   
${""?left_pad(indent)}    name: '${js.nameVariable(child.id)}',     
${""?left_pad(indent)}    title: '${child.options["title"]!""}', 
${""?left_pad(indent)}    input: '${child.type}',
<@print_js_declare_editable_form_field_options widget=child indent=indent+4 />
  </#list>
${""?left_pad(indent)}  }],
${""?left_pad(indent)}});
${""?left_pad(indent)}this.${js.nameVariable(widget.id)}.render(this.widget${js.nameType(widget.id)});
</#macro>

<#macro print_js_fields_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_readonly_form widget indent>
${""?left_pad(indent)}<div widget-id="widget${js.nameType(widget.id)}" class="gx-p-16"></div>
</#macro>

<#--
 ###############################################################################
 ### 【分页页签】
 ###############################################################################
 -->
<#macro print_js_declare_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_tabs widget indent>

</#macro>

<#--
 ###############################################################################
 ### 【通知公告】
 ###############################################################################
 -->
<#macro print_js_declare_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【滚动导航】
 ###############################################################################
 -->
<#macro print_js_declare_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【滑动导航】
 ###############################################################################
 -->
<#macro print_js_declare_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【列表导航】
 ###############################################################################
 -->
<#macro print_js_declare_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_list_navigator widget indent>
  <#if widget.options["width"]??>
${""?left_pad(indent)}<div class="gx-24-${widget.options["width"]} gx-p-8">
    <#local indent = indent + 2>
  </#if>
${""?left_pad(indent)}<div class="card">
  <#if widget.options["title"]?? || gux.has_toolbar_of_widget(widget)>
${""?left_pad(indent)}  <div class="card-header gx-d-flex">
${""?left_pad(indent)}    <strong>${widget.options["title"]!""}</strong>
    <#if gux.has_toolbar_of_widget(widget)>
      <#assign toolbar = gux.get_toolbar_of_widget(widget)>
${""?left_pad(indent)}    <div class="gx-d-flex gx-ml-auto">     
      <#list toolbar.widgets as child> 
${""?left_pad(indent)}      <a widget-id="${js.nameVariable(child.id)}" class="btn btn-sm btn-outline-primary gx-mr-2">${child.options["title"]!"未定义"}</a>
      </#list>
${""?left_pad(indent)}    </div>
    </#if>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div widget-id="widget${js.nameType(widget.id)}" class="card-body">
${""?left_pad(indent)}    <ul class="list-group">
  <#list widget.widgets as child>
${""?left_pad(indent)}      <li class="list-group-item list-group-item-action">
${""?left_pad(indent)}        <div class="gx-w-full gx-d-flex">
${""?left_pad(indent)}          <strong>${child.options["title"]!"标题"}</strong>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}      </li>
  </#list>
${""?left_pad(indent)}    </ul>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
  <#if widget.options["width"]??>
    <#local indent = indent - 2>
${""?left_pad(indent)}</div>  
  </#if>
</#macro>

<#--
 ###############################################################################
 ### 【栅格导航】
 ###############################################################################
 -->
<#macro print_js_declare_grid_navigator widget indent>
  <#list widget.widgets as child>
    <#local url = child.options["url"]>
    <#local method = guidbase.url_to_method_name(url)>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 点击【${child.options["title"]!"标题"}】响应事件。
${""?left_pad(indent)}*/
${""?left_pad(indent)}dom.bind(this.${js.nameVariable(child.id)}, 'click', ev => {
${""?left_pad(indent)}  let model = dom.model(this.${js.nameVariable(child.id)});
${""?left_pad(indent)}  this.${js.nameVariable(method)}(model);
${""?left_pad(indent)}});
  </#list>
</#macro>

<#macro print_js_fields_grid_navigator widget indent>

</#macro>

<#macro print_js_methods_grid_navigator widget indent>
  <#list widget.widgets as child>
    <#local url = child.options["url"]>
    <#local method = guidbase.url_to_method_name(url)>
    <#local container = guidbase.url_to_container(url)>
    <#local pagepath = guidbase.url_to_page_path(url)>
    <#local pagename = guidbase.url_to_page_name(url)>
    <#local params = guidbase.get_params_from_url(url)>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 调用【${child.options["title"]!"标题"}】页面。
${""?left_pad(indent)}*/
${""?left_pad(indent)}Page${js.nameType(guidbase.page_id_to_page_name(widget.page.id))}.prototype.${js.nameVariable(method)} = function (row) {
${""?left_pad(indent)}  ajax.view({
${""?left_pad(indent)}    containerId: this.${js.nameVariable(container)},
${""?left_pad(indent)}    url: 'html/${app.name}/${pagepath}.html',
    <#if child.options["headless"]?? && child.options["headless"] == "true">
${""?left_pad(indent)}    headless: true,    
    </#if>
${""?left_pad(indent)}    success: () => {
${""?left_pad(indent)}      ${js.nameVariable(pagename)}.show({
  <#list params as param>
    <#if param.value??>
${""?left_pad(indent)}        ${js.nameVariable(param.name)}: '${param.value}',      
    <#else>
${""?left_pad(indent)}        ${js.nameVariable(param.name)}: row.${js.nameVariable(param.name)},  
    </#if>
  </#list>
${""?left_pad(indent)}      });
${""?left_pad(indent)}    },
${""?left_pad(indent)}  });
${""?left_pad(indent)}};
  </#list>
</#macro>

<#macro print_html_declare_grid_navigator widget indent>
${""?left_pad(indent)}<div class="gx-d-flex" style="gap: 16px; flex-wrap: wrap;">
  <#list widget.widgets as child>
    <#if child.type != "tile"><#continue></#if>
${""?left_pad(indent)}  <div widget-id="${js.nameVariable(child.id)}" 
${""?left_pad(indent)}       class="gx-b-1 gx-p-8 gx-pointer" 
${""?left_pad(indent)}       style="flex: 0 0 calc(25% - 12px); max-width: calc(25% - 12px);">
<@print_html_declare_tile widgets=child.widgets indent=indent+4 />
${""?left_pad(indent)}  </div>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ###############################################################################
 ### 【事件日历】
 ###############################################################################
 -->
<#macro print_js_declare_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【树型结构】
 ###############################################################################
 -->
<#macro print_js_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【传统列表】
 ###############################################################################
 -->
<#macro print_js_declare_list_view widget indent>
</#macro>

<#macro print_js_fields_list_view widget indent>
</#macro>

<#macro print_js_methods_list_view widget indent>
${""?left_pad(indent)}Page${js.nameType(guidbase.page_id_to_page_name(widget.page.id))}.prototype.buildTile4${js.nameType(widget.page.id)} = function (row) {
<@print_js_declare_tile widgets=widget.widgets indent=indent+2 />
${""?left_pad(indent)}};
</#macro>

<#macro print_html_declare_list_view widget indent>
  <#if widget.options["width"]??>
${""?left_pad(indent)}<div class="gx-24-${widget.options["width"]} gx-p-8">
    <#local indent = indent + 2>
  </#if>
${""?left_pad(indent)}<div class="card">
  <#if widget.options["title"]?? || gux.has_toolbar_of_widget(widget)>
${""?left_pad(indent)}  <div class="card-header gx-d-flex">
${""?left_pad(indent)}    <strong>${widget.options["title"]!""}</strong>
    <#if gux.has_toolbar_of_widget(widget)>
      <#assign toolbar = gux.get_toolbar_of_widget(widget)>
${""?left_pad(indent)}    <div class="gx-d-flex gx-ml-auto">     
      <#list toolbar.widgets as child> 
${""?left_pad(indent)}      <a widget-id="${js.nameVariable(child.id)}" class="btn btn-sm btn-outline-primary gx-mr-2">${child.options["title"]!"未定义"}</a>
      </#list>
${""?left_pad(indent)}    </div>
    </#if>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div widget-id="widget${js.nameType(widget.id)}" class="card-body"></div>
${""?left_pad(indent)}</div>
  <#if widget.options["width"]??>
    <#local indent = indent - 2>
${""?left_pad(indent)}</div>
  </#if>
</#macro>

<#--
 ###############################################################################
 ### 【栅格列表】
 ###############################################################################
 -->
<#macro print_js_declare_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【时间线条】
 ###############################################################################
 -->
<#macro print_js_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页表格】
 ###############################################################################
 -->
<#macro print_js_declare_pagination_table widget indent>
${""?left_pad(indent)}this.${js.nameVariable(widget.id)} = new PaginationTable({
  <#if widget.options["limit"]??>
${""?left_pad(indent)}  limit: ${widget.options["limit"]},
  </#if>
${""?left_pad(indent)}  columns:[{
  <#list widget.widgets![] as child>
    <#if !child.type??><#continue></#if>
    <#if child?index != 0>
${""?left_pad(indent)}  },{
    </#if>    
${""?left_pad(indent)}    title: '${child.options["title"]!""}', 
${""?left_pad(indent)}    style: 'text-align:center;', 
${""?left_pad(indent)}    display: (row, td, colidx, rowidx) => {
<@print_js_declare_pagination_table_column_display widget=child indent=indent+6 />   
${""?left_pad(indent)}    },
  </#list>
${""?left_pad(indent)}  }],
${""?left_pad(indent)}});
${""?left_pad(indent)}this.${js.nameVariable(widget.id)}.render(this.widget${js.nameType(widget.id)});
</#macro>

<#macro print_js_fields_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_pagination_table widget indent>
  <#list widget.widgets as child>
    <#if !child.type??><#continue></#if>
    <#if child.type == "button">
      <#if !child.options??><#continue></#if>
      <#if !child.options["url"]??><#continue></#if>
      <#local url = child.options["url"]>
      <#local params = guidbase.get_params_from_url(url)>
      
/*!
** ${child.options["note"]!"TODO：添加你的注释"}
*/
Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}.prototype.${js.nameVariable(guidbase.url_to_method_name(url))} = function (model) {
      <#if url?substring(0,1) == "#">
  ajax.overlay({
    url: 'html/${guidbase.get_uri_from_url(url)}.html',
    title: model.${js.nameVariable(guidbase.get_object_from_url(url))}Name + '详情',
    success: () => {
      ${js.nameVariable(guidbase.url_to_page_name(url))}.show({
      <#list params as param>
        <#if param?index != 0>
      },{    
        </#if>
        ${param.name}: model.${param.name},
      </#list>
      });
    },
  });    
      <#elseif url?substring(0,1) == "%">
  ajax.sidebar({
    url: 'html/${guidbase.get_uri_from_url(url)}.html',
    title: (model.${js.nameVariable(guidbase.get_object_from_url(url))}Name || '新增') + '信息',
    actions: [{
      title: '保存',
      classes: 'btn btn-sm btn-primary',
      onClick: ev => {
        
      },
    },{
      title: '关闭',
      classes: 'btn btn-sm btn-success',
      onClick: ev => { dom.close('sidebar'); },
    }],
    success: () => {
      ${js.nameVariable(guidbase.url_to_page_name(url))}.show({
      <#list params as param>
        <#if param?index != 0>
      },{    
        </#if>
        ${param.name}: model.${param.name},
      </#list>
      });
    },
  });     
      <#elseif url?substring(0,1) == "^">
  ajax.dialog({
    url: 'html/${guidbase.get_uri_from_url(url)}.html',
    success: () => {
      ${js.nameVariable(guidbase.url_to_page_name(url))}.show({
      <#list params as param>
        <#if param?index != 0>
      },{    
        </#if>
        ${param.name}: model.${param.name},
      </#list>
      });
    },
  });     
      <#else>
  xhr.post({
    url: '${guidbase.get_uri_from_url(url)}',
    params: {
      <#list params as param>
        <#if param?index != 0>
    },{    
        </#if>
      ${param.name}: model.${param.name},
      </#list>
    },
  }).then(data => {
  
  });    
      </#if>
};
    <#else>
<@print_js_methods_pagination_table widget=child indent=indent />
    </#if>
  </#list>
</#macro>

<#macro print_html_declare_pagination_table widget indent>
<#if widget.options["width"]??>
${""?left_pad(indent)}<div class="gx-24-${widget.options["width"]} gx-p-8">
    <#local indent = indent + 2>
  </#if>
${""?left_pad(indent)}<div class="card">
  <#if widget.options["title"]?? || gux.has_toolbar_of_widget(widget)>
${""?left_pad(indent)}  <div class="card-header gx-d-flex">
${""?left_pad(indent)}    <strong>${widget.options["title"]!""}</strong>
    <#if gux.has_toolbar_of_widget(widget)>
      <#assign toolbar = gux.get_toolbar_of_widget(widget)>
${""?left_pad(indent)}    <div class="gx-d-flex gx-ml-auto">     
      <#list toolbar.widgets as child> 
${""?left_pad(indent)}      <a widget-id="${js.nameVariable(child.id)}" class="btn btn-sm btn-outline-primary gx-mr-2">${child.options["title"]!"未定义"}</a>
      </#list>
${""?left_pad(indent)}    </div>
    </#if>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div widget-id="widget${js.nameType(widget.id)}" class="card-body"></div>
${""?left_pad(indent)}</div>
  <#if widget.options["width"]??>
    <#local indent = indent - 2>
${""?left_pad(indent)}</div>
  </#if>
</#macro>

<#--
 ###############################################################################
 ### 【分页栅格】
 ###############################################################################
 -->
<#macro print_js_declare_pagination_grid widget indent>
${""?left_pad(indent)}this.${js.nameVariable(widget.id)} = new PaginationGrid({
${""?left_pad(indent)}  colspan: 6,
${""?left_pad(indent)}  onRender: (container, row, index) => {
${""?left_pad(indent)}    let tile = this.buildTile4${js.nameType(widget.page.id)}(row);
${""?left_pad(indent)}    container.appendChild(tile);
${""?left_pad(indent)}  },
${""?left_pad(indent)}});
${""?left_pad(indent)}this.${js.nameVariable(widget.id)}.render(this.widget${js.nameType(widget.id)});
</#macro>

<#macro print_js_fields_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_pagination_grid widget indent>
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** Builds view for tile item.
${""?left_pad(indent)}*/
${""?left_pad(indent)}Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}.prototype.buildTile4${js.nameType(widget.page.id)} = function (row) {
<@print_js_declare_tile widgets=widget.widgets indent=indent+2 />
${""?left_pad(indent)}};
</#macro>

<#macro print_html_declare_pagination_grid widget indent>
${""?left_pad(indent)}<div widget-id="widget${js.nameType(widget.id)}"></div>
</#macro>

<#--
 ###############################################################################
 ### 【广义表格】
 ###############################################################################
 -->
<#macro print_js_declare_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_spreadsheet widget indent>
${""?left_pad(indent)}<div widget-id="widget${js.nameType(widget.id)}"></div>
</#macro>

<#--
 ###############################################################################
 ### 【看板列表】
 ###############################################################################
 -->
<#macro print_js_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【聊天列表】
 ###############################################################################
 -->
<#macro print_js_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【饼状图】
 ###############################################################################
 -->
<#macro print_js_declare_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【圈状图】
 ###############################################################################
 -->
<#macro print_js_declare_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【柱状图】
 ###############################################################################
 -->
<#macro print_js_declare_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【折线图】
 ###############################################################################
 -->
<#macro print_js_declare_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【堆栈图】
 ###############################################################################
 -->
<#macro print_js_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【雷达图】
 ###############################################################################
 -->
<#macro print_js_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【网络拓扑图】
 ###############################################################################
 -->
<#macro print_js_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【业务流程图】
 ###############################################################################
 -->
<#macro print_js_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>