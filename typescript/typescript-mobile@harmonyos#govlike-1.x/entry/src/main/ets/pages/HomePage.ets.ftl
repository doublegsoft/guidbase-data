import { router } from '@kit.ArkUI'
import { AdaptiveText, Navbar } from '../components/components'

/**
 * 首页仪表盘。
 */
@Entry
@Component
struct HomePage {

  private shortcuts: ShortcutItem[] = [{
<#list app.pages as page>  
  <#if page?index != 0>
  },{
  </#if>
    icon: '📋',
    title: '${page.title}',
    desc: '${page.title}入口示例页面',
    url: 'pages/${ts.nameNamespace(page.module)}/${ts.nameType(page.name)}',
    accent: '#D4380D'
</#list>      
  }]

  // ---- 统计卡片 ----
  private stats: StatItem[] = [
    { value: '128', label: '数据总量', icon: '📦' },
    { value: '36', label: '今日新增', icon: '📈' },
    { value: '12', label: '待处理', icon: '⏳' },
    { value: '8', label: '模块数', icon: '🗂️' }
  ]

  @State activeTab: number = 0
  private tabs: TabItem[] = [
    { icon: '🏠', label: '首页' },
    { icon: '📋', label: '列表' },
    { icon: '🔔', label: '消息' },
    { icon: '👤', label: '我的' }
  ]

  build() {
    Column() {
      Navbar()
      Scroll() {
        Column() {
          // ------ 欢迎区 ------
          Column() {
            Row() {
              Column() {
                AdaptiveText({
                  value: '早上好，管理员',
                  fontSize: 13,
                  fontColor: $r('app.color.primary_dark'),
                  fontWeight: FontWeight.Bold
                })
                Text('欢迎使用政务办公平台')
                  .fontSize(22)
                  .fontColor($r('app.color.text'))
                  .fontWeight(FontWeight.Bolder)
                  .margin({ top: 4 })
                Text('数据看板 · 快捷入口 · 系统管理')
                  .fontSize(13)
                  .fontColor($r('app.color.text_muted'))
                  .fontWeight(FontWeight.Bold)
                  .margin({ top: 6 })
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              // 日期徽章
              Column() {
                Text(this.today())
                  .fontSize(28)
                  .fontColor(Color.White)
                  .fontWeight(FontWeight.Bolder)
                Text(this.weekday())
                  .fontSize(12)
                  .fontColor('rgba(255,255,255,0.75)')
                  .fontWeight(FontWeight.Bold)
              }
              .width(60)
              .height(60)
              .borderRadius(16)
              .justifyContent(FlexAlign.Center)
              .linearGradient({
                angle: 145,
                colors: [
                  ['#D4380D', 0.0],
                  ['#A30000', 1.0]
                ]
              })
            }
            .width('100%')
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 12, bottom: 12 })

          // ------ 统计行 ------
          Grid() {
            ForEach(this.stats, (item: StatItem) => {
              GridItem() {
                Column() {
                  Text(item.icon)
                    .fontSize(22)
                  AdaptiveText({
                    value: item.value,
                    fontSize: 20,
                    fontColor: $r('app.color.text'),
                    fontWeight: FontWeight.Bolder
                  })
                  .margin({ top: 6 })
                  AdaptiveText({
                    value: item.label,
                    fontSize: 11,
                    fontColor: $r('app.color.text_muted'),
                    fontWeight: FontWeight.Bold
                  })
                  .margin({ top: 2 })
                }
                .width('100%')
                .padding({ top: 14, bottom: 14 })
                .borderRadius(14)
                .backgroundColor($r('app.color.bg'))
                .shadow({ radius: 8, color: 'rgba(0,0,0,0.04)', offsetY: 2 })
              }
            })
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .width('100%')
          .padding({ left: 20, right: 20 })

          // ------ 快捷入口标题 ------
          Row() {
            Rect({ width: 4, height: 16 })
              .fill($r('app.color.primary'))
              .radius(2)
            AdaptiveText({
              value: '快捷入口',
              fontSize: 16,
              fontColor: $r('app.color.text'),
              fontWeight: FontWeight.Bolder
            })
            .margin({ left: 8 })
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 14, bottom: 10 })

          // ------ 快捷入口卡片 ------
          Column({ space: 10 }) {
            ForEach(this.shortcuts, (item: ShortcutItem) => {
              Row() {
                // 左侧图标
                Text(item.icon)
                  .fontSize(26)
                  .width(48)
                  .height(48)
                  .borderRadius(14)
                  .textAlign(TextAlign.Center)
                  .backgroundColor(this.alpha(item.accent, 0.1))

                // 中间文字
                Column() {
                  AdaptiveText({
                    value: item.title,
                    fontSize: 15,
                    fontColor: $r('app.color.text'),
                    fontWeight: FontWeight.Bolder
                  })
                  AdaptiveText({
                    value: item.desc,
                    fontSize: 12,
                    fontColor: $r('app.color.text_muted'),
                    fontWeight: FontWeight.Bold
                  })
                  .margin({ top: 3 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
                .margin({ left: 12 })

                // 右侧箭头
                Text('›')
                  .fontSize(18)
                  .fontColor($r('app.color.text_muted'))
              }
              .width('100%')
              .padding(14)
              .backgroundColor($r('app.color.bg'))
              .borderRadius(14)
              .onClick(() => {
                if (item.url != '') {
                  const uiContext = this.getUIContext()
                  const r = uiContext.getRouter()
                  r.pushUrl({ url: item.url }).catch(() => {})
                }
              })
            })
          }
          .width('100%')
          .padding({ left: 20, right: 20 })
          Column()
            .width('100%')
            .height(32)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .margin({top: 12})
      .backgroundColor($r('app.color.bg_page'))
      .scrollBar(BarState.Off)

      Blank()
      Row() {
        ForEach(this.tabs, (tab: TabItem, index: number) => {
          Column() {
            Text(tab.icon).fontSize(20)
            Text(tab.label)
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(index === this.activeTab ? $r('app.color.primary') : $r('app.color.text_muted'))
              .margin({ top: 2 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .padding({ top: 8, bottom: 8 })
          .onClick(() => { this.activeTab = index })
        })
      }
      .width('100%')
      .padding({ top: 6, bottom: 24 })
      .backgroundColor($r('app.color.bg'))
      .border({ width: { top: 1 }, color: $r('app.color.border_light') })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.bg_page'))
  }

  // ---- helpers ----
  private today(): string {
    return String(new Date().getDate()).padStart(2, '0')
  }
  private weekday(): string {
    const list = ['周日', '周一', '周二', '周三', '周四', '周五', '周六']
    return list[new Date().getDay()]
  }
  private alpha(hex: string, a: number): string {
    return hex + Math.round(a * 255).toString(16).padStart(2, '0')
  }
}

// ===== local interfaces =====
interface ShortcutItem {
  icon: string
  title: string
  desc: string
  url: string
  accent: string
}
interface StatItem {
  value: string
  label: string
  icon: string
}
interface TabItem {
  icon: string
  label: string
}
