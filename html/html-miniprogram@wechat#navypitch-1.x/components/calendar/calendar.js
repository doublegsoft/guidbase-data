/**
 * 日历组件 — 月视图(网格) / 周视图(7天横排选择)
 */
const WDS = ['日', '一', '二', '三', '四', '五', '六'];

function pad(n) { return n < 10 ? '0' + n : '' + n; }
function fmt(d) { return d.getFullYear() + '-' + pad(d.getMonth() + 1) + '-' + pad(d.getDate()); }
function parse(str) { var p = str.split('-'); return new Date(+p[0], +p[1] - 1, +p[2]); }
function dim(y, m) { return new Date(y, m + 1, 0).getDate(); }
function fdom(y, m) { return new Date(y, m, 1).getDay(); }

function weekRange(date) {
  var d = new Date(date);
  var day = d.getDay();
  var s = new Date(d); s.setDate(d.getDate() - day);
  var e = new Date(s); e.setDate(s.getDate() + 6);
  return { start: s, end: e };
}

function buildMonthGrid(y, m, today) {
  var total = dim(y, m), first = fdom(y, m), cells = [];
  var pm = m === 0 ? 11 : m - 1, py = m === 0 ? y - 1 : y;
  var pt = dim(py, pm);
  for (var i = first - 1; i >= 0; i--) {
    var dd = pt - i;
    cells.push({ date: py + '-' + pad(pm + 1) + '-' + pad(dd), day: dd, cur: false, today: false });
  }
  for (var d = 1; d <= total; d++) {
    var ds = y + '-' + pad(m + 1) + '-' + pad(d);
    cells.push({ date: ds, day: d, cur: true, today: ds === today });
  }
  var rem = 42 - cells.length;
  var nm = m === 11 ? 0 : m + 1, ny = m === 11 ? y + 1 : y;
  for (var d2 = 1; d2 <= rem; d2++) {
    cells.push({ date: ny + '-' + pad(nm + 1) + '-' + pad(d2), day: d2, cur: false, today: false });
  }
  return cells;
}

function buildWeekDays(date, today) {
  var r = weekRange(date), s = r.start, days = [];
  for (var i = 0; i < 7; i++) {
    var d = new Date(s); d.setDate(s.getDate() + i);
    var ds = fmt(d);
    days.push({ date: ds, day: d.getDate(), month: d.getMonth() + 1, wd: WDS[i], today: ds === today, we: i === 0 || i === 6 });
  }
  return days;
}

function groupEvents(events) {
  var map = {};
  (events || []).forEach(function (ev) {
    var k = ev.date;
    if (!map[k]) map[k] = [];
    map[k].push(ev);
  });
  return map;
}

Component({
  properties: {
    events: { type: Array, value: [], observer: '_onEv' },
    defaultView: { type: String, value: 'week' },
    value: { type: String, value: '', observer: '_onVal' },
    /**
     * 周视图每个日期下方自定义内容
     * 格式: { "2026-06-30": [{ text: "3场", color: "teal" }], ... }
     * color 可选: teal | amber | red | blue | purple
     */
    weekDayExtras: { type: Object, value: {} }
  },
  data: {
    view: 'week',
    cy: 2026, cm: 6, today: '', sel: '',
    monthCells: [],
    weekDays: [],
    eventMap: {},
    title: '',
    sub: '',
    wds: WDS
  },
  lifetimes: {
    attached: function () {
      var now = new Date(), today = fmt(now);
      var view = this.properties.defaultView || 'week';
      this.setData({ today: today, view: view, cy: now.getFullYear(), cm: now.getMonth(), sel: today });
      this._refresh();
      this._title();
    }
  },
  methods: {
    _onEv: function (nv) { this.setData({ eventMap: groupEvents(nv) }); },
    _onVal: function (nv) {
      if (nv && nv !== this.data.sel) {
        this.setData({ sel: nv });
        var d = parse(nv);
        this.setData({ cy: d.getFullYear(), cm: d.getMonth() });
        this._refresh();
        this._title();
      }
    },
    _refresh: function () {
      var d = this.data;
      if (d.view === 'month') {
        this.setData({ monthCells: buildMonthGrid(d.cy, d.cm, d.today) });
      } else {
        var anchor = d.sel ? parse(d.sel) : new Date();
        this.setData({ weekDays: buildWeekDays(anchor, d.today) });
      }
    },
    _title: function () {
      var d = this.data;
      if (d.view === 'month') {
        this.setData({ title: d.cy + '年 ' + (d.cm + 1) + '月', sub: '' });
      } else if (d.weekDays.length === 7) {
        var s = d.weekDays[0], e = d.weekDays[6];
        this.setData({ title: d.cy + '年', sub: s.month + '月' + s.day + '日 - ' + e.month + '月' + e.day + '日' });
      }
    },
    handlePrev: function () {
      var d = this.data;
      if (d.view === 'month') {
        var nm = d.cm === 0 ? 11 : d.cm - 1;
        var ny = d.cm === 0 ? d.cy - 1 : d.cy;
        this.setData({ cy: ny, cm: nm });
      } else {
        var anchor = d.sel ? parse(d.sel) : new Date();
        anchor.setDate(anchor.getDate() - 7);
        this.setData({ sel: fmt(anchor) });
      }
      this._refresh(); this._title();
      this.triggerEvent('datechange', { year: this.data.cy, month: this.data.cm, view: d.view });
    },
    handleNext: function () {
      var d = this.data;
      if (d.view === 'month') {
        var nm = d.cm === 11 ? 0 : d.cm + 1;
        var ny = d.cm === 11 ? d.cy + 1 : d.cy;
        this.setData({ cy: ny, cm: nm });
      } else {
        var anchor = d.sel ? parse(d.sel) : new Date();
        anchor.setDate(anchor.getDate() + 7);
        this.setData({ sel: fmt(anchor) });
      }
      this._refresh(); this._title();
      this.triggerEvent('datechange', { year: this.data.cy, month: this.data.cm, view: d.view });
    },
    handleToday: function () {
      var now = new Date(), today = fmt(now);
      this.setData({ cy: now.getFullYear(), cm: now.getMonth(), sel: today, today: today });
      this._refresh(); this._title();
    },
    handleToggle: function () {
      var nv = this.data.view === 'month' ? 'week' : 'month';
      this.setData({ view: nv });
      this._refresh(); this._title();
      this.triggerEvent('viewchange', { view: nv });
    },
    handleDayTap: function (e) {
      var date = e.currentTarget.dataset.date;
      if (!date) return;
      var d = parse(date);
      if (d.getMonth() !== this.data.cm || d.getFullYear() !== this.data.cy) {
        this.setData({ cy: d.getFullYear(), cm: d.getMonth() });
      }
      this.setData({ sel: date });
      this._refresh(); this._title();
      this.triggerEvent('dayclick', { date: date });
    },
    handleEventTap: function (e) {
      this.triggerEvent('eventclick', { event: e.currentTarget.dataset.event });
    }
  }
});
