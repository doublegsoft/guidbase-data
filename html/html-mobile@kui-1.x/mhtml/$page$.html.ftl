<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/appbase.ftl" as appbase>
<div id="page${js.nameType(page.name)}" class="page mobile" style="overflow-x: hidden;">
  <#assign indent = 2>
  <#if page.options?? && page.options.isAlignVerticalCenter?? && page.options.isAlignVerticalCenter == 'T'>
    <#assign indent = 4>
  <div style="margin: 0; position: absolute;
              top: 50%; left: 50%;
              -ms-transform: translate(-50%, -50%);
              transform: translate(-50%, -50%);">
  </#if>
<#list page.widgets as widget>
${""?left_pad(indent)}<div widget-id="widget${js.nameType(widget.variable!'todo')}" class="widget" style="${widget.style!''}">
<@appbase.print_source_code_html snippet="declare" widget=widget indent=indent+2 />
<#--  <#if widget.widgetType == '滚动导航'>-->
<#--<@appbase.print_html_declare_cyclenavigator widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '滑动导航'>-->
<#--<@appbase.print_html_declare_scrollnavigator widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '按钮导航'>-->
<#--<@appbase.print_html_declare_gridnavigator widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '列表导航'>-->
<#--<@appbase.print_html_declare_listnavigator widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '页签导航'>-->
<#--<@appbase.print_html_declare_tabnavigator widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '日历导航'>-->
<#--&lt;#&ndash; 不需要 &ndash;&gt;-->
<#--  <#elseif widget.widgetType == '编辑表单'>-->
<#--<@appbase.print_html_declare_formlayout widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '花式表单'>-->
<#--<@appbase.print_html_declare_styledform widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '只读表单'>-->
<#--<@appbase.print_html_declare_readonlyform widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '统计图表'>-->
<#--<@appbase.print_html_declare_chart widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '通知公告'>-->
<#--<@appbase.print_html_declare_notification widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '主题标题'>-->
<#--<@appbase.print_html_declare_themetitle widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '主题肖像'>-->
<#--<@appbase.print_html_declare_avatar widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '搜索输入'>-->
<#--<@appbase.print_html_declare_searchbox widget=widget indent=indent+2 />-->
<#--  <#elseif widget.widgetType == '空白卡片'>-->
<#--<@appbase.print_html_declare_blankcard widget=widget indent=indent+2 />-->
<#--  </#if>-->
${""?left_pad(indent)}</div>
</#list>
  <#if page.options?? && page.options.isAlignVerticalCenter?? && page.options.isAlignVerticalCenter == 'T'>
    <#assign indent = 6>
  </div>
  </#if>
</div>
<script>
function Page${js.nameType(js.nameType(page.name))}() {
  this.page = dom.find('#page${js.nameType(page.name)}');
}

Page${js.nameType(page.name)}.prototype.initialize = async function (params) {
  dom.init(this, this.page);
<#if page.options?? && page.options.isComponent?? && page.options.isComponent == 'T'>
  dom.height2(this.page, PAGE_OFFSET, document.body);
</#if>
<#if page.options?? && page.options.isAlignVerticalCenter?? && page.options.isAlignVerticalCenter == 'T'>
  dom.autoheight(this.page);
</#if>
<#list page.widgets as widget>
<@appbase.print_source_code_js snippet="declare" widget=widget indent=2 />
<#--  <#if widget.widgetType == '滚动导航'>-->
<#--<@appbase.print_js_declare_cyclenavigator widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '滑动导航'>-->
<#--<@appbase.print_js_declare_scrollnavigator widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '按钮导航'>-->
<#--<@appbase.print_js_declare_gridnavigator widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '列表导航'>-->
<#--<@appbase.print_js_declare_listnavigator widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '页签导航'>-->
<#--<@appbase.print_js_declare_tabnavigator widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '日历导航'>-->
<#--<@appbase.print_js_declare_calendar widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '传统列表' || widget.widgetType == '主题列表'>-->
<#--<@appbase.print_js_declare_listview widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '栅格列表'>-->
<#--<@appbase.print_js_init_gridview widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '时间线条'>-->
<#--<@appbase.print_js_init_timeline widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '编辑表单'>-->
<#--<@appbase.print_js_declare_formlayout widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '花式表单'>-->
<#--<@appbase.print_js_declare_styledform widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '只读表单'>-->
<#--<@appbase.print_js_declare_readonlyform widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '花式表单'>-->
<#--<@appbase.print_js_declare_styledform widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '统计图表'>-->
<#--<@appbase.print_js_declare_chart widget=widget indent=2 />-->
<#--  <#elseif widget.widgetType == '搜索输入'>-->
<#--<@appbase.print_js_init_searchbox widget=widget indent=2 />-->
<#--  </#if>-->
</#list>
};

Page${js.nameType(page.name)}.prototype.destroy = function () {

};

Page${js.nameType(page.name)}.prototype.show = function (params) {
  this.initialize(params);
};

page${js.nameType(page.name)} = new Page${js.nameType(page.name)}();
</script>