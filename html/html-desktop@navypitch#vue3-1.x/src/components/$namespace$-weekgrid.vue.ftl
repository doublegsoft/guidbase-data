<template>
  <div class="wg-root">
    <!-- ═══════════ HEADER ═══════════ -->
    <div class="wg-header">
      <div class="wg-header__left">
        <button class="wg-nav-btn" @click="goPrev" title="上一周">‹</button>
        <button class="wg-nav-btn wg-nav-btn--today" @click="goToday">今天</button>
        <button class="wg-nav-btn" @click="goNext" title="下一周">›</button>
        <h3 class="wg-header__title">{{ headerTitle }}</h3>
      </div>
      <div class="wg-header__right">
        <span class="wg-header__week-num">第{{ weekNumber }}周</span>
      </div>
    </div>

    <!-- ═══════════ ALL-DAY ROW ═══════════ -->
    <div v-if="allDayEvents.length" class="wg-allday">
      <div class="wg-allday__gutter">
        <span class="wg-allday__label">全天</span>
      </div>
      <div class="wg-allday__track">
        <div
          v-for="ev in allDayEvents"
          :key="ev.id"
          class="wg-event-chip"
          :class="'wg-event-chip--' + (ev.color || 'teal')"
          @click="$emit('eventClick', ev)"
        >
          <span class="wg-event-chip__dot"></span>
          {{ ev.title }}
        </div>
      </div>
    </div>

    <!-- ═══════════ DAY HEADERS ═══════════ -->
    <div class="wg-day-headers">
      <div class="wg-day-headers__gutter"></div>
      <div
        v-for="day in weekDays"
        :key="day.dateStr"
        class="wg-day-header"
        :class="{
          'wg-day-header--today': day.isToday,
          'wg-day-header--weekend': day.isWeekend,
        }"
      >
        <span class="wg-day-header__name">{{ day.dayName }}</span>
        <span class="wg-day-header__num">{{ day.dayNum }}</span>
      </div>
    </div>

    <!-- ═══════════ TIME GRID ═══════════ -->
    <div class="wg-scroll" ref="scrollRef">
      <div class="wg-grid">
        <!-- Time gutter -->
        <div class="wg-time-col">
          <div
            v-for="h in hourSlots"
            :key="h"
            class="wg-time-slot"
            :class="{ 'wg-time-slot--hour': isWholeHour(h) }"
          >
            <span v-if="isWholeHour(h)" class="wg-time-label">{{ formatHourLabel(h) }}</span>
          </div>
        </div>

        <!-- 7 day columns -->
        <div
          v-for="(day, di) in weekDays"
          :key="day.dateStr"
          class="wg-col"
          :class="{
            'wg-col--today': day.isToday,
            'wg-col--weekend': day.isWeekend,
          }"
          @click="onSlotClick($event, day.date)"
        >
          <!-- Hour cell grid lines -->
          <div
            v-for="h in hourSlots"
            :key="h"
            class="wg-cell"
            :class="{ 'wg-cell--hour': isWholeHour(h) }"
          ></div>

          <!-- Current time indicator -->
          <div
            v-if="day.isToday && nowPercent >= 0"
            class="wg-now"
            :style="{ top: nowPercent + '%' }"
          >
            <div class="wg-now-dot"></div>
          </div>

          <!-- Timed event blocks -->
          <div
            v-for="(ev, ei) in day.events"
            :key="ev.id"
            class="wg-event"
            :class="[
              'wg-event--' + (ev.color || 'teal'),
              { 'wg-event--moment': ev._isMoment }
            ]"
            :style="eventStyle(ev, ei)"
            @click.stop="$emit('eventClick', ev)"
          >
            <div class="wg-event__inner">
              <div v-if="!ev._isMoment" class="wg-event__time">{{ ev._timeLabel }}</div>
              <div class="wg-event__title">
                <span v-if="ev._isMoment" class="wg-event__moment-dot"></span>
                <span v-if="ev._isMoment" class="wg-event__moment-time">{{ ev._timeLabel }}</span>
                {{ ev.title }}
              </div>
              <div v-if="ev.description && !ev._isMoment" class="wg-event__desc">{{ ev.description }}</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- ═══════════ LEGEND ═══════════ -->
    <div class="wg-legend">
      <span class="wg-legend__item">
        <span class="wg-legend__dot wg-legend__dot--teal"></span> 训练
      </span>
      <span class="wg-legend__item">
        <span class="wg-legend__dot wg-legend__dot--amber"></span> 赛事
      </span>
      <span class="wg-legend__item">
        <span class="wg-legend__dot wg-legend__dot--blue"></span> 体能
      </span>
      <span class="wg-legend__item">
        <span class="wg-legend__dot wg-legend__dot--purple"></span> 会议
      </span>
      <span class="wg-legend__item">
        <span class="wg-legend__dot wg-legend__dot--red"></span> 其他
      </span>
      <span class="wg-legend__item">
        <span class="wg-legend__moment-icon">◆</span> 定时/时刻
      </span>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, nextTick } from 'vue'

/* ───────────────────────────────────────────────
   Props
   ─────────────────────────────────────────────── */

const props = defineProps({
  /** Any date within the target week */
  modelValue: { type: Date, default: () => new Date() },
  /** Event objects: { id, title, start, end, allDay, color, description } */
  events: { type: Array, default: () => [] },
  /** First visible hour (0–23) */
  startHour: { type: Number, default: 6 },
  /** Last visible hour (0–23) */
  endHour: { type: Number, default: 22 },
  /** First day of week: 0=Sunday, 1=Monday */
  firstDayOfWeek: { type: Number, default: 1 },
})

const emit = defineEmits([
  'update:modelValue',
  /** @payload { id, title, start, end, allDay, color, description } */
  'eventClick',
  /** @payload { date: Date, hour: number, minute: number } — clicked an empty slot */
  'slotClick',
])

/* ───────────────────────────────────────────────
   Refs
   ─────────────────────────────────────────────── */

const scrollRef = ref(null)

/* ───────────────────────────────────────────────
   Week computation
   ─────────────────────────────────────────────── */

const displayDate = computed({
  get: () => props.modelValue,
  set: (v) => emit('update:modelValue', v),
})

const weekStart = computed(() => {
  const d = new Date(displayDate.value)
  const day = d.getDay()
  const diff = (day - props.firstDayOfWeek + 7) % 7
  d.setDate(d.getDate() - diff)
  d.setHours(0, 0, 0, 0)
  return d
})

const weekEnd = computed(() => {
  const d = new Date(weekStart.value)
  d.setDate(d.getDate() + 6)
  d.setHours(23, 59, 59, 999)
  return d
})

const headerTitle = computed(() => {
  const s = weekStart.value
  const e = weekEnd.value
  if (s.getFullYear() === e.getFullYear()) {
    return ${r"`${s.getFullYear()}年${s.getMonth() + 1}月${s.getDate()}日 – ${e.getMonth() + 1}月${e.getDate()}日`"}
  }
  return ${r"`${s.getFullYear()}年${s.getMonth() + 1}月${s.getDate()}日 – ${e.getFullYear()}年${e.getMonth() + 1}月${e.getDate()}日`"}
})

const weekNumber = computed(() => {
  const ws = weekStart.value
  const jan1 = new Date(ws.getFullYear(), 0, 1)
  const days = Math.floor((ws.getTime() - jan1.getTime()) / (24 * 60 * 60 * 1000))
  return Math.ceil((days + jan1.getDay() + 1) / 7)
})

/* ───────────────────────────────────────────────
   Day columns
   ─────────────────────────────────────────────── */

const weekDaysZH = ['周日', '周一', '周二', '周三', '周四', '周五', '周六']

const weekDays = computed(() => {
  const days = []
  const cursor = new Date(weekStart.value)
  const today = new Date()
  for (let i = 0; i < 7; i++) {
    const d = new Date(cursor)
    days.push({
      date: d,
      dateStr: toDateStr(d),
      dayName: weekDaysZH[d.getDay()],
      dayNum: d.getDate(),
      isToday: sameDay(d, today),
      isWeekend: d.getDay() === 0 || d.getDay() === 6,
      events: getTimedEventsForDay(d),
    })
    cursor.setDate(cursor.getDate() + 1)
  }
  return days
})

/* ───────────────────────────────────────────────
   Event filtering & positioning
   ─────────────────────────────────────────────── */

const weekEvents = computed(() => {
  const ws = weekStart.value
  const we = weekEnd.value
  return props.events.filter((ev) => {
    const s = new Date(ev.start)
    const e = ev.allDay ? new Date(ev.start) : new Date(ev.end)
    return s <= we && e >= ws
  })
})

const allDayEvents = computed(() => weekEvents.value.filter((ev) => ev.allDay))

function getTimedEventsForDay(day) {
  const dayStart = new Date(day)
  dayStart.setHours(0, 0, 0, 0)
  const dayEnd = new Date(day)
  dayEnd.setHours(23, 59, 59, 999)

  return weekEvents.value
    .filter((ev) => {
      if (ev.allDay) return false
      const s = new Date(ev.start)
      const e = new Date(ev.end)
      return s <= dayEnd && e >= dayStart
    })
    .map((ev) => {
      const s = new Date(ev.start)
      const e = new Date(ev.end)

      // Detect moment event: start === end (same timestamp)
      const isMoment = s.getTime() === e.getTime()

      // Effective start/end minutes within this day, clamped to visible range
      let rawStartMin, rawEndMin

      if (sameDay(s, day)) {
        rawStartMin = s.getHours() * 60 + s.getMinutes()
      } else {
        rawStartMin = props.startHour * 60 // event started before this day
      }

      if (sameDay(e, day)) {
        rawEndMin = e.getHours() * 60 + e.getMinutes()
      } else {
        rawEndMin = props.endHour * 60 // event continues past this day
      }

      const startMin = Math.max(rawStartMin, props.startHour * 60)
      let endMin = Math.min(rawEndMin, props.endHour * 60)

      // Moments get a minimum visual height (5 min) so they render as a pill
      const MOMENT_MIN_MINUTES = 5
      if (isMoment) {
        endMin = Math.min(startMin + MOMENT_MIN_MINUTES, props.endHour * 60)
      }

      // Time label
      const timeLabel = isMoment
        ? fmtTimeOnly(s)
        : fmtTimeOnly(s) + (sameDay(s, e) ? ' – ' + fmtTimeOnly(e) : ' →')

      return {
        ...ev,
        _startMin: startMin,
        _endMin: endMin,
        _timeLabel: timeLabel,
        _isMoment: isMoment,
        _isContinued: !sameDay(s, day) || !sameDay(e, day),
      }
    })
    .sort((a, b) => a._startMin - b._startMin)
}

/* ───────────────────────────────────────────────
   Hours & slots
   ─────────────────────────────────────────────── */

const SLOT_HEIGHT_PX = 24 // height per half-hour slot

const totalMin = computed(() => (props.endHour - props.startHour) * 60)

const hourSlots = computed(() => {
  const arr = []
  for (let h = props.startHour; h <= props.endHour; h += 0.5) {
    arr.push(h)
  }
  return arr
})

function isWholeHour(h) {
  return Math.abs(h - Math.floor(h)) < 0.01
}

function formatHourLabel(h) {
  return String(Math.floor(h)).padStart(2, '0') + ':00'
}

/* ───────────────────────────────────────────────
   Current time indicator
   ─────────────────────────────────────────────── */

const isCurrentWeek = computed(() => {
  const today = new Date()
  today.setHours(0, 0, 0, 0)
  const ws = new Date(weekStart.value)
  ws.setHours(0, 0, 0, 0)
  const we = new Date(weekEnd.value)
  we.setHours(23, 59, 59, 999)
  return today >= ws && today <= we
})

const nowPercent = computed(() => {
  if (!isCurrentWeek.value) return -1
  const now = new Date()
  const min = (now.getHours() - props.startHour) * 60 + now.getMinutes()
  if (min < 0 || min > totalMin.value) return -1
  return (min / totalMin.value) * 100
})

/* ───────────────────────────────────────────────
   Event style (top / height in %)
   ─────────────────────────────────────────────── */

function eventStyle(ev, idx) {
  const startMin = ev._startMin
  const endMin = ev._endMin
  const offset = props.startHour * 60
  const top = ((startMin - offset) / totalMin.value) * 100
  const h = ((endMin - startMin) / totalMin.value) * 100

  if (ev._isMoment) {
    // Moment events: fixed compact height, top centers around the time point
    return {
      top: Math.max(0, top).toFixed(2) + '%',
      height: '22px',
      marginTop: '-11px',
    }
  }

  return {
    top: Math.max(0, top).toFixed(2) + '%',
    height: Math.max(0.8, h).toFixed(2) + '%',
  }
}

/* ───────────────────────────────────────────────
   Helpers
   ─────────────────────────────────────────────── */

function sameDay(a, b) {
  return (
    a.getFullYear() === b.getFullYear() &&
    a.getMonth() === b.getMonth() &&
    a.getDate() === b.getDate()
  )
}

function toDateStr(d) {
  return ${r"`${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`"}
}

function fmtTimeOnly(d) {
  return String(d.getHours()).padStart(2, '0') + ':' + String(d.getMinutes()).padStart(2, '0')
}

/* ───────────────────────────────────────────────
   Slot click → emit slotClick with date + time
   ─────────────────────────────────────────────── */

function onSlotClick(event, date) {
  const col = event.currentTarget
  const rect = col.getBoundingClientRect()
  const y = event.clientY - rect.top + (scrollRef.value ? scrollRef.value.scrollTop : 0)

  // Calculate which half-hour slot was clicked
  const slotIdx = Math.floor(y / SLOT_HEIGHT_PX)
  const totalMinutes = props.startHour * 60 + slotIdx * 30

  // Round to nearest half hour
  const rounded = Math.round(totalMinutes / 30) * 30
  const hour = Math.floor(rounded / 60)
  const minute = rounded % 60

  // Clamp to visible range
  if (hour < props.startHour || hour > props.endHour) return
  if (hour === props.endHour && minute > 0) return

  emit('slotClick', { date: new Date(date), hour, minute })
}

/* ───────────────────────────────────────────────
   Navigation
   ─────────────────────────────────────────────── */

function goPrev() {
  const d = new Date(displayDate.value)
  d.setDate(d.getDate() - 7)
  displayDate.value = d
}

function goNext() {
  const d = new Date(displayDate.value)
  d.setDate(d.getDate() + 7)
  displayDate.value = d
}

function goToday() {
  displayDate.value = new Date()
}

/* ───────────────────────────────────────────────
   Auto-scroll to first hour on mount
   ─────────────────────────────────────────────── */

onMounted(() => {
  nextTick(() => {
    if (scrollRef.value) {
      // Scroll to show the first hour at the top
      scrollRef.value.scrollTop = 0
    }
  })
})
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   WEEK GRID — Academy Pro · 7-Day Weekly Time Grid
   Y-axis: hours · X-axis: 7 day columns
   ═══════════════════════════════════════════════════════════════════════════ */

/* ── Local color palette (solid, flat colors) ──── */

.wg-root {
  /* Teal — 训练 */
  --wg-teal-bg:       #CCFBF1;
  --wg-teal-border:   #5EEAD4;
  --wg-teal-text:     #0F766E;
  --wg-teal-dot:      #14B8A6;

  /* Amber — 赛事 */
  --wg-amber-bg:      #FEF3C7;
  --wg-amber-border:  #FDE68A;
  --wg-amber-text:    #92400E;
  --wg-amber-dot:     #F59E0B;

  /* Blue — 体能 */
  --wg-blue-bg:       #DBEAFE;
  --wg-blue-border:   #93C5FD;
  --wg-blue-text:     #1D4ED8;
  --wg-blue-dot:      #3B82F6;

  /* Purple — 会议 */
  --wg-purple-bg:     #EDE9FE;
  --wg-purple-border: #C4B5FD;
  --wg-purple-text:   #6D28D9;
  --wg-purple-dot:    #8B5CF6;

  /* Red — 比赛 */
  --wg-red-bg:        #FEE2E2;
  --wg-red-border:    #FCA5A5;
  --wg-red-text:      #991B1B;
  --wg-red-dot:       #EF4444;

  /* Today accent */
  --wg-today-bg:      #F0FDFA;
  --wg-today-accent:  #14B8A6;

  /* Weekend */
  --wg-weekend-bg:    #F8FAFC;

  /* Root styles */
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-sm);
  overflow: hidden;
  display: flex;
  flex-direction: column;
  max-height: 85vh;
}

/* ── Header ──────────────────────────────────── */

.wg-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: var(--space-7) var(--space-9);
  border-bottom: 1px solid var(--color-border);
  gap: var(--space-7);
  flex-shrink: 0;
}

.wg-header__left {
  display: flex;
  align-items: center;
  gap: var(--space-3);
}

.wg-header__title {
  font-size: var(--text-xl);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  margin: 0 var(--space-6);
  white-space: nowrap;
}

.wg-header__right {
  display: flex;
  align-items: center;
  gap: var(--space-7);
}

.wg-header__week-num {
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
  color: var(--color-text-muted);
  background: var(--color-surface);
  padding: var(--space-2) var(--space-7);
  border-radius: var(--radius-pill);
}

/* Nav buttons */
.wg-nav-btn {
  width: 30px;
  height: 30px;
  border-radius: var(--radius-md);
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  color: var(--color-text-sub);
  cursor: pointer;
  font-size: var(--text-xl);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all var(--transition-fast);
  font-family: inherit;
  line-height: 1;
}

.wg-nav-btn:hover {
  background: var(--wg-teal-bg);
  border-color: var(--wg-teal-border);
  color: var(--wg-teal-dot);
}

.wg-nav-btn--today {
  width: auto;
  padding: 0 var(--space-7);
  font-size: var(--text-base);
  font-weight: var(--weight-semibold);
}

/* ════════════════════════════════════════════════
   ALL-DAY ROW
   ════════════════════════════════════════════════ */

.wg-allday {
  display: flex;
  border-bottom: 1px solid var(--color-border);
  background: var(--color-surface);
  flex-shrink: 0;
}

.wg-allday__gutter {
  width: 55px;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  padding: var(--space-3) var(--space-4);
  border-right: 1px solid var(--color-border);
}

.wg-allday__label {
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  color: var(--color-text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.wg-allday__track {
  flex: 1;
  display: flex;
  flex-wrap: wrap;
  gap: var(--space-3);
  padding: var(--space-4) var(--space-6);
  align-items: center;
}

/* All-day event chips */
.wg-event-chip {
  display: inline-flex;
  align-items: center;
  gap: var(--space-3);
  padding: 2px var(--space-6);
  border-radius: var(--radius-pill);
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
  cursor: pointer;
  transition: box-shadow var(--transition-fast);
  white-space: nowrap;
}

.wg-event-chip:hover {
  box-shadow: var(--shadow-sm);
}

.wg-event-chip--teal   { background: var(--wg-teal-bg);   color: var(--wg-teal-text);   }
.wg-event-chip--amber  { background: var(--wg-amber-bg);  color: var(--wg-amber-text);  }
.wg-event-chip--blue   { background: var(--wg-blue-bg);   color: var(--wg-blue-text);   }
.wg-event-chip--red    { background: var(--wg-red-bg);    color: var(--wg-red-text);    }
.wg-event-chip--purple { background: var(--wg-purple-bg); color: var(--wg-purple-text); }

.wg-event-chip__dot {
  width: 6px;
  height: 6px;
  border-radius: var(--radius-full);
  flex-shrink: 0;
}

.wg-event-chip--teal   .wg-event-chip__dot { background: var(--wg-teal-dot);   }
.wg-event-chip--amber  .wg-event-chip__dot { background: var(--wg-amber-dot);  }
.wg-event-chip--blue   .wg-event-chip__dot { background: var(--wg-blue-dot);   }
.wg-event-chip--red    .wg-event-chip__dot { background: var(--wg-red-dot);    }
.wg-event-chip--purple .wg-event-chip__dot { background: var(--wg-purple-dot); }

/* ════════════════════════════════════════════════
   DAY HEADERS
   ════════════════════════════════════════════════ */

.wg-day-headers {
  display: flex;
  border-bottom: 1px solid var(--color-border);
  background: var(--color-card);
  flex-shrink: 0;
}

.wg-day-headers__gutter {
  width: 55px;
  flex-shrink: 0;
  border-right: 1px solid var(--color-border);
}

.wg-day-header {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: var(--space-5) var(--space-3);
  border-right: 1px solid var(--color-border);
  min-width: 0;
}

.wg-day-header:last-child {
  border-right: none;
}

.wg-day-header--today {
  background: var(--wg-today-bg);
}

.wg-day-header--weekend {
  background: var(--wg-weekend-bg);
}

.wg-day-header--today.wg-day-header--weekend {
  background: var(--wg-today-bg);
}

.wg-day-header__name {
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  color: var(--color-text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.wg-day-header--today .wg-day-header__name {
  color: var(--wg-teal-text);
}

.wg-day-header__num {
  font-size: var(--text-2xl);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  font-variant-numeric: tabular-nums;
  margin-top: 1px;
}

.wg-day-header--today .wg-day-header__num {
  color: var(--wg-today-accent);
}

/* ════════════════════════════════════════════════
   SCROLLABLE GRID BODY
   ════════════════════════════════════════════════ */

.wg-scroll {
  flex: 1;
  overflow-y: auto;
  overflow-x: hidden;
  position: relative;
}

.wg-grid {
  display: flex;
  position: relative;
}

/* ── Time gutter ─────────────────────────────── */

.wg-time-col {
  width: 55px;
  flex-shrink: 0;
  border-right: 1px solid var(--color-border);
  position: sticky;
  left: 0;
  background: var(--color-card);
  z-index: 3;
}

.wg-time-slot {
  height: 24px; /* half-hour */
  display: flex;
  align-items: flex-start;
  justify-content: flex-end;
  padding-right: var(--space-4);
}

.wg-time-label {
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  color: var(--color-text-muted);
  font-variant-numeric: tabular-nums;
  line-height: 1;
  transform: translateY(-7px);
}

/* ── Day columns ─────────────────────────────── */

.wg-col {
  flex: 1;
  position: relative;
  border-right: 1px solid var(--color-border);
  min-width: 0;
}

.wg-col:last-child {
  border-right: none;
}

.wg-col--weekend {
  background: var(--wg-weekend-bg);
}

.wg-col--today {
  background: var(--wg-today-bg);
}

/* ── Hour cell grid lines ────────────────────── */

.wg-cell {
  height: 24px; /* half-hour */
  border-bottom: 1px solid #E2E8F0;
}

.wg-cell--hour {
  border-bottom-color: var(--color-border);
}

/* ── Current time indicator ──────────────────── */

.wg-now {
  position: absolute;
  left: 0;
  right: 0;
  height: 0;
  border-top: 2px solid var(--wg-red-dot);
  z-index: 10;
  pointer-events: none;
}

.wg-now-dot {
  position: absolute;
  left: -6px;
  top: -6px;
  width: 10px;
  height: 10px;
  background: var(--wg-red-dot);
  border-radius: var(--radius-full);
  box-shadow: 0 0 0 3px var(--wg-red-bg);
}

/* ── Event blocks ────────────────────────────── */

.wg-event {
  position: absolute;
  left: 2px;
  right: 2px;
  border-radius: var(--radius-sm);
  border: 1px solid;
  overflow: hidden;
  cursor: pointer;
  transition: box-shadow var(--transition-fast);
  z-index: 5;
  min-height: 18px;
}

.wg-event:hover {
  box-shadow: var(--shadow-sm);
  z-index: 8;
}

.wg-event--teal   { background: var(--wg-teal-bg);   border-color: var(--wg-teal-border);   }
.wg-event--amber  { background: var(--wg-amber-bg);  border-color: var(--wg-amber-border);  }
.wg-event--blue   { background: var(--wg-blue-bg);   border-color: var(--wg-blue-border);   }
.wg-event--red    { background: var(--wg-red-bg);    border-color: var(--wg-red-border);    }
.wg-event--purple { background: var(--wg-purple-bg); border-color: var(--wg-purple-border); }

.wg-event__inner {
  padding: 2px var(--space-4);
  height: 100%;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.wg-event__time {
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  font-variant-numeric: tabular-nums;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.3;
}

.wg-event--teal   .wg-event__time { color: var(--wg-teal-text);   }
.wg-event--amber  .wg-event__time { color: var(--wg-amber-text);  }
.wg-event--blue   .wg-event__time { color: var(--wg-blue-text);   }
.wg-event--red    .wg-event__time { color: var(--wg-red-text);    }
.wg-event--purple .wg-event__time { color: var(--wg-purple-text); }

.wg-event__title {
  font-size: var(--text-xs);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.4;
  margin-top: 1px;
}

.wg-event__desc {
  font-size: var(--text-xs);
  color: var(--color-text-sub);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.3;
  margin-top: 1px;
}

/* ── Moment event (point-in-time) ─────────────── */

.wg-event--moment {
  border-style: dashed;
  border-radius: var(--radius-pill);
  min-height: 20px;
  z-index: 6;
}

.wg-event--moment .wg-event__inner {
  padding: 1px var(--space-5);
  flex-direction: row;
  align-items: center;
  gap: var(--space-3);
  white-space: nowrap;
}

.wg-event__moment-dot {
  width: 6px;
  height: 6px;
  border-radius: var(--radius-full);
  flex-shrink: 0;
}

.wg-event--teal   .wg-event__moment-dot { background: var(--wg-teal-dot);   }
.wg-event--amber  .wg-event__moment-dot { background: var(--wg-amber-dot);  }
.wg-event--blue   .wg-event__moment-dot { background: var(--wg-blue-dot);   }
.wg-event--red    .wg-event__moment-dot { background: var(--wg-red-dot);    }
.wg-event--purple .wg-event__moment-dot { background: var(--wg-purple-dot); }

.wg-event__moment-time {
  font-size: var(--text-xs);
  font-weight: var(--weight-bold);
  font-variant-numeric: tabular-nums;
  flex-shrink: 0;
}

.wg-event--teal   .wg-event__moment-time { color: var(--wg-teal-text);   }
.wg-event--amber  .wg-event__moment-time { color: var(--wg-amber-text);  }
.wg-event--blue   .wg-event__moment-time { color: var(--wg-blue-text);   }
.wg-event--red    .wg-event__moment-time { color: var(--wg-red-text);    }
.wg-event--purple .wg-event__moment-time { color: var(--wg-purple-text); }

.wg-event--moment .wg-event__title {
  font-size: var(--text-xs);
  margin-top: 0;
}

/* ════════════════════════════════════════════════
   LEGEND
   ════════════════════════════════════════════════ */

.wg-legend {
  display: flex;
  gap: var(--space-9);
  padding: var(--space-5) var(--space-9);
  border-top: 1px solid var(--color-border);
  background: var(--color-surface);
  flex-shrink: 0;
  flex-wrap: wrap;
}

.wg-legend__item {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  font-size: var(--text-sm);
  color: var(--color-text-sub);
}

.wg-legend__dot {
  width: 8px;
  height: 8px;
  border-radius: var(--radius-full);
  flex-shrink: 0;
}

.wg-legend__dot--teal   { background: var(--wg-teal-dot);   }
.wg-legend__dot--amber  { background: var(--wg-amber-dot);  }
.wg-legend__dot--blue   { background: var(--wg-blue-dot);   }
.wg-legend__dot--purple { background: var(--wg-purple-dot); }
.wg-legend__dot--red    { background: var(--wg-red-dot);    }

.wg-legend__moment-icon {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  line-height: 1;
}
</style>
