import { router } from '@kit.ArkUI'
import { AdaptiveText } from '../components/components'

/**
 * 健康中国 — 移动医疗服务首页。
 */
@Entry
@Component
struct HomePage {

  // ---- 业务入口 8 宫格 ----
  private services: ServiceItem[] = [
    { icon: '📅', label: '预约挂号', color: '#EBF5FF', iconColor: '#0078FF' },
    { icon: '💬', label: '在线问诊', color: '#E6FFFD', iconColor: '#00C4B4' },
    { icon: '📄', label: '报告查询', color: '#FFF7E6', iconColor: '#FF9900' },
    { icon: '💳', label: '门诊缴费', color: '#FFF1F0', iconColor: '#FF4D4F' },
    { icon: '🏥', label: '互联网医院', color: '#EBF5FF', iconColor: '#0078FF' },
    { icon: '📁', label: '健康档案', color: '#E6FFFD', iconColor: '#00C4B4' },
    { icon: '📦', label: '送药上门', color: '#FFF7E6', iconColor: '#FF9900' },
    { icon: '💉', label: '疫苗接种', color: '#FFF1F0', iconColor: '#FF4D4F' }
  ]

  // ---- 快捷表单入口（水平滚动 / 常见科室挂号楼）----
  private quickEntries: QuickEntry[] = [
    { label: '政务表单', tag: '去填写', tagColor: $r('app.color.success') },
    { label: '信息登记', tag: '去填写', tagColor: $r('app.color.success') },
    { label: '材料提交', tag: '待办', tagColor: $r('app.color.danger') },
    { label: '证照申请', tag: '去填写', tagColor: $r('app.color.success') },
    { label: '预约服务', tag: '去填写', tagColor: $r('app.color.success') }
  ]

  // ---- 健康科普 Feed ----
  private feeds: FeedItem[] = [
    {
      title: '春季五行属木易伤肝，这3种食材不可错过',
      source: '中医养生专栏',
      reads: '2.5万人阅读',
      gradient: ['#A8FF78', '#78FFD6']
    },
    {
      title: '高血压患者冬季晨练，如何避开"脑卒中"陷阱？',
      source: '心血管内科',
      reads: '1.8万人阅读',
      gradient: ['#FF9A9E', '#FECFEF']
    }
  ]

  // ---- 底部导航 ----
  @State activeTab: number = 0
  private tabs: TabItem[] = [
    { icon: '🏠', label: '首页' },
    { icon: '📊', label: '健康管理' },
    { icon: '🧭', label: '发现' },
    { icon: '👤', label: '我的' }
  ]

  build() {
    Column() {
      // ================================================================
      // 顶部一体化蓝色区域（location + search + 凭证卡片）
      // 统一 16px 左右内边距，卡片自然融入 header
      // ================================================================
      Column() {
        // ---- 定位栏 ----
        Row() {
          Row({ space: 4 }) {
            Text('📍 北京市第一人民医院')
              .fontSize(15).fontColor(Color.White).fontWeight(FontWeight.Bold)
            Text('▼').fontSize(10).fontColor(Color.White)
          }
          Blank()
          Text('🔔').fontSize(18)
        }
        .width('100%')
        .padding({ top: 56, bottom: 12 })

        // ---- 搜索框 ----
        Row({ space: 8 }) {
          Text('🔍').fontSize(14)
          Text('搜索医生、科室、疾病、科普...')
            .fontSize(14).fontColor('rgba(255,255,255,0.85)').layoutWeight(1)
        }
        .width('100%').height(38)
        .backgroundColor('rgba(255,255,255,0.18)')
        .borderRadius(19)
        .padding({ left: 16, right: 16 })
        .margin({ bottom: 16 })

        // ---- 政务电子凭证卡片 ----
        Column() {
          // 卡片头部
          Row() {
            Row({ space: 6 }) {
              Text('🇨🇳').fontSize(16)
              Text('政务电子凭证')
                .fontSize(15).fontWeight(FontWeight.Bold).fontColor('#0B409C')
            }
            Blank()
            Text('立即办理')
              .fontSize(12).fontWeight(FontWeight.Bold).fontColor(Color.White)
              .padding({ left: 14, right: 14, top: 6, bottom: 6 })
              .borderRadius(14)
              .linearGradient({
                angle: 135,
                colors: [['#FF9900', 0.0], ['#FF7700', 1.0]]
              })
              .shadow({ radius: 10, color: 'rgba(255,119,0,0.2)', offsetY: 4 })
              .onClick(() => {
                const r = this.getUIContext().getRouter()
                r.pushUrl({ url: 'pages/form/EntryFormPage' }).catch(() => {})
              })
          }
          .width('100%')

          // 分割线
          Divider()
            .color('#F0F0F0')
            .strokeWidth(1)
            .margin({ top: 12, bottom: 12 })

          // 卡片底部
          Row() {
            Column({ space: 2 }) {
              Text('张*华').fontSize(14).fontWeight(FontWeight.Bold).fontColor($r('app.color.text'))
              Text('北京市海淀区参保人员')
                .fontSize(11).fontColor($r('app.color.text_muted'))
            }
            .alignItems(HorizontalAlign.Start)
            Blank()
            Text('国家医疗保障局监制')
              .fontSize(11).fontColor($r('app.color.text_muted'))
          }
          .width('100%')
        }
        .width('100%')
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding(16)
        .shadow({ radius: 24, color: 'rgba(0,0,0,0.08)', offsetY: 8 })
        .margin({ bottom: 20 })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .linearGradient({
        angle: 180,
        colors: [
          [$r('app.color.navbar_gradient_start'), 0.0],
          [$r('app.color.navbar_gradient_end'), 1.0]
        ]
      })
      .borderRadius({ bottomLeft: 28, bottomRight: 28 })
      .shadow({ radius: 16, color: 'rgba(0,120,255,0.15)', offsetY: 4 })

      // ================================================================
      // 主体滚动内容（统一 16px 左右 padding，避免溢出）
      // ================================================================
      Scroll() {
        Column() {
          // ------ 八宫格业务入口 ------
          Grid() {
            ForEach(this.services, (item: ServiceItem) => {
              GridItem() {
                Column({ space: 6 }) {
                  Text(item.icon).fontSize(20)
                    .width(44).height(44)
                    .borderRadius(14)
                    .textAlign(TextAlign.Center)
                    .backgroundColor(item.color)
                  Text(item.label)
                    .fontSize(12).fontColor($r('app.color.text'))
                    .maxLines(1)
                }
                .width('100%')
                .padding({ top: 8, bottom: 8 })
              }
            })
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .columnsGap(8)
          .rowsGap(16)
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding({ left: 10, right: 10, top: 16, bottom: 16 })
          .margin({ top: 16 })
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.02)', offsetY: 2 })

          // ------ 运营 Banner ------
          Row({ space: 12 }) {
            Column({ space: 4 }) {
              Text('冬春换季 专家在线义诊')
                .fontSize(14).fontWeight(FontWeight.Bold).fontColor('#1D39C4')
              Text('50+重点学科专家 限时免费咨询')
                .fontSize(11).fontColor('#2F54EB')
            }
            .alignItems(HorizontalAlign.Start)
            Blank()
            Text('👨‍⚕️').fontSize(24)
          }
          .width('100%').height(80)
          .backgroundColor('#E6F7FF')
          .borderRadius(12)
          .border({ width: 1, color: '#D6E4FF' })
          .padding({ left: 16, right: 16 })
          .margin({ top: 16 })

          // ------ 常见表单入口（类比常见科室挂号）------
          Row() {
            Rect({ width: 4, height: 14 }).fill($r('app.color.primary')).radius(2)
            Text('常见表单入口').fontSize(16).fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text')).margin({ left: 8 })
            Blank()
            Text('全部入口 >').fontSize(12).fontColor($r('app.color.text_muted'))
          }
          .width('100%')
          .padding({ top: 16, bottom: 12 })

          Scroll() {
            Row({ space: 10 }) {
              ForEach(this.quickEntries, (entry: QuickEntry) => {
                Column({ space: 6 }) {
                  Text(entry.label)
                    .fontSize(13).fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text'))
                  Text(entry.tag)
                    .fontSize(10)
                    .fontColor(entry.tagColor)
                    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                    .borderRadius(8)
                    .backgroundColor(
                      entry.tag === '去填写'
                        ? $r('app.color.success_bg')
                        : $r('app.color.danger_bg')
                    )
                }
                .width(84)
                .padding({ top: 12, bottom: 12, left: 8, right: 8 })
                .backgroundColor(Color.White)
                .borderRadius(12)
                .border({ width: 1, color: $r('app.color.border_light') })
                .shadow({ radius: 6, color: 'rgba(0,0,0,0.02)', offsetY: 2 })
                .onClick(() => {
                  const r = this.getUIContext().getRouter()
                  r.pushUrl({ url: 'pages/form/EntryFormPage' }).catch(() => {})
                })
              })
            }
            .height(80)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          // ------ 时令养生与健康科普 ------
          Row() {
            Rect({ width: 4, height: 14 }).fill($r('app.color.primary')).radius(2)
            Text('时令养生与健康科普')
              .fontSize(16).fontWeight(FontWeight.Bold)
              .fontColor($r('app.color.text')).margin({ left: 8 })
            Blank()
            Text('更多科普 >').fontSize(12).fontColor($r('app.color.text_muted'))
          }
          .width('100%')
          .padding({ top: 16, bottom: 12 })

          Column() {
            ForEach(this.feeds, (feed: FeedItem, idx: number) => {
              Row({ space: 12 }) {
                Column({ space: 6 }) {
                  Text(feed.title)
                    .fontSize(13).fontWeight(FontWeight.Bold)
                    .fontColor($r('app.color.text'))
                    .lineHeight(18).maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  Row() {
                    Text(feed.source)
                      .fontSize(11).fontColor($r('app.color.text_muted'))
                    Blank()
                    Text(feed.reads)
                      .fontSize(11).fontColor($r('app.color.text_muted'))
                  }
                  .width('100%')
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                // 渐变色块（替代图片）
                Row()
                  .width(80).height(60)
                  .borderRadius(6)
                  .linearGradient({
                    angle: 135,
                    colors: [
                      [feed.gradient[0], 0.0],
                      [feed.gradient[1], 1.0]
                    ]
                  })
              }
              .width('100%')
              .padding({ bottom: 12 })
              .margin({ bottom: 12 })
              .border({
                width: { bottom: idx < this.feeds.length - 1 ? 1 : 0 },
                color: $r('app.color.border_light')
              })
            })
          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(12)
          .padding(16)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.03)', offsetY: 2 })

          // 底部留白（给 tabBar 让位）
          Column().width('100%').height(80)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor($r('app.color.bg_page'))
      .scrollBar(BarState.Off)

      // ================================================================
      // 底部导航栏
      // ================================================================
      Row() {
        ForEach(this.tabs, (tab: TabItem, index: number) => {
          Column({ space: 3 }) {
            Text(tab.icon).fontSize(20)
            Text(tab.label)
              .fontSize(10).fontWeight(FontWeight.Bold)
              .fontColor(index === this.activeTab
                ? $r('app.color.primary')
                : $r('app.color.text_muted'))
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .padding({ top: 8, bottom: 8 })
          .onClick(() => { this.activeTab = index })
        })
      }
      .width('100%')
      .padding({ top: 6, bottom: 24 })
      .backgroundColor('rgba(255,255,255,0.95)')
      .border({ width: { top: 1 }, color: '#E5E5E5' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.bg_page'))
  }
}

// ===== local interfaces =====
interface ServiceItem {
  icon: string
  label: string
  color: string
  iconColor: string
}
interface QuickEntry {
  label: string
  tag: string
  tagColor: Resource
}
interface FeedItem {
  title: string
  source: string
  reads: string
  gradient: [string, string]
}
interface TabItem {
  icon: string
  label: string
}
