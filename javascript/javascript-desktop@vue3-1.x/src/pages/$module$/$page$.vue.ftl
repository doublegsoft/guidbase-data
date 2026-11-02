<#if (designSystem!"") == "bnrlike">
<#import "/$/vue3-bnrlike.ftl" as vue3>
<#elseif (designSystem!"") == "navypitch">
<#import "/$/vue3-navypitch.ftl" as vue3>
<#elseif (designSystem!"") == "tada">
<#import "/$/vue3-tada.ftl" as vue3>
<#else>
<#import "/$/vue3-default.ftl" as vue3>
</#if>
<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/guidbase4js.ftl" as guidbase4js>
<#assign page = pageDef>
<#global pageVars = {}>
<template>
  <div class="${namespace}-page-body">
<@vue3.print_page_layout page=pageDef indent=4 />
  </div>
<#-- drawers and dialogs -->  
<#list page.widgets as button>
  <#if button.type != "button"><#continue></#if>
  <#assign action = valuebase.action(button.value("action"))>
  <#if !action.type??><#continue></#if>
  <#if action.type.name() == "drawer">
  <${namespace}-drawer v-model="${js.nameVariable(action.resource)}Open">
    <${namespace}-${js.nameFile(action.resource)} />
  </${namespace}-drawer>
    <#elseif action.type.name() == "dialog">
  <${namespace}-dialog v-model="${js.nameVariable(action.resource)}Open" size="lg">
    <${namespace}-${js.nameFile(action.resource)} />
  </${namespace}-dialog>
  </#if>
</#list>
</template>
<script setup>
import { ref, reactive, computed, inject, provide, onMounted, onUnmounted } from 'vue'
import * as echarts from 'echarts'
<@vue3.print_page_imports page=pageDef />
import sdk from '@/sdk/sdk.js'
import { useFeedback } from '@/composables/useFeedback.js'

// 数据加载状态，每页都必须有
const fb = useFeedback()
const isLoading = ref(true)
const props = defineProps({
<#if page.value("data") != "">
  <#assign url = valuebase.url(page.value("data"))>
  <#list url.params as param>
  ${js.nameVariable(param.name)}: null,
  </#list>  
</#if>
})
<@vue3.print_page_variables page=pageDef />
<#list page.widgets as button>
  <#if button.value("action") == ""><#continue></#if>
  <#assign action = valuebase.action(button.value("action"))>
  <#if action.type.name() == "DIALOG" || action.type.name() == "DRAWER">

provide('dialogClose', () => {
  ${java.nameVariable(action.resource)}Open.value = false;
});
  </#if>
</#list>
<@vue3.print_page_methods page=pageDef />

onMounted(async () => {
<#-- 收集整理所有组件 -->
<#assign optionable_widgets = {}>
<#list app.pages as p>
  <#list p.widgets as widget>
    <#if widget.type != "select" && widget.type != "multiselect" && widget.type != "cascade"><#continue></#if>
    <#if widget.value("data") == ""><#continue></#if><#-- 没有定义数据源 -->
    <#if widget.value("data")?contains(":")>
      <#assign opts = typebase.enumtype(widget.value("data"))>
      <#assign optionable_widgets += {widget.id:{"value":opts,"isRef":false}}>
    <#else>
      <#assign ref = typebase.enumref(widget.value("data"))>
      <#assign optionable_widgets += {widget.id:{"value":ref,"isRef":true}}>
    </#if>
  </#list>
</#list>
<#assign visited_widgets = {}>
<#-- 前置加载各个选项枚举值 -->
<#list page.widgets as widget>
  <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
  <#if !optionable_widgets[widget.id]??><#continue></#if>
  <#assign optVal = optionable_widgets[widget.id]>
  <#if widget.type == "select" || widget.type == "multiselect">
    <#if optVal.isRef>
  ${js.nameVariable(widget.id)}Options.value = await sdk.fetch${js.nameType(inflector.pluralize(optVal.value.name))}AsOptions();
    <#else>
  ${js.nameVariable(widget.id)}Options.value = sdk.${js.nameVariable(widget.id)}Options;
    </#if>
  </#if>
</#list>
<#-- 加载页面主要的数据 -->
<#assign visited_widgets = {}>
<#list page.widgets as widget>
  <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
  <#if widget.type == "entry_form" || widget.type == "display_form" || widget.type == "official_form" || 
       widget.type == "hero_card">
  load${js.nameType(widget.id)}Data();
  <#elseif widget.type == "excel_form" || widget.type == "list_view">
  load${js.nameType(widget.id)}Rows();
  <#elseif widget.type == "chart">
  load${js.nameType(widget.id)}Rows();
  <#elseif widget.type == "kpi_chart">
  load${js.nameType(widget.id)}Data();
  </#if>
</#list>
<#-- 后置加载需要根据主要数据加载的选项值 -->
<#list page.widgets as widget>
  <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
  <#if widget.type == "cascade">
    <#assign optRef = typebase.enumref(guidbase.get_data_by_id(widget.id))>
  ${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}OptionLabels = await sdk.fetch${js.nameType(widget.id)}OptionLabels(${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)});
  </#if>
</#list>
})

onUnmounted(() => {
  
})
</script>