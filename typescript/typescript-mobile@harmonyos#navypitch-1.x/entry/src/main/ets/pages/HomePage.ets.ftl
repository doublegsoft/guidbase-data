import { router } from '@kit.ArkUI'
import { AdaptiveText } from '../components/components'

@Entry
@Component
struct HomePage {

  @State activeTab: number = 0
  private tabs: TabItem[] = [
    { icon: '🏠', label: '首页' },
    { icon: '📋', label: '列表' },
    { icon: '🔔', label: '消息' },
    { icon: '👤', label: '我的' }
  ]

  private todos: TodoItem[] = [
    { title: '审批：张三的请假申请', dept: '人事部', time: '10分钟前', urgent: true },
    { title: '查看季度报表', dept: '财务部', time: '30分钟前', urgent: false },
    { title: '会议室预订确认', dept: '行政部', time: '1小时前', urgent: false }
  ]

  private quickActions: QuickAction[] = [
<#list app.pages as page>      
    { icon: '📋', label: '${page.title}', url: 'pages/${ts.nameNamespace(page.module)}/${ts.nameType(page.name)}' },
</#list>
  ]

  build() {
    Column() {
      Scroll() {
        if (this.activeTab == 0) { 
          this.buildTabHome()
        } else {
          this.buildTabPlaceholder()
        }
      }
      .width('100%')
      .backgroundColor($r('app.color.bg_page'))
      .scrollBar(BarState.Off)

      Blank()
      Row() {
        ForEach(this.tabs, (tab: TabItem, index: number) => {
          Column() {
            Text(tab.icon).fontSize(19)
            Text(tab.label).fontSize(10.5).fontWeight(FontWeight.Bold)
              .fontColor(index === this.activeTab ? $r('app.color.primary_dark') : $r('app.color.text_muted'))
              .margin({ top: 2 })
          }
          .layoutWeight(1).alignItems(HorizontalAlign.Center)
          .padding({ top: 8, bottom: 8 })
          .onClick(() => { this.activeTab = index })
        })
      }
      .width('100%').padding({ top: 6, bottom: 24 })
      .backgroundColor($r('app.color.bg'))
      .border({ width: { top: 1 }, color: $r('app.color.border_light') })
    }
    .width('100%').height('100%')
    .backgroundColor($r('app.color.bg_page'))
  }

  @Builder
  buildTabHome() {
    Column() {
      Column() {
        Row() {
          Column() {
            Text('早上好，管理员')
              .fontSize(12.5).fontColor($r('app.color.gold')).fontWeight(FontWeight.Bold)
            Text('欢迎使用政务办公平台 ⚡')
              .fontSize(21).fontColor(Color.White).fontWeight(FontWeight.Bolder).margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Stack() {
            Text('🔔').fontSize(20)
            Text('')
              .width(7).height(7).borderRadius(3.5)
              .backgroundColor($r('app.color.gold'))
              .position({ x: 26, y: 2 })
          }
          .width(38).height(38).borderRadius(12)
          .backgroundColor('rgba(255,255,255,0.15)')
        }
        .width('100%').padding({ left: 20, right: 20 }).margin({ top: 44, bottom: 16 })

        Row({ space: 10 }) {
          HeroSummaryCard({ icon: '👥', value: '35', label: '待办事项' })
          HeroSummaryCard({ icon: '📋', value: '128', label: '数据总量' })
        }
        .width('100%').padding({ left: 20, right: 20 })
      }
      .width('100%').padding({ bottom: 30 })
      .linearGradient({
        angle: 135,
        colors: [
          [$r('app.color.navbar_gradient_start'), 0.0],
          [$r('app.color.navbar_gradient_mid'), 0.45],
          [$r('app.color.navbar_gradient_end'), 0.70],
          [$r('app.color.navbar_gradient_mid'), 1.0]
        ]
      })

      Column() {
        SectionHeader({ icon: '📌', title: '待办事项', more: '全部 ›' })
        ForEach(this.todos, (item: TodoItem) => {
          TodoCard({ item: item })
        })
        SectionHeader({ icon: '⚡', title: '快捷操作', more: '' })
        Row({ space: 10 }) {
          ForEach(this.quickActions, (action: QuickAction) => {
            QuickBtn({ icon: action.icon, label: action.label, url: action.url })
          })
        }
        .width('100%').padding({ top: 0, bottom: 26 })
      }
      .width('100%').padding({ left: 20, right: 20 })
    }
  }

  @Builder
  buildTabPlaceholder() {
    Column() {
      Text(this.tabs[this.activeTab].icon).fontSize(48).margin({ top: 80 })
      Text(this.tabs[this.activeTab].label)
        .fontSize(18).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ top: 12 })
      Text('暂无内容')
        .fontSize(13).fontColor($r('app.color.text_muted')).margin({ top: 6 })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
  }
}

// ====================== Sub-components ======================

@Component
struct HeroSummaryCard {
  private icon: string = ''
  private value: string = ''
  private label: string = ''

  build() {
    Row({ space: 10 }) {
      Text(this.icon).fontSize(22)
      Column() {
        Text(this.value).fontSize(20).fontColor(Color.White).fontWeight(FontWeight.Bolder)
        Text(this.label).fontSize(10.5).fontColor($r('app.color.gold')).fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1).padding(12).borderRadius(16)
    .backgroundColor('rgba(255,255,255,0.15)')
  }
}

@Component
struct SectionHeader {
  private icon: string = ''
  private title: string = ''
  private more: string = ''

  build() {
    Row() {
      Text(`${r"${this.icon} ${this.title}"}`)
        .fontSize(16).fontWeight(FontWeight.Bolder).fontColor($r('app.color.text'))
      Blank()
      if (this.more != '') {
        Text(this.more).fontSize(12).fontColor($r('app.color.primary')).fontWeight(FontWeight.Bold)
      }
    }
    .width('100%').padding({ top: 22, bottom: 12 })
  }
}

@Component
struct TodoCard {
  private item: TodoItem = { title: '', dept: '', time: '', urgent: false }

  build() {
    Row({ space: 14 }) {
      Column() {
        Text(this.item.urgent ? '急' : '待')
          .fontSize(11).fontColor(Color.White).fontWeight(FontWeight.Bold)
      }
      .width(36).height(36).borderRadius(12).justifyContent(FlexAlign.Center)
      .linearGradient({
        angle: 150,
        colors: this.item.urgent
          ? [[$r('app.color.danger'), 0.0], [$r('app.color.danger_dark'), 1.0]]
          : [[$r('app.color.primary'), 0.0], [$r('app.color.primary_dark'), 1.0]]
      })

      Column() {
        Text(this.item.title).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Bolder)
          .maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(`${r"📍 ${this.item.dept} · 🕐 ${this.item.time}"}`)
          .fontSize(11).fontColor($r('app.color.text_muted')).fontWeight(FontWeight.Bold).margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start).layoutWeight(1)

      Text('›').fontSize(14).fontColor($r('app.color.text_light'))
    }
    .width('100%').padding(16).borderRadius(18)
    .backgroundColor($r('app.color.bg'))
    .margin({ bottom: 10 })
    .shadow({ radius: 20, color: 'rgba(0,0,0,0.06)', offsetY: 8 })
  }
}

@Component
struct QuickBtn {
  private icon: string = ''
  private label: string = ''
  private url: string = ''

  build() {
    Column() {
      Text(this.icon).fontSize(22)
      Text(this.label).fontSize(11).fontWeight(FontWeight.Bold).fontColor($r('app.color.text')).margin({ top: 4 })
    }
    .layoutWeight(1).padding({ top: 14, bottom: 14 }).borderRadius(16)
    .backgroundColor($r('app.color.bg'))
    .shadow({ radius: 18, color: 'rgba(0,0,0,0.04)', offsetY: 8 })
    .onClick(() => {
      if (this.url != '') {
        const uiContext = this.getUIContext()
        uiContext.getRouter().pushUrl({ url: this.url }).catch(() => {})
      }
    })
  }
}

// ====================== Interfaces ======================

interface TabItem { icon: string; label: string }
interface TodoItem { title: string; dept: string; time: string; urgent: boolean }
interface QuickAction { icon: string; label: string; url: string }
