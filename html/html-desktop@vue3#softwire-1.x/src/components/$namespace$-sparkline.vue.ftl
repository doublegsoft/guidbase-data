<template>
  <div ref="chartRef" class="${namespace}-sparkline" :style="{ height: height }"></div>
</template>

<script setup>
import { ref, watch, onMounted, onBeforeUnmount, nextTick, shallowRef, computed } from 'vue'
import * as echarts from 'echarts'

const props = defineProps({
  // 核心走势数据: 如 [68, 70, 72, 71, 75, 76, 78.4]
  data: { 
    type: Array, 
    default: () => [] 
  },
  // 图表类型: 'line' | 'bar'
  type: { 
    type: String, 
    default: 'line' 
  },
  // 主题色，默认取 BNR 经典蓝，柱状图可传 '#1e8449' 或从外部传
  color: { 
    type: String, 
    default: '#1a4f8a' 
  },
  // 对应 x 轴时间标签（可选）
  dates: { 
    type: Array, 
    default: () => ['周一', '周二', '周三', '周四', '周五', '周六', '今日'] 
  },
  // 提示框单位
  unit: { 
    type: String, 
    default: '' 
  },
  // 容器高度，默认 48px
  height: { 
    type: String, 
    default: '48px' 
  },
  // 支持传递额外的 ECharts option 进行深度覆盖
  extraOption: { 
    type: Object, 
    default: () => ({}) 
  }
})

const emit = defineEmits(['ready'])

const chartRef = ref(null)
const instance = shallowRef(null)

// 自动化装配极简 Sparkline Option
const chartOption = computed(() => {
  const isBar = props.type === 'bar'

  const seriesItem = {
    type: props.type,
    data: props.data,
    ...(isBar ? {
      barWidth: '60%',
      itemStyle: {
        color: props.color,
        borderRadius: [1, 1, 0, 0]
      }
    } : {
      smooth: true,
      showSymbol: false,
      symbolSize: 4,
      lineStyle: { width: 1.5, color: props.color },
      itemStyle: { color: props.color },
      areaStyle: {
        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
          { offset: 0, color: hexToRgba(props.color, 0.28) },
          { offset: 1, color: hexToRgba(props.color, 0.00) }
        ])
      }
    })
  }

  const baseOption = {
    grid: { 
      top: 2, 
      bottom: 2, 
      left: 2, 
      right: 2 
    },
    xAxis: {
      type: 'category',
      show: false,
      data: props.dates
    },
    yAxis: {
      type: 'value',
      show: false,
      min: 'dataMin'
    },
    tooltip: {
      trigger: 'axis',
      confine: true,
      padding: [3, 6],
      textStyle: { fontSize: 11, fontFamily: 'Consolas, monospace' },
      formatter: function(params) {
        if (!params || !params.length) return ''
        const p = params[0]
        return p.name + ': <b>' + p.value + '</b> ' + props.unit
      }
    },
    series: [seriesItem]
  }

  // 深度合并外部传入的额外选项
  return Object.assign({}, baseOption, props.extraOption)
})

// 十六进制颜色转 rgba 工具函数
function hexToRgba(hex, alpha) {
  if (!hex || !hex.startsWith('#')) return 'rgba(26, 79, 138, ' + alpha + ')'
  let c = hex.slice(1)
  if (c.length === 3) c = c.split('').map(x => x + x).join('')
  const num = parseInt(c, 16)
  return 'rgba(' + ((num >> 16) & 255) + ', ' + ((num >> 8) & 255) + ', ' + (num & 255) + ', ' + alpha + ')'
}

function initChart() {
  if (!chartRef.value) return
  disposeChart()
  const inst = echarts.init(chartRef.value)
  inst.setOption(chartOption.value)
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

// 监听数据与选项联动更新
watch(chartOption, (opt) => {
  if (instance.value && !instance.value.isDisposed()) {
    instance.value.setOption(opt, true)
  }
}, { deep: true })

let _resizeHandler
onMounted(() => {
  nextTick(() => initChart())
  _resizeHandler = () => resize()
  window.addEventListener('resize', _resizeHandler)
})

onBeforeUnmount(() => {
  disposeChart()
  if (_resizeHandler) {
    window.removeEventListener('resize', _resizeHandler)
  }
})

defineExpose({
  getInstance: () => instance.value,
  resize,
})
</script>

<style scoped>
.${namespace}-sparkline {
  width: 100%;
  flex-shrink: 0;
  margin-top: auto;
  box-sizing: border-box;
}
</style>