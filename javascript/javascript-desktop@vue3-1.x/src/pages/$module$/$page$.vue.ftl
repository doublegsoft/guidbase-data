<#import "/$/vue3.ftl" as vue3>
<#import "/$/guidbase4js.ftl" as guidbase4js>
<#assign page = pageDef>
<template>
<@vue3.print_page_layout page=pageDef />
<#list page.byType("entry_form") as form>
  <ef-feedback v-model="showConfirm${js.nameType(form.id)}Reset" type="confirm" title="提示" message="确定要重置吗？所有已填写的数据将被清空。" @confirm="handle${js.nameType(form.id)}Reset" />
  <ef-feedback v-model="show${js.nameType(form.id)}Error" type="error" title="${form.title}校验未通过" :message="validationErrorMessage" />
</#list>
</template>
<script setup>
import { ref, reactive, onMounted, onUnmounted } from 'vue'
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
  <#if (widget.type == "select" || widget.type == "multiselect" || widget.type == "cascade") && 
       !(widget.value("data")!"")?starts_with("enum[")>
    <#if widget.ancestor("entry_form")?? || widget.ancestor("criteria_form")??>
  ${js.nameVariable(widget.id)}Options.value = await sdk.fetch${js.nameType(widget.id)}Options();  
    </#if>
  <#elseif widget.type == "paged_table">
  load${js.nameType(widget.id)}Rows();
  </#if>
</#list>
})

onUnmounted(() => {
  
})
</script>

<style scoped>
</style>