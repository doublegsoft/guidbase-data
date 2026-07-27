/**
 * 儿童教育应用 — 首页
 *
 * 颜色体系：primary=橙(brand) success=绿(语文) purple=紫(英语) teal=青(科学) danger=玫红(PK)
 */
@Entry
@Component
struct HomePage {

  private weekDays: DayDot[] = [
    { label: '一', done: true }, { label: '二', done: true },
    { label: '三', done: true }, { label: '四', done: true },
    { label: '五', done: false, isToday: true },
    { label: '六', done: false }, { label: '日', done: false }
  ]

  private subjects: SubjectItem[] = [
    { name: '数学', progress: 72, bar: $r('app.color.primary'), barBg: $r('app.color.warning_bg'), card: $r('app.color.warning_bg'), iconBg: $r('app.color.primary_border'), iconText: '🔢', meta: '72% · 今日剩 2 题' },
    { name: '语文', progress: 88, bar: $r('app.color.success'), barBg: $r('app.color.success_bg'), card: $r('app.color.success_bg'), iconBg: $r('app.color.success_border'), iconText: '📖', meta: '88% · 已完成' },
    { name: '英语', progress: 45, bar: $r('app.color.purple'), barBg: $r('app.color.purple_bg'), card: $r('app.color.purple_bg'), iconBg: $r('app.color.purple_border'), iconText: '🔤', meta: '45% · 单词练习' },
    { name: '科学', progress: 30, bar: $r('app.color.teal'), barBg: $r('app.color.teal_bg'), card: $r('app.color.teal_bg'), iconBg: $r('app.color.teal_border'), iconText: '🔬', meta: '30% · 新单元' }
  ]

  private courses: CourseItem[] = [
    { name: '分数的加减法', sub: '数学 · 第 5 章', progress: '72%', bg: $r('app.color.primary_bg'), icon: '🧮', tagBg: $r('app.color.primary_bg'), tagColor: $r('app.color.primary_dark'), btn: $r('app.color.primary') },
    { name: 'Unit 4 单词速记', sub: '英语 · 词汇练习', progress: '45%', bg: $r('app.color.purple_bg'), icon: '📝', tagBg: $r('app.color.purple_bg'), tagColor: $r('app.color.purple'), btn: $r('app.color.purple') },
    { name: '植物的生长过程', sub: '科学 · 新单元', progress: '新', bg: $r('app.color.teal_bg'), icon: '🌱', tagBg: $r('app.color.teal_bg'), tagColor: $r('app.color.teal'), btn: $r('app.color.teal') }
  ]

  private tools: ToolItem[] = [
    { icon: '✏️', label: '练习题', bg: $r('app.color.primary_bg'), fg: $r('app.color.primary_dark') },
    { icon: '🃏', label: '单词卡', bg: $r('app.color.purple_bg'), fg: $r('app.color.purple') },
    { icon: '🎤', label: '口语练习', bg: $r('app.color.teal_bg'), fg: $r('app.color.teal') },
    { icon: '⭐', label: '我的奖励', bg: $r('app.color.primary_hover'), fg: $r('app.color.primary_dark') },
    { icon: '👥', label: '好友 PK', bg: $r('app.color.danger_bg'), fg: $r('app.color.danger') },
    { icon: '📈', label: '学习报告', bg: $r('app.color.success_bg'), fg: $r('app.color.success') },
    { icon: '📅', label: '学习计划', bg: $r('app.color.purple_bg'), fg: $r('app.color.purple') },
    { icon: '⋯', label: '更多', bg: $r('app.color.border_light'), fg: $r('app.color.text_light') }
  ]

  @State activeTab: number = 0
  private tabs: TabItem[] = [
    { icon: '🏠', label: '首页' }, { icon: '📚', label: '课程' },
    { icon: '🏆', label: '成就' }, { icon: '👤', label: '我的' }
  ]

  @State greeting: string = '今天学了吗？'

  build() {
    Column() {
      Row().width('100%').height(44)
      this.buildHeader()
      Scroll() {
        Column() {
          Column() { this.buildStreakBar() }
            .width('100%').padding({ left: 18, right: 18, top: 6, bottom: 6 })

          Column() { this.buildSubjectGrid() }
            .width('100%').padding({ left: 18, right: 18, bottom: 6 })

          Column() { this.buildChallenge() }
            .width('100%').padding({ left: 18, right: 18, bottom: 6 })

          this.buildSectionTitle('继续学习', '全部课程 →')

          Column() { this.buildCourseList() }
            .width('100%').padding({ left: 18, right: 18, bottom: 8 })

          this.buildSectionTitle('学习工具', '')

          Column() { this.buildToolsGrid() }
            .width('100%').padding({ left: 18, right: 18, bottom: 8 })

          Row().width('100%').height(16)
        }.width('100%').alignItems(HorizontalAlign.Start)
      }
      .width('100%').layoutWeight(1)
      .backgroundColor($r('app.color.bg_page')).scrollBar(BarState.Off)

      this.buildTabBar()
    }
    .width('100%').height('100%').backgroundColor($r('app.color.bg_page'))
  }

  @Builder
  buildHeader() {
    Row() {
      Row({ space: 10 }) {
        Row() { Text('😊').fontSize(20) }
          .width(38).height(38).borderRadius(19)
          .backgroundColor($r('app.color.primary_bg'))
          .border({ width: 2, color: $r('app.color.primary_border') })
          .justifyContent(FlexAlign.Center)
        Column({ space: 1 }) {
          Text(this.greeting).fontSize(12).fontColor($r('app.color.text_muted'))
          Text('小明同学').fontSize(15).fontColor($r('app.color.text')).fontWeight(FontWeight.Medium)
        }.alignItems(HorizontalAlign.Start)
      }
      Blank()
      Row({ space: 12 }) { Text('🔍').fontSize(17); Text('🔔').fontSize(17) }
    }.width('100%').padding({ left: 18, right: 18, top: 6, bottom: 14 })
  }

  @Builder
  buildStreakBar() {
    Row() {
      Row({ space: 8 }) {
        Text('🔥').fontSize(20)
        Column({ space: 1 }) {
          Text('连续学习').fontSize(12).fontColor($r('app.color.text_light'))
          Text('12 天').fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Medium)
        }.alignItems(HorizontalAlign.Start)
      }
      Blank()
      Row({ space: 4 }) {
        ForEach(this.weekDays, (d: DayDot) => {
          Row() {
            Text(d.label).fontSize(11).fontWeight(FontWeight.Medium)
              .fontColor(d.done ? Color.White : (d.isToday ? Color.White : $r('app.color.text_light')))
          }
          .width(22).height(22).borderRadius(11)
          .backgroundColor(d.done ? $r('app.color.success') :
            (d.isToday ? $r('app.color.primary') : $r('app.color.primary_border')))
          .justifyContent(FlexAlign.Center)
        })
      }
    }
    .width('100%').padding({ left: 13, right: 13, top: 9, bottom: 9 }).borderRadius(14)
    .backgroundColor($r('app.color.primary_bg'))
    .border({ width: 1, color: $r('app.color.primary_border') })
  }

  @Builder
  buildSubjectGrid() {
    Grid() {
      ForEach(this.subjects, (subj: SubjectItem) => {
        GridItem() {
          Column({ space: 0 }) {
            Row() { Text(subj.iconText).fontSize(19) }
              .width(36).height(36).borderRadius(10).backgroundColor(subj.iconBg)
              .justifyContent(FlexAlign.Center).margin({ bottom: 8 })

            Text(subj.name).fontSize(13).fontColor($r('app.color.text'))
              .fontWeight(FontWeight.Medium).margin({ bottom: 3 })

            Row() {
              Row().width(`${subj.progress}%`).height('100%').borderRadius(3)
                .backgroundColor(subj.bar)
            }
            .width('100%').height(5).borderRadius(3).backgroundColor(subj.barBg)
            .margin({ bottom: 4 })

            Text(subj.meta).fontSize(11).fontColor($r('app.color.text_muted'))
          }
          .width('100%').alignItems(HorizontalAlign.Start)
          .padding({ left: 13, right: 13, top: 13, bottom: 11 }).borderRadius(16)
          .backgroundColor(subj.card)
          .border({ width: 1, color: $r('app.color.border_light') })
        }
      })
    }
    .columnsTemplate('1fr 1fr').columnsGap(8).rowsGap(8).width('100%')
  }

  @Builder
  buildChallenge() {
    Row({ space: 12 }) {
      Text('🏆').fontSize(32)
      Column({ space: 3 }) {
        Text('今日挑战').fontSize(11).fontColor($r('app.color.teal_bg'))
        Text('完成数学练习\n赢取 50 颗星星')
          .fontSize(14).fontColor(Color.White).fontWeight(FontWeight.Medium).lineHeight(20)
      }.alignItems(HorizontalAlign.Start).layoutWeight(1)
      Text('去挑战').fontSize(12).fontColor($r('app.color.teal')).fontWeight(FontWeight.Medium)
        .padding({ left: 14, right: 14, top: 6, bottom: 6 }).borderRadius(20)
        .backgroundColor(Color.White)
    }
    .width('100%').padding({ left: 14, right: 14, top: 14, bottom: 12 }).borderRadius(18)
    .backgroundColor($r('app.color.success'))
    .border({ width: 1, color: $r('app.color.success_dark') })
  }

  @Builder
  buildSectionTitle(title: string, moreText: string) {
    Row() {
      Text(title).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Medium)
      Blank()
      if (moreText !== '') {
        Text(moreText).fontSize(12).fontColor($r('app.color.text_muted'))
      }
    }.width('100%').padding({ left: 18, right: 18, top: 6, bottom: 8 })
  }

  @Builder
  buildCourseList() {
    Column({ space: 8 }) {
      ForEach(this.courses, (c: CourseItem) => {
        Row({ space: 11 }) {
          Row() { Text(c.icon).fontSize(22) }
            .width(44).height(44).borderRadius(12).backgroundColor(c.bg).justifyContent(FlexAlign.Center)
          Column({ space: 2 }) {
            Text(c.name).fontSize(13).fontColor($r('app.color.text')).fontWeight(FontWeight.Medium)
            Text(c.sub).fontSize(11).fontColor($r('app.color.text_muted'))
          }.alignItems(HorizontalAlign.Start).layoutWeight(1)
          Column({ space: 4 }) {
            Text(c.progress).fontSize(11).fontWeight(FontWeight.Medium)
              .fontColor(c.tagColor).padding({ left: 8, right: 8, top: 3, bottom: 3 })
              .borderRadius(20).backgroundColor(c.tagBg)
            Row() { Text('▶').fontSize(12).fontColor(Color.White) }
              .width(28).height(28).borderRadius(14).backgroundColor(c.btn).justifyContent(FlexAlign.Center)
          }.alignItems(HorizontalAlign.End)
        }
        .width('100%').padding({ left: 13, right: 13, top: 11, bottom: 11 }).borderRadius(16)
        .backgroundColor($r('app.color.bg'))
        .border({ width: 1, color: $r('app.color.border_light') })
      })
    }.width('100%')
  }

  @Builder
  buildToolsGrid() {
    Grid() {
      ForEach(this.tools, (t: ToolItem) => {
        GridItem() {
          Column({ space: 5 }) {
            Row() { Text(t.icon).fontSize(20) }
              .width(46).height(46).borderRadius(14).backgroundColor(t.bg).justifyContent(FlexAlign.Center)
            Text(t.label).fontSize(11).fontColor($r('app.color.text_light')).textAlign(TextAlign.Center)
          }.width('100%').alignItems(HorizontalAlign.Center)
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr').columnsGap(6).rowsGap(6).width('100%')
  }

  @Builder
  buildTabBar() {
    Row() {
      ForEach(this.tabs, (tab: TabItem, index: number) => {
        Column({ space: 3 }) {
          Text(tab.icon).fontSize(22).opacity(index === this.activeTab ? 1.0 : 0.4)
          Text(tab.label).fontSize(10)
            .fontColor(index === this.activeTab ? $r('app.color.primary') : $r('app.color.text_disabled'))
        }
        .layoutWeight(1).alignItems(HorizontalAlign.Center).padding({ top: 8, bottom: 10 })
        .onClick(() => { this.activeTab = index })
      })
    }
    .width('100%').backgroundColor($r('app.color.bg'))
    .border({ width: { top: 1 }, color: $r('app.color.border_light') }).padding({ bottom: 22 })
  }
}

interface DayDot { label: string; done: boolean; isToday?: boolean }

interface SubjectItem {
  name: string; progress: number
  bar: ResourceColor; barBg: ResourceColor; card: ResourceColor; iconBg: ResourceColor
  iconText: string; meta: string
}

interface CourseItem {
  name: string; sub: string; progress: string
  bg: ResourceColor; icon: string
  tagBg: ResourceColor; tagColor: ResourceColor; btn: ResourceColor
}

interface ToolItem { icon: string; label: string; bg: ResourceColor; fg: ResourceColor }
interface TabItem { icon: string; label: string }
