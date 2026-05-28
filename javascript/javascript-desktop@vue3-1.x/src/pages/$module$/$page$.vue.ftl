<#import "/$/vue3.ftl" as vue3>
<#import "/$/guidbase4js.ftl" as guidbase4js>
<template>
<@vue3.print_page_layout widget=pageDef />
</template>
<script setup>
import { ref, reactive, onMounted, onUnmounted } from 'vue'
<@vue3.print_page_imports page=pageDef />

// 数据加载状态
const isLoading = ref(true)

<@vue3.print_page_variables page=pageDef />

<@vue3.print_page_methods page=pageDef />

onMounted(() => {
  
})

onUnmounted(() => {
  
})
</script>

<style scoped>
</style>