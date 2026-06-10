/**
 * ChartBuilder — 从 JS object array 构建 ECharts option
 *
 * 用法（属性名字符串）:
 *   const opt = new ChartBuilder(data)
 *     .type('bar')
 *     .x('month').y('amount').split('category')
 *     .sum()
 *     .title('月度用电量')
 *     .build()
 *
 * data 格式: JS object array
 *   [ { month: '1月', category: '居民', amount: 320 },
 *     { month: '1月', category: '工商业', amount: 180 }, ... ]
 *   x('month')   → '1月', '1月', ...
 *   split('category') → '居民', '工商业', ...
 *   y('amount')  → 320, 180, ...
 */

// ── 设计系统色板 ──
const COLOR_PALETTE = [
  '#1a4f8a', '#0e6655', '#d46b08', '#1e8449', '#6c3483',
  '#c0392b', '#DAA520', '#2980b9', '#8e44ad', '#16a085',
  '#e67e22', '#2c3e50', '#27ae60', '#e74c3c', '#3498db',
]

// ── 默认 echarts 主题 ──
const BASE_GRID = { top: 40, right: 20, bottom: 30, left: 55 }

const BASE_TOOLTIP = { trigger: 'axis' }

const BASE_XAXIS = {
  type: 'category',
  axisLabel: { color: '#5d6d7e', fontSize: 11 },
  axisTick: { alignWithLabel: true },
}

const BASE_YAXIS = {
  type: 'value',
  axisLabel: { color: '#5d6d7e', fontSize: 11 },
  splitLine: { lineStyle: { color: '#e8e8e8' } },
}

/**
 * 聚合函数
 */
const AGGREGATORS = {
  sum:   vals => vals.reduce((a, b) => a + b, 0),
  avg:   vals => vals.reduce((a, b) => a + b, 0) / vals.length,
  max:   vals => Math.max(...vals),
  min:   vals => Math.min(...vals),
  count: vals => vals.length,
}

export class ChartBuilder {
  /**
   * @param {Array<Object>} data — JS object array
   *   例: [{month:'1月',category:'居民',amount:320}, ...]
   */
  constructor(data) {
    this._rows = data ?? []
    this._chartType = 'bar'
    this._xKey = null       // X 轴属性名
    this._yKey = null       // Y 轴属性名
    this._splitKey = null   // 系列拆分属性名
    this._aggName = 'sum'
    this._chartTitle = ''
    this._colors = [...COLOR_PALETTE]
    this._stacked = false
  }

  // ── 链式配置 ──

  /** 图表类型: 'bar' | 'line' | 'pie' */
  type(t) { this._chartType = t; return this }

  /** X 轴属性名 / 分组字段（pie 时为扇区名称字段） */
  x(key) { this._xKey = key; return this }

  /** Y 轴属性名 / 值字段（count 模式时可选） */
  y(key) { this._yKey = key; return this }

  /** 系列拆分属性名（可选，按此字段值拆成多个 bar/line） */
  split(key) { this._splitKey = key; return this }

  /** 图表标题 */
  title(t) { this._chartTitle = t; return this }

  /** 自定义色板 */
  colors(arr) { this._colors = arr; return this }

  /** 柱状图 / 折线图堆叠 */
  stack(v = true) { this._stacked = v; return this }

  // ── 聚合方法 ──

  sum()   { this._aggName = 'sum';   return this }
  avg()   { this._aggName = 'avg';   return this }
  max()   { this._aggName = 'max';   return this }
  min()   { this._aggName = 'min';   return this }
  count() { this._aggName = 'count'; return this }

  // ── 聚合引擎 ──

  /**
   * 对 rows 执行分组聚合（按对象属性名取值）
   * @returns {{ xValues: Array, seriesMap: { [seriesName]: { [xValue]: aggregatedValue } } }}
   */
  _aggregate() {
    const rows = this._rows
    const xk = this._xKey
    const yk = this._yKey
    const sk = this._splitKey
    const aggFn = AGGREGATORS[this._aggName]
    if (!aggFn) throw new Error(`Unknown aggregate: ${r"${this._aggName}"}`)

    // 收集所有 x 值（保持出现顺序）
    const xSet = new Set()
    const groups = {} // { seriesName: { xVal: [values] } }

    for (const row of rows) {
      const xv = xk != null ? row[xk] : '_total'
      const sv = sk != null ? row[sk] : '_default'
      const yv = yk != null ? row[yk] : 1
      xSet.add(xv)
      if (!groups[sv]) groups[sv] = {}
      if (!groups[sv][xv]) groups[sv][xv] = []
      groups[sv][xv].push(Number(yv) || 0)
    }

    const xValues = [...xSet]
    const seriesMap = {}
    for (const [sn, xmap] of Object.entries(groups)) {
      seriesMap[sn] = {}
      for (const [xv, vals] of Object.entries(xmap)) {
        seriesMap[sn][xv] = aggFn(vals)
      }
    }
    return { xValues, seriesMap }
  }

  // ── 构建 echarts option ──

  build() {
    if (this._chartType === 'pie') return this._buildPie()
    return this._buildCartesian()
  }

  /** 构建柱状图 / 折线图 */
  _buildCartesian() {
    const { xValues, seriesMap } = this._aggregate()
    const seriesNames = Object.keys(seriesMap)

    const series = seriesNames.map((name, i) => {
      const data = xValues.map(xv => seriesMap[name][xv] ?? 0)
      const color = this._colors[i % this._colors.length]
      const base = {
        name,
        type: this._chartType,
        data,
        itemStyle: { color },
      }
      if (this._chartType === 'line') {
        base.smooth = true
        base.lineStyle = { color, width: 2 }
        base.symbol = 'circle'
        base.symbolSize = 6
      }
      if (this._chartType === 'bar') {
        base.barMaxWidth = 28
        base.itemStyle = { color, borderRadius: [2, 2, 0, 0] }
      }
      if (this._stacked) {
        base.stack = 'total'
      }
      return base
    })

    const option = {
      title: this._chartTitle ? { text: this._chartTitle, left: 'center', textStyle: { fontSize: 14 } } : undefined,
      tooltip: { ...BASE_TOOLTIP },
      grid: { ...BASE_GRID },
      xAxis: { ...BASE_XAXIS, data: xValues },
      yAxis: { ...BASE_YAXIS },
      series,
    }

    if (seriesNames.length > 1) {
      option.legend = { data: seriesNames, bottom: 0, textStyle: { fontSize: 11, color: '#5d6d7e' } }
      option.grid.bottom = 35
    }

    return option
  }

  /** 构建饼图 */
  _buildPie() {
    const { seriesMap } = this._aggregate()
    const pieData = []
    let ci = 0
    for (const [sn, xmap] of Object.entries(seriesMap)) {
      for (const [xv, val] of Object.entries(xmap)) {
        const label = Object.keys(seriesMap).length > 1 ? ${r"`${sn}·${xv}`"} : String(xv)
        pieData.push({ value: val, name: label, itemStyle: { color: this._colors[ci % this._colors.length] } })
        ci++
      }
    }

    return {
      title: this._chartTitle ? { text: this._chartTitle, left: 'center', textStyle: { fontSize: 14 } } : undefined,
      tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
      legend: { bottom: 0, textStyle: { fontSize: 11, color: '#5d6d7e' } },
      series: [{
        type: 'pie',
        radius: ['45%', '72%'],
        center: ['50%', '48%'],
        data: pieData,
        itemStyle: { borderRadius: 3, borderColor: '#fff', borderWidth: 2 },
        label: { show: false },
        emphasis: { label: { show: true, fontSize: 13, fontWeight: 'bold' } },
      }],
    }
  }
}

/**
 * 快捷函数 — 支持 .bar() / .line() / .pie() 链式语法糖
 *
 * @example
 *   import { createChart } from '@/sdk/chart-builder'
 *   const opt = createChart(data).bar().x(0).y(2).split(1).sum().build()
 */
export function createChart(data) {
  const builder = new ChartBuilder(data)
  return new Proxy(builder, {
    get(target, prop) {
      if (['bar', 'line', 'pie'].includes(prop)) {
        return () => { target.type(prop); return target }
      }
      return target[prop]
    },
  })
}

export default ChartBuilder
