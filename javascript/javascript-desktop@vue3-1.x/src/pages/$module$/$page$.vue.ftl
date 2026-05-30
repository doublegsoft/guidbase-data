<#import "/$/vue3.ftl" as vue3>
<#import "/$/guidbase4js.ftl" as guidbase4js>
<#assign page = pageDef>
<template>
<@vue3.print_page_layout page=pageDef />
</template>
<script setup>
import { ref, reactive, onMounted, onUnmounted } from 'vue'
<@vue3.print_page_imports page=pageDef />
import sdk from '@/sdk/sdk.js'

// 数据加载状态
const isLoading = ref(true)

<@vue3.print_page_variables page=pageDef />

<@vue3.print_page_methods page=pageDef />

onMounted(async () => {
<#assign visited_widgets = {}>  
<#list page.widgets as widget>
  <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
  <#if (widget.type != "select" && widget.type != "multiselect" && widget.type != "cascade") || (widget.value("data")!"")?starts_with("enum[")><#continue></#if>
  <#if !widget.ancestor("entry_form")??><#continue></#if>
  <#assign visited_widgets += {widget.id: widget}>
  ${js.nameVariable(widget.id)}Options.value = await sdk.fetch${js.nameType(widget.id)}Options();
</#list>
})

onUnmounted(() => {
  
})
</script>

<style scoped>
</style>