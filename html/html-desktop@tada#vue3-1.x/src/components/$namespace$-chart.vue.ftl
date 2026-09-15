<template>
  <div ref="chartRef" class="pt-chart" :style="{ height: height }"></div>
</template>

<script setup>
import { ref, watch, onMounted, onBeforeUnmount, nextTick, shallowRef } from 'vue'
import * as echarts from 'echarts'

const props = defineProps({
  option:  { type: Object, required: true },
  height:  { type: String, default: '300px' },
})

const emit = defineEmits(['ready'])

const chartRef = ref(null)
const instance = shallowRef(null)

function initChart() {
  if (!chartRef.value) return
  disposeChart()
  const inst = echarts.init(chartRef.value)
  inst.setOption(props.option)
  instance.value = inst
  emit('ready', inst)
}

function disposeChart() {
  if (instance.value && !instance.value.isDisposed()) {
    instance.value.dispose()
  }
  instance.value = null
}

function resize() {
  instance.value?.resize()
}

// 监听 option 变化
watch(() => props.option, (opt) => {
  if (instance.value && !instance.value.isDisposed()) {
    instance.value.setOption(opt, true)
  }
}, { deep: true })

onMounted(() => {
  nextTick(() => initChart())
})

onBeforeUnmount(() => {
  disposeChart()
})

// 监听窗口 resize
let _resizeHandler
onMounted(() => {
  _resizeHandler = () => resize()
  window.addEventListener('resize', _resizeHandler)
})
onBeforeUnmount(() => {
  window.removeEventListener('resize', _resizeHandler)
})

defineExpose({
  getInstance: () => instance.value,
  resize,
})
</script>

<style scoped>
.pt-chart {
  width: 100%;
  flex-shrink: 0;
}
</style>
