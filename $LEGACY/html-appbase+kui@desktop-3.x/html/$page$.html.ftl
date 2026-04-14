<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/appbase.ftl" as appbase>
<#if page.options.pageType == 'VIEW'>
<div id="page${js.nameType(page.name)}" class="page view">
${page.html}
</div>
<#elseif page.options.pageType == 'SIDEBAR'>
<div id="page${js.nameType(page.name)}" class="page side">
  <div class="card card-body row mx-0">
${page.html}
  </div>
</div>
<#elseif page.options.pageType == 'OVERLAY' || page.options.pageType == 'SHADE'>
<div id="page${js.nameType(page.name)}" class="page overlay">
  <a widget-id="buttonClose" class="position-absolute pointer"
     style="right: 0; top: 0; margin-top: 4px; margin-right: 6px;">
    <span class="material-symbols-outlined" style="color: var(--color-white); font-size: 36px;">close</span>
  </a>
  <div class="card card-body mb-0">
${page.html}
  </div>
</div>
<#elseif page.options.pageType == 'DIALOG'>
<div id="page${js.nameType(page.name)}" class="page dialog">
${page.html}
  <div class="position-absolute full-width px-2" style="bottom: 0; height: 42px;">
    <button widget-id="buttonClose" class="btn btn-close" style="float: right; margin-right: 16px;">关  闭</button>
    <button widget-id="buttonConfirm" class="btn btn-save" style="float: right; margin-right: 16px;">确  定</button>
  </div>
</div>
</#if>
<script>
function Page${js.nameType(js.nameType(page.name))}() {
  this.page = dom.find('#page${js.nameType(page.name)}');
}

Page${js.nameType(page.name)}.prototype.initialize = async function (params) {
  dom.init(this, this.page);
<#if page.options.pageType == 'DIALOG'>
  // 高度调整
  let layerContent = document.querySelector('.layui-layer-content');
  <#list page.widgets as widget>
    <#if widget.widgetType == 'Row'><#continue></#if>
  dom.autoheight(this.widget${js.nameType(widget.variable)}, layerContent, 64);
  </#list>
<#elseif page.options.pageType == 'SIDEBAR'>
  // 页面高度设置
  dom.autoheight(this.page/*, document.body, 64*/);
<#elseif page.options.pageType == 'OVERLAY'>
  // 页面高度设置
  dom.autoheight(this.page.children[1], document.body, 64);
</#if>
<#if page.options.pageType == 'DIALOG'>
  this.onSave = params.onSave;
</#if>
<#list page.widgets![] as widget>
  <#if widget.widgetType == 'FormLayout'>
<@appbase.print_js_declare_formlayout widget=widget indent=2 />
  <#elseif widget.widgetType == 'ReadonlyForm'>
<@appbase.print_js_declare_readonlyform widget=widget indent=2 />
  <#elseif widget.widgetType == 'PaginationTable'>
<@appbase.print_js_declare_paginationtable widget=widget indent=2 />
  <#elseif widget.widgetType == 'PaginationGrid'>
<@appbase.print_js_declare_paginationgrid widget=widget indent=2 />
  <#elseif widget.widgetType == 'ListView'>
<@appbase.print_js_declare_listview widget=widget indent=2 />
  <#elseif widget.widgetType == 'Timeline'>
<@appbase.print_js_declare_timeline widget=widget indent=2 />
  <#elseif widget.widgetType == 'Tabs'>
<@appbase.print_js_declare_tabs widget=widget indent=2 />
  <#elseif widget.widgetType == 'Calendar'>
<@appbase.print_js_declare_calendar widget=widget indent=2 />
  <#elseif widget.widgetType == 'AOW'>
<@appbase.print_js_declare_AOW widget=widget indent=2 />
  <#elseif widget.widgetType == 'SURD'>
<@appbase.print_js_declare_SURD widget=widget indent=2 />
  <#elseif widget.widgetType == 'GIM'>
<@appbase.print_js_declare_GIM widget=widget indent=2 />
  </#if>
</#list>
<#-- 放置在此处，优化代码顺序 -->
<#list page.widgets![] as widget>
  <#if widget.widgetType == 'TitleBar'>
<@appbase.print_js_declare_titlebar widget=widget indent=2 />
  <#elseif widget.widgetType == 'Separator'>
<@appbase.print_js_declare_separator widget=widget indent=2 />
  </#if>
</#list>
<#-- 固定按钮 -->
<#if page.options.pageType == 'OVERLAY'>

  dom.bind(this.buttonClose, 'click', ev => {
    this.page.parentElement.remove();
  });
<#elseif page.options.pageType == 'DIALOG'>

  this.layerIndex = layer.index;

  dom.bind(this.buttonClose, 'click', ev => {
    layer.close(this.layerIndex);
  });

  dom.bind(this.buttonConfirm, 'click', ev => {
    if (this.confirm() === true) {
      layer.close(this.layerIndex);
    }
  });
</#if>
};
<#if page.options.pageType == 'VIEW'>
<#elseif page.options.pageType == 'DIALOG'>

Page${js.nameType(page.name)}.prototype.confirm = function () {
  /*!
  ** 封装弹出页的数据
  */
  <#list page.widgets as widget>
    <#if widget.widgetType == 'ListView' && widget.checkable?? && widget.checkable == true>
  let data = this.list${js.nameType(widget.variable!'todo')}.getCheckedValues();
    <#elseif widget.widgetType == "FormLayout">
  let errors = Validation.validate(this.widget${js.nameType(widget.variable!'todo')});
  if (errors.length > 0) {
    dialog.error(utils.message(errors));
    return false;
  }
  let data = this.form${js.nameType(widget.variable!'todo')}.getData();
    </#if>
  </#list>
  // 调用调用页面的API返回数据
  if (this.onSave) {
    this.onSave(data);
  }
  return true;
};
</#if>
<#list page.widgets![] as widget>
  <#if widget.widgetType == "FormLayout">
<@appbase.print_js_methods_formlayout page=page widget=widget indent=0 />
  <#elseif widget.widgetType == "ReadonlyForm">
<@appbase.print_js_methods_readonlyform page=page widget=widget indent=0 />
  <#elseif widget.widgetType == "PaginationTable">
<@appbase.print_js_methods_paginationtable page=page widget=widget indent=0 />
  <#elseif widget.widgetType == "PaginationGrid">
<@appbase.print_js_methods_paginationgrid page=page widget=widget indent=0 />
  <#elseif widget.widgetType == "ListView">
<@appbase.print_js_methods_listview page=page widget=widget indent=0 />
  <#elseif widget.widgetType == "Timeline">
<@appbase.print_js_methods_timeline page=page widget=widget indent=0 />
  <#elseif widget.widgetType == "Calendar">
<@appbase.print_js_methods_calendar page=page widget=widget indent=0 />
  <#elseif widget.widgetType == 'AOW'>
<@appbase.print_js_methods_AOW page=page widget=widget indent=0 />
  <#elseif widget.widgetType == "SURD">
<@appbase.print_js_methods_SURD page=page widget=widget indent=0 />
<#elseif widget.widgetType == "GIM">
<@appbase.print_js_methods_GIM page=page widget=widget indent=0 />
  </#if>
</#list>

Page${js.nameType(page.name)}.prototype.destroy = function () {
<#list page.widgets as widget>
  <#if widget.widgetType == "PaginationTable" ||
       widget.widgetType == "PaginationGrid">
    <#if !widget.rootWrapper??><#continue></#if>
    <#assign rootObj = widget.rootWrapper.object>
  delete PubSub("${page.applicationName}/${rootObj.getLabelledOptions("name")["module"]}/${rootObj.name}/saved");
  </#if>
</#list>
  delete page${js.nameType(page.name)};
};

Page${js.nameType(page.name)}.prototype.show = function (params) {
  params = params || {};
  this.initialize(params);
};

page${js.nameType(page.name)} = new Page${js.nameType(page.name)}();
</script>