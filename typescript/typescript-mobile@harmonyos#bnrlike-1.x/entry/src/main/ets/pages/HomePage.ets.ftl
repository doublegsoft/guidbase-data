/**
 * 计费管理 — 应用程序主页
 *
 * 页面结构：
 *   1. 顶部状态栏区域 (全屏模式留白)
 *   2. 头部：头像 + 问候语 + 搜索/通知按钮
 *   3. 收入总览卡片 (渐变背景)
 *   4. 逾期提醒横幅
 *   5. 快捷功能网格 (4×2)
 *   6. 近期账单列表
 *   7. 近6月收入趋势柱状图
 *   8. 底部标签栏
 */
@Entry
@Component
struct HomePage {

  // ===== 快捷功能 =====
  private shortcuts: ShortcutItem[] = [
<#list app.pages as page>    
    { icon: '📝', label: '${page.title}', url: 'pages/${ts.nameNamespace(page.module)}/${ts.nameType(page.name)}', bgColor: $r('app.color.billing_accent_bg'), iconColor: $r('app.color.billing_accent') },
</#list>
    { icon: '⋯', label: '更多', bgColor: $r('app.color.bg_page'), iconColor: $r('app.color.text_muted') }
  ]

  // ===== 近期账单 =====
  private bills: BillItem[] = [
    {
      company: '北京科技有限公司',
      invoice: 'INV-0612',
      dueInfo: '逾期 15 天',
      amount: '¥58,400',
      status: 'overdue',
      statusText: '已逾期'
    },
    {
      company: '上海贸易股份公司',
      invoice: 'INV-0634',
      dueInfo: '3 天后到期',
      amount: '¥32,000',
      status: 'dueSoon',
      statusText: '即将到期'
    },
    {
      company: '广州数据服务公司',
      invoice: 'INV-0638',
      dueInfo: '今日到账',
      amount: '¥24,500',
      status: 'paid',
      statusText: '已到账'
    }
  ]

  // ===== 6 个月收入趋势 =====
  private trendMonths: string[] = ['1月', '2月', '3月', '4月', '5月', '6月']
  private currentYear: number[] = [210, 185, 240, 195, 280, 384]
  private lastYear: number[] = [160, 150, 190, 170, 210, 240]

  // ===== 底部标签 =====
  @State activeTab: number = 0
  private tabs: TabItem[] = [
    { icon: '📊', label: '总览' },
    { icon: '📋', label: '账单' },
    { icon: '💵', label: '收入' },
    { icon: '👥', label: '客户' },
    { icon: '⚙️', label: '设置' }
  ]

  // ===== 状态 =====
  @State greeting: string = '早上好 👋'

  // ===== 计算属性 =====
  private get barMax(): number {
    return Math.max(...this.currentYear)
  }

  // ===== 单据状态样式 =====
  private billStatusBgColor(status: string): ResourceColor {
    if (status === 'overdue') return $r('app.color.danger_bg')
    if (status === 'dueSoon') return $r('app.color.warning_bg')
    return $r('app.color.success_bg')
  }

  private billStatusBadgeText(status: string): ResourceColor {
    if (status === 'overdue') return $r('app.color.danger_dark')
    if (status === 'dueSoon') return $r('app.color.warning')
    return $r('app.color.success_dark')
  }

  // ===== 构建方法 =====
  build() {
    Column() {
      // ---- 可滚动内容区域 ----
      Scroll() {
        Column() {
          // ------ 1. 页面顶部留白（全屏模式）------
          Row()
            .width('100%')
            .height(44)

          // ------ 2. 头部区域 ------
          this.buildHeader()

          // ------ 3. 收入总览卡片 ------
          Column() {
            this.buildHero()
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 12 })

          // ------ 4. 逾期提醒横幅 ------
          Column() {
            this.buildOverdueBanner()
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 12 })

          // ------ 5. 快捷功能 ------
          this.buildQuickActions()

          // ------ 6. 近期账单 ------
          this.buildRecentBills()

          // ------ 7. 收入趋势 ------
          this.buildTrend()

          // 底部留白
          Row()
            .width('100%')
            .height(20)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor($r('app.color.billing_surface'))
      .scrollBar(BarState.Off)

      // ------ 8. 底部标签栏 ------
      this.buildTabBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.billing_surface'))
  }

  // ========== 头部 ==========
  @Builder
  buildHeader() {
    Row() {
      // 左侧：头像 + 问候
      Row({ space: 10 }) {
        // 头像
        Text('王')
          .fontSize(14)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .width(36)
          .height(36)
          .borderRadius(18)
          .textAlign(TextAlign.Center)
          .linearGradient({
            angle: 135,
            colors: [
              [$r('app.color.billing_hero_start'), 0.0],
              [$r('app.color.billing_hero_end'), 1.0]
            ]
          })
          .shadow({ radius: 8, color: 'rgba(99,102,241,0.3)', offsetY: 2 })

        // 问候 + 姓名
        Column({ space: 1 }) {
          Text(this.greeting)
            .fontSize(11)
            .fontColor($r('app.color.text_light'))
          Text('王建国')
            .fontSize(16)
            .fontColor($r('app.color.text'))
            .fontWeight(FontWeight.Bold)
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      // 右侧：搜索 + 通知
      Row({ space: 12 }) {
        // 搜索按钮
        Row() {
          Text('🔍')
            .fontSize(16)
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor($r('app.color.bg'))
        .justifyContent(FlexAlign.Center)

        // 通知按钮（带红点）
        Stack() {
          Row() {
            Text('🔔')
              .fontSize(16)
          }
          .width(36)
          .height(36)
          .borderRadius(18)
          .backgroundColor($r('app.color.bg'))
          .justifyContent(FlexAlign.Center)

          // 未读红点
          Row()
            .width(8)
            .height(8)
            .borderRadius(4)
            .backgroundColor($r('app.color.danger'))
            .border({ width: 2, color: Color.White })
            .position({ x: 22, y: 6 })
        }
      }
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 10, bottom: 14 })
    .backgroundColor($r('app.color.bg'))
  }

  // ========== 收入总览卡片 ==========
  @Builder
  buildHero() {
    Column() {
      // 标题行
      Text('本月已收款')
        .fontSize(12)
        .fontColor('rgba(255,255,255,0.7)')
        .letterSpacing(0.5)

      // 金额 + 趋势
      Row({ space: 10 }) {
        Text('¥384.3')
          .fontSize(34)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
        Text('万')
          .fontSize(20)
          .fontColor('rgba(255,255,255,0.85)')
          .fontWeight(FontWeight.Medium)

        // 增长标签
        Row({ space: 3 }) {
          Text('📈')
            .fontSize(11)
          Text('12.4%')
            .fontSize(12)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Medium)
        }
        .padding({ left: 8, right: 8, top: 3, bottom: 3 })
        .borderRadius(20)
        .backgroundColor('rgba(255,255,255,0.15)')
      }
      .margin({ top: 4 })

      // 两个小卡片
      Row({ space: 10 }) {
        // 应收账款
        Column({ space: 2 }) {
          Text('应收账款')
            .fontSize(11)
            .fontColor('rgba(255,255,255,0.6)')
          Text('¥98.6万')
            .fontSize(17)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
          Row({ space: 3 }) {
            Text('⚠️')
              .fontSize(10)
            Text('逾期 ¥12.8万')
              .fontSize(10)
              .fontColor('rgba(255,255,255,0.55)')
          }
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 14, right: 14, top: 12, bottom: 12 })
        .borderRadius(12)
        .backgroundColor('rgba(255,255,255,0.12)')
        .layoutWeight(1)

        // 本月开票
        Column({ space: 2 }) {
          Text('本月开票')
            .fontSize(11)
            .fontColor('rgba(255,255,255,0.6)')
          Row({ space: 4 }) {
            Text('147')
              .fontSize(17)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
            Text('张')
              .fontSize(12)
              .fontColor('rgba(255,255,255,0.75)')
          }
          Row({ space: 3 }) {
            Text('✅')
              .fontSize(10)
            Text('回款率 91.3%')
              .fontSize(10)
              .fontColor('rgba(255,255,255,0.55)')
          }
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 14, right: 14, top: 12, bottom: 12 })
        .borderRadius(12)
        .backgroundColor('rgba(255,255,255,0.12)')
        .layoutWeight(1)
      }
      .width('100%')
      .margin({ top: 14 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(20)
    .borderRadius(20)
    .linearGradient({
      angle: 135,
      colors: [
        [$r('app.color.billing_hero_start'), 0.0],
        [$r('app.color.billing_hero_end'), 1.0]
      ]
    })
    .shadow({ radius: 24, color: 'rgba(99,102,241,0.25)', offsetY: 8 })
  }

  // ========== 逾期提醒横幅 ==========
  @Builder
  buildOverdueBanner() {
    Row({ space: 10 }) {
      // 时钟图标
      Row() {
        Text('⏰')
          .fontSize(18)
      }
      .width(36)
      .height(36)
      .borderRadius(10)
      .backgroundColor($r('app.color.warning'))
      .justifyContent(FlexAlign.Center)

      // 文字
      Column({ space: 1 }) {
        Text('3 张账单即将逾期')
          .fontSize(12)
          .fontColor('#92400E')
          .fontWeight(FontWeight.Bold)
        Text('合计 ¥12.8 万 · 请尽快跟进处理')
          .fontSize(11)
          .fontColor('#A16207')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // 箭头
      Text('›')
        .fontSize(18)
        .fontColor('#92400E')
    }
    .width('100%')
    .padding({ left: 14, right: 14, top: 10, bottom: 10 })
    .borderRadius(12)
    .linearGradient({
      angle: 135,
      colors: [
        ['#FEF3C7', 0.0],
        [$r('app.color.billing_amber_border'), 1.0]
      ]
    })
    .border({ width: 1, color: $r('app.color.billing_amber_border') })
  }

  // ========== 快捷功能 ==========
  @Builder
  buildQuickActions() {
    Column() {
      // 标题行
      Row() {
        Text('快捷功能')
          .fontSize(15)
          .fontColor($r('app.color.text'))
          .fontWeight(FontWeight.Bold)

        Blank()

        Text('编辑 ›')
          .fontSize(13)
          .fontColor($r('app.color.billing_accent'))
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: 4, right: 4 })

      // 4×2 网格
      Grid() {
        ForEach(this.shortcuts, (item: ShortcutItem) => {
          GridItem() {
            Column({ space: 7 }) {
              Text(item.icon)
                .fontSize(22)
                .width(44)
                .height(44)
                .borderRadius(14)
                .textAlign(TextAlign.Center)
                .backgroundColor(item.bgColor)

              Text(item.label)
                .fontSize(11)
                .fontColor($r('app.color.text_muted'))
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')
            .padding({ top: 14, bottom: 12 })
            .borderRadius(16)
            .backgroundColor($r('app.color.bg'))
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.04)', offsetY: 1 })
            .onClick(() => {
              if (item.url !== '') {
                const uiContext = this.getUIContext()
                const r = uiContext.getRouter()
                r.pushUrl({ url: item.url }).catch(() => {})
              }
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .width('100%')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 18 })
  }

  // ========== 近期账单 ==========
  @Builder
  buildRecentBills() {
    Column() {
      // 标题行
      Row() {
        Text('近期账单')
          .fontSize(15)
          .fontColor($r('app.color.text'))
          .fontWeight(FontWeight.Bold)

        Blank()

        Text('全部 ›')
          .fontSize(13)
          .fontColor($r('app.color.billing_accent'))
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: 4, right: 4 })

      // 账单卡片
      Column() {
        ForEach(this.bills, (bill: BillItem, index: number) => {
          Row({ space: 11 }) {
            // 状态图标
            Row() {
              Text(bill.status === 'overdue' ? '⏰' : (bill.status === 'dueSoon' ? '📅' : '✅'))
                .fontSize(17)
            }
            .width(40)
            .height(40)
            .borderRadius(12)
            .backgroundColor(this.billStatusBgColor(bill.status))
            .justifyContent(FlexAlign.Center)

            // 中间信息
            Column({ space: 2 }) {
              Text(bill.company)
                .fontSize(13)
                .fontColor($r('app.color.text'))
                .fontWeight(FontWeight.Bold)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text(`${bill.invoice} · ${bill.dueInfo}`)
                .fontSize(11)
                .fontColor($r('app.color.text_light'))
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            // 右侧金额 + 标签
            Column({ space: 3 }) {
              Text(bill.amount)
                .fontSize(14)
                .fontColor($r('app.color.text'))
                .fontWeight(FontWeight.Bold)

              Text(bill.statusText)
                .fontSize(10)
                .fontColor(this.billStatusBadgeText(bill.status))
                .fontWeight(FontWeight.Bold)
                .padding({ left: 7, right: 7, top: 2, bottom: 2 })
                .borderRadius(6)
                .backgroundColor(this.billStatusBgColor(bill.status))
            }
            .alignItems(HorizontalAlign.End)
          }
          .width('100%')
          .padding({ left: 14, right: 14, top: 12, bottom: 12 })
          .border({
            width: { bottom: index < this.bills.length - 1 ? 1 : 0 },
            color: $r('app.color.border_light')
          })
        })
      }
      .width('100%')
      .borderRadius(16)
      .backgroundColor($r('app.color.bg'))
      .shadow({ radius: 4, color: 'rgba(0,0,0,0.04)', offsetY: 1 })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 18 })
  }

  // ========== 收入趋势 ==========
  @Builder
  buildTrend() {
    Column() {
      // 标题行
      Row() {
        Text('近6月收入趋势')
          .fontSize(15)
          .fontColor($r('app.color.text'))
          .fontWeight(FontWeight.Bold)

        Blank()

        Text('详情 ›')
          .fontSize(13)
          .fontColor($r('app.color.billing_accent'))
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding({ left: 4, right: 4 })

      // 趋势卡片
      Column() {
        // 统计摘要
        Row() {
          Column({ space: 1 }) {
            Text('¥384.3万')
              .fontSize(18)
              .fontColor($r('app.color.billing_accent'))
              .fontWeight(FontWeight.Bold)
            Text('本月收入')
              .fontSize(10)
              .fontColor($r('app.color.text_light'))
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Column({ space: 1 }) {
            Text('+12.4%')
              .fontSize(18)
              .fontColor($r('app.color.text'))
              .fontWeight(FontWeight.Bold)
            Text('环比增长')
              .fontSize(10)
              .fontColor($r('app.color.text_light'))
          }
          .alignItems(HorizontalAlign.End)
        }
        .width('100%')

        // 图例（单独一行，避免溢出）
        Row({ space: 12 }) {
          Row({ space: 4 }) {
            Row()
              .width(8)
              .height(8)
              .borderRadius(3)
              .backgroundColor($r('app.color.billing_accent'))
            Text('本年')
              .fontSize(11)
              .fontColor($r('app.color.text_light'))
          }
          Row({ space: 4 }) {
            Row()
              .width(8)
              .height(8)
              .borderRadius(3)
              .backgroundColor($r('app.color.billing_accent_light'))
            Text('去年')
              .fontSize(11)
              .fontColor($r('app.color.text_light'))
          }
        }
        .margin({ top: 8, bottom: 14 })

        // 柱状图
        Row({ space: 5 }) {
          ForEach(this.trendMonths, (month: string, i: number) => {
            Column({ space: 3 }) {
              // 本年柱
              Row()
                .width(22)
                .height(this.vpBarHeight(this.currentYear[i]))
                .borderRadius({ topLeft: 6, topRight: 6, bottomLeft: 2, bottomRight: 2 })
                .linearGradient({
                  angle: 180,
                  colors: i === 5 ?
                    [
                      [$r('app.color.billing_accent'), 0.0],
                      [$r('app.color.billing_hero_start'), 1.0]
                    ] :
                    [
                      [$r('app.color.billing_accent_light'), 0.0],
                      [$r('app.color.billing_accent_bg'), 1.0]
                    ]
                })
                .shadow(i === 5 ?
                  { radius: 12, color: 'rgba(99,102,241,0.3)', offsetY: 4 } :
                  { radius: 0, color: 'transparent' }
                )

              // 去年柱
              Row()
                .width(22)
                .height(this.vpBarHeight(this.lastYear[i]))
                .borderRadius({ topLeft: 6, topRight: 6, bottomLeft: 2, bottomRight: 2 })
                .backgroundColor($r('app.color.billing_accent_light'))
                .opacity(0.5)

              // 数值
              Text(`${this.currentYear[i]}万`)
                .fontSize(10)
                .fontColor($r('app.color.text_light'))
                .fontWeight(FontWeight.Medium)
                .margin({ top: 2 })

              // 月份
              Text(month)
                .fontSize(10)
                .fontColor($r('app.color.text_light'))
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.End)
          })
        }
        .width('100%')
        .height(140)
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .padding(16)
      .borderRadius(16)
      .backgroundColor($r('app.color.bg'))
      .shadow({ radius: 4, color: 'rgba(0,0,0,0.04)', offsetY: 1 })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 18 })
  }

  // ========== 底部标签栏 ==========
  @Builder
  buildTabBar() {
    Row() {
      ForEach(this.tabs, (tab: TabItem, index: number) => {
        Column({ space: 4 }) {
          Text(tab.icon)
            .fontSize(22)
            .opacity(index === this.activeTab ? 1.0 : 0.45)

          Text(tab.label)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(index === this.activeTab ?
              $r('app.color.billing_accent') :
              $r('app.color.text_light')
            )
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .padding({ top: 6, bottom: 8 })
        .onClick(() => {
          this.activeTab = index
        })
      })
    }
    .width('100%')
    .padding({ top: 6, bottom: 24 })
    .backgroundColor($r('app.color.bg'))
    .border({ width: { top: 1 }, color: $r('app.color.border_light') })
  }

  // ========== 辅助方法 ==========

  /**
   * 将原始值转换为柱状图高度 (vp)，最大值对应 60vp。
   */
  private vpBarHeight(value: number): number {
    const max = this.barMax
    if (max <= 0) return 4
    return Math.round((value / max) * 60)
  }
}

// ===== 本地接口 =====

interface ShortcutItem {
  icon: string
  label: string
  bgColor: ResourceColor
  iconColor: ResourceColor
}

interface BillItem {
  company: string
  invoice: string
  dueInfo: string
  amount: string
  status: 'overdue' | 'dueSoon' | 'paid'
  statusText: string
}

interface TabItem {
  icon: string
  label: string
}
