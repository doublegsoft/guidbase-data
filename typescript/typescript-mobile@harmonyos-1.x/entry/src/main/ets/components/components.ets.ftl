import { Theme } from '../common/theme/Theme';

/**
 * 1. Navbar Component (导航栏：支持首页模式 / 子页返回模式)
 *
 * 首页模式（navTitle 为空，默认）：
 *   左侧=logo，右侧=操作入口
 *
 * 子页模式（设置 navTitle）：
 *   左侧=返回按钮 + 页面标题，右侧=操作入口
 */
@Component
export struct Navbar {
  // ---- 首页模式 ----
  private logoText: string = '${app.name}';
  private logoEmText: string = '【主系统】';
  // ---- 子页导航模式 ----
  navTitle: string = '';
  showBack: boolean = false;
  // ---- 右侧插槽 ----
  @BuilderParam customRightSlot?: () => void;
  // ---- 返回回调 ----
  onBack?: () => void;

  build() {
    Column() {
      Row() {
        if (this.navTitle != '') {
          // ======== 子页导航模式 ========
          if (this.showBack) {
            Text('←')
              .fontSize(22)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
              .padding({ right: 12 })
              .onClick(() => {
                if (this.onBack) {
                  this.onBack()
                }
              })
          }
          AdaptiveText({
            value: this.navTitle,
            fontSize: 17,
            fontColor: Color.White,
            fontWeight: FontWeight.Bold,
            fontFamily: Theme.FONT_FAMILY
          })
        } else {
          // ======== 首页模式 ========
          Row() {
            AdaptiveText({
              value: this.logoText,
              fontSize: 15,
              fontColor: Color.White,
              fontWeight: FontWeight.Bold,
              fontFamily: Theme.FONT_FAMILY
            })
            AdaptiveText({
              value: this.logoEmText,
              fontSize: 15,
              fontColor: $r('app.color.primary'),
              fontWeight: FontWeight.Bolder,
              fontFamily: Theme.FONT_FAMILY
            })
          }
          .padding({ right: 16 })
          .margin({ right: 16 })
          .border({ width: { right: 1 }, color: 'rgba(255,255,255,0.2)' })
        }

        Blank()

        // Right slot
        if (this.customRightSlot) {
          this.customRightSlot()
        } else if (this.navTitle == '') {
          // 仅首页模式显示默认操作入口
          Row({ space: 14 }) {
            AdaptiveText({
              value: '管理员',
              fontSize: 12,
              fontColor: Color.White
            })
            AdaptiveText({
              value: '安全退出',
              fontSize: 12,
              fontColor: $r('app.color.primary')
            })
          }
        }
      }
      .width('100%')
      .height(Theme.TOPBAR_HEIGHT)
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .padding({ top: 44 })
    .linearGradient({
      angle: 135,
      colors: [
        [$r('app.color.navbar_gradient_start'), 0.0],
        [$r('app.color.navbar_gradient_mid'), 0.45],
        [$r('app.color.navbar_gradient_end'), 0.70],
        [$r('app.color.navbar_gradient_mid'), 1.0]
      ]
    })
    .border({ width: { bottom: 3 }, color: $r('app.color.primary') })
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.15)', offsetY: 3 })
  }
}

/**
 * 2. Panel Component (左红带经典面板)
 */
 /*
@Component
export struct Panel {
  private title: string = '面板标题';
  private type: 'default' | 'warning' | 'success' | 'danger' = 'default';
  @BuilderParam contentSlot?: () => void;

  private getHeaderBg(): Resource {
    switch (this.type) {
      case 'warning': return $r('app.color.warning_bg');
      case 'success': return $r('app.color.success_bg');
      case 'danger': return $r('app.color.danger_bg');
      default: return $r('app.color.primary_bg');
    }
  }

  private getAccentColor(): Resource {
    switch (this.type) {
      case 'warning': return $r('app.color.warning');
      case 'success': return $r('app.color.success');
      case 'danger': return $r('app.color.danger');
      default: return $r('app.color.primary');
    }
  }

  private getBorderColor(): Resource {
    switch (this.type) {
      case 'warning': return $r('app.color.warning_border');
      case 'success': return $r('app.color.success_border');
      case 'danger': return $r('app.color.danger_border');
      default: return $r('app.color.primary_border');
    }
  }

  build() {
    Column() {
      // Panel Header
      Row({ space: 8 }) {
        // Red Accent Indicator
        Rect({ width: 4, height: 14 })
          .fill(this.getAccentColor())
          .radius($r('app.float.radius_sm'))
        
        AdaptiveText({
          value: this.title,
          fontSize: 13,
          fontWeight: FontWeight.Bold,
          fontColor: this.type === 'default' ? $r('app.color.primary_dark') : this.getAccentColor()
        })
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.getHeaderBg())
      .border({ width: { bottom: 1 }, color: this.getBorderColor() })

      // Panel Body
      Column() {
        if (this.contentSlot) {
          this.contentSlot()
        }
      }
      .width('100%')
      .backgroundColor($r('app.color.bg'))
    }
    .width('100%')
    .border({ width: 1, color: $r('app.color.border') })
    .borderRadius($r('app.float.radius_sm'))
    .shadow({ radius: 3, color: 'rgba(45,37,34,0.05)', offsetY: 1 })
  }
}
*/

/**
 * 3. Tag / Badge (高饱和度标签)
 */

interface TagColors {
  bg: Resource
  text: Resource
  border: Resource
}

@Component
export struct Tag {
  private text: string = '标签';
  private variant: 'success' | 'danger' | 'warning' | 'primary' | 'neutral' = 'neutral';

  private getColors(): TagColors {
    switch (this.variant) {
      case 'success':
        return { bg: $r('app.color.success_bg'), text: $r('app.color.success_dark'), border: $r('app.color.success_border') };
      case 'danger':
        return { bg: $r('app.color.danger_bg'), text: $r('app.color.danger_dark'), border: $r('app.color.danger_border') };
      case 'warning':
        return { bg: $r('app.color.warning_bg'), text: $r('app.color.warning'), border: $r('app.color.warning_border') };
      case 'primary':
        return { bg: $r('app.color.primary_bg'), text: $r('app.color.primary_dark'), border: $r('app.color.primary_border') };
      default:
        return { bg: $r('app.color.bg_page'), text: $r('app.color.text_muted'), border: $r('app.color.border') };
    }
  }

  build() {
    AdaptiveText({
      value: this.text,
      fontSize: 10,
      fontWeight: FontWeight.Bold,
      fontColor: this.getColors().text
    })
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(this.getColors().bg)
      .border({ width: 1, color: this.getColors().border })
      .borderRadius($r('app.float.radius_sm'))
  }
}

@Component
export struct AdaptiveText {
  @Prop value: string | number | boolean | null | undefined
  @Prop fontSize: number = 16
  @Prop fontColor: ResourceColor = $r('app.color.text')
  @Prop fontWeight: number = FontWeight.Normal
  @Prop fontFamily: string = ''
  @Prop textAlign: TextAlign = TextAlign.Start

  build() {
    Text(String(this.value))
      .fontSize(this.fontSize)
      .fontColor(this.fontColor)
      .fontWeight(this.fontWeight)
      .fontFamily(this.fontFamily)
      .textAlign(this.textAlign)
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
  }
}

export interface FormRow {
  label: string
  value: string
  isTag?: boolean
}

@Component
export struct FormSection {
  private title: string = ''
  private rows: FormRow[] = []

  build() {
    Column() {
      Row() {
        Rect({ width: 4, height: 14 })
          .fill($r('app.color.primary'))
          .radius($r('app.float.radius_sm'))
        Text(this.title)
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.primary_dark'))
          .margin({ left: 6 })
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor($r('app.color.primary_bg'))
      .border({ width: { bottom: 1 }, color: $r('app.color.primary_border') })

      // 表单项
      Column() {
        ForEach(this.rows, (row: FormRow, index: number) => {
          Row() {
            // Label
            Text(row.label)
              .fontSize(13)
              .fontColor($r('app.color.text_muted'))
              .fontWeight(FontWeight.Bold)
              .width(72)
              .flexShrink(0)

            // Value
            if (row.isTag) {
              Tag({ text: row.value, variant: 'primary' })
            } else {
              AdaptiveText({
                value: row.value,
                fontSize: 14,
                fontColor: $r('app.color.text'),
                fontWeight: FontWeight.Bold
              })
            }
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 10, bottom: 10 })
          .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
        })
      }
      .width('100%')
      .backgroundColor($r('app.color.bg'))
    }
    .width('100%')
    .margin({ top: 12 })
    .border({ width: 1, color: $r('app.color.border') })
    .borderRadius($r('app.float.radius_sm'))
    .shadow({ radius: 3, color: 'rgba(45,37,34,0.05)', offsetY: 1 })
  }
}

@Component
export struct FormSectionTitle {
  private title: string = ''

  build() {
    Row() {
      Rect({ width: 4, height: 14 }).fill($r('app.color.primary')).radius(2)
      Text(this.title).fontSize(14).fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.primary_dark')).margin({ left: 8 })
    }
    .width('100%').padding({ left: 16, right: 16, top: 14, bottom: 10 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
  }
}

@Component
export struct Avatar {
  private text: string | null = ''
  private avatarSize: number = 48

  private get initial(): string {
    if (this.text && this.text.length > 0) {
      return this.text[0]
    }
    return '?'
  }

  build() {
    Text(this.initial)
      .fontSize(this.avatarSize / 2.5)
      .fontColor(Color.White)
      .fontWeight(FontWeight.Bold)
      .width(this.avatarSize)
      .height(this.avatarSize)
      .borderRadius(this.avatarSize / 2)
      .textAlign(TextAlign.Center)
      .linearGradient({
        angle: 145,
        colors: [
          [$r('app.color.navbar_gradient_start'), 0.0],
          [$r('app.color.primary'), 1.0]
        ]
      })
  }
}

@Component
export struct InputRow {
  private label: string = ''
  @Prop value: string = ''
  private inputType: InputType = InputType.Normal
  private multiline: boolean = false
  onChange?: (v: string) => void

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
      TextInput({ text: this.value, placeholder: ${r"`请输入${this.label}`"} })
        .type(this.multiline ? InputType.Normal : this.inputType)
        .placeholderColor($r('app.color.text_light'))
        .placeholderFont({size: 14})
        .fontSize(14).fontColor($r('app.color.text'))
        .backgroundColor($r('app.color.bg'))
        .layoutWeight(1)
        .onChange((v: string) => {
          if (this.onChange) { this.onChange(v) }
        })
    }
    .width('100%').height(48).padding({ left: 16, right: 16 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
  }
}

@Component
export struct DateRow {
  private label: string = ''
  private value: string = ''
  onSelect?: (v: string) => void

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
      Text(this.value || ${r"`请选择${this.label}`"})
        .fontSize(14).padding({left: 17})
        .fontColor(this.value ? $r('app.color.text') : $r('app.color.text_light'))
        .layoutWeight(1)
      Text('📅').fontSize(16)
    }
    .width('100%').height(48).padding({ left: 16, right: 16 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
    .onClick(() => {
      DatePickerDialog.show({
        start: new Date('2000-1-1'),
        end: new Date('2100-1-1'),
        selected: this.value ? new Date(this.value) : new Date(),
        onAccept: (result: DatePickerResult) => {
          if (result.year !== undefined && result.month !== undefined && result.day !== undefined) {
            const m: number = result.month as number + 1
            const md: string = String(m).padStart(2, '0')
            const dd: string = String(result.day).padStart(2, '0')
            const str: string = ${r"`${result.year}-${md}-${dd}`"}
            if (this.onSelect) { this.onSelect(str) }
          }
        }
      })
    })
  }
}

@Component
export struct DropdownRow {
  private label: string = ''
  private value: string = ''
  private options: string[] = []
  onSelect?: (v: string) => void

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
      Text(this.value || ${r"`请选择${this.label}`"})
        .fontSize(14).padding({left: 17})
        .fontColor(this.value ? $r('app.color.text') : $r('app.color.text_light'))
        .layoutWeight(1)
      Text('▼').fontSize(12).fontColor($r('app.color.text_muted'))
    }
    .width('100%').height(48).padding({ left: 16, right: 16 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
    .onClick(() => {
      TextPickerDialog.show({
        range: this.options,
        selected: this.options.indexOf(this.value) >= 0 ? this.options.indexOf(this.value) : 0,
        onAccept: (result: TextPickerResult) => {
          if (result.index !== undefined) {
            const idx: number = result.index as number
            const picked: string = this.options[idx]
            if (this.onSelect) { this.onSelect(picked) }
          }
        }
      })
    })
  }
}