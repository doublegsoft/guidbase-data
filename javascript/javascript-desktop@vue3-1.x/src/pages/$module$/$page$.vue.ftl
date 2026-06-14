<#if (designSystem!"") == "bnrlike">
<#import "/$/vue3-bnrlike.ftl" as vue3>
<#elseif (designSystem!"") == "navypitch">
<#import "/$/vue3-navypitch.ftl" as vue3>
<#else>
<#import "/$/vue3-bnrlike.ftl" as vue3>
</#if>
<#import "/$/guidbase4js.ftl" as guidbase4js>
<#assign page = pageDef>
<template>
<@vue3.print_page_layout page=pageDef />
</template>
<script setup>
import { ref, reactive, computed, onMounted, onUnmounted } from 'vue'
<@vue3.print_page_imports page=pageDef />
import sdk from '@/sdk/sdk.js'

// 数据加载状态，每页都必须有
const isLoading = ref(true)

<@vue3.print_page_variables page=pageDef />
<@vue3.print_page_methods page=pageDef />

onMounted(async () => {
<#assign visited_widgets = {}>  
<#list page.widgets as widget>
  <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
  <#if (widget.type == "select" || widget.type == "multiselect") && 
       !(widget.value("data")!"")?starts_with("enum[")>
    <#if widget.ancestor("entry_form")?? || widget.ancestor("criteria_form")??>
  ${js.nameVariable(widget.id)}Options.value = await sdk.fetch${js.nameType(inflector.pluralize(widget.value("object",widget.id)))}AsOptions();
    </#if>
  <#elseif widget.type == "entry_form" || widget.type == "display_form">  
  load${js.nameType(widget.id)}Data();
  <#elseif widget.type == "excel_form">
  load${js.nameType(widget.id)}Rows();
  <#elseif widget.type == "chart">
  load${js.nameType(widget.id)}Rows();
  </#if>
</#list>
})

onUnmounted(() => {
  
})
</script>