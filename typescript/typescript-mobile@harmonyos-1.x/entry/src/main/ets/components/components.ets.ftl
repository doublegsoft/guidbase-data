import { Theme } from '../common/theme/Theme';
import { Option } from 'sdk';

/**
 * 将任意值格式化为安全显示的字符串，过滤 null/undefined/NaN。
 */
function fmtVal(v: string | number | boolean | null | undefined): string {
  if (v == null || v == 'null') { return '' }
  if (typeof v === 'number' && isNaN(v)) { return '' }
  return String(v)
}

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
  text: string = '标签';
  variant: 'success' | 'danger' | 'warning' | 'primary' | 'neutral' = 'neutral';

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
  title: string = ''

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
  label: string = ''
  @Prop value: string = ''
  inputType: InputType = InputType.Normal
  multiline: boolean = false
  onChange?: (v: string) => void

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
      TextInput({ text: fmtVal(this.value), placeholder: '请输入' + this.label })
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
  label: string = ''
  @Prop value: string = ''
  onSelect?: (v: string) => void

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
      Text(this.value || '请选择' + this.label)
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
            const str: string = result.year + '-' + md + '-' + dd
            if (this.onSelect) { this.onSelect(str) }
          }
        }
      })
    })
  }
}

@Component
export struct DropdownRow {
  label: string = ''
  @Prop value: string = ''
  options: Option[] = []
  onSelect?: (v: string) => void

  private getLabel(): string {
    if (!this.value || this.value == 'null') { return '' }
    const found: Option | undefined = this.options.find((opt: Option) => opt.value === this.value)
    return found ? found.label : this.value
  }

  private getLabels(): string[] {
    return this.options.map((opt: Option) => opt.label)
  }

  private getSelectedIndex(): number {
    return this.options.findIndex((opt: Option) => opt.value === this.value)
  }

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
      Text(this.getLabel() || '请选择' + this.label)
        .fontSize(14).padding({left: 17})
        .fontColor(this.value ? $r('app.color.text') : $r('app.color.text_light'))
        .layoutWeight(1)
      Text('▼').fontSize(12).fontColor($r('app.color.text_muted'))
    }
    .width('100%').height(48).padding({ left: 16, right: 16 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
    .onClick(() => {
      const labels: string[] = this.getLabels()
      if (labels.length === 0) { return }
      TextPickerDialog.show({
        range: labels,
        selected: this.getSelectedIndex() >= 0 ? this.getSelectedIndex() : 0,
        onAccept: (result: TextPickerResult) => {
          if (result.index !== undefined) {
            const idx: number = result.index as number
            if (this.onSelect) { this.onSelect(this.options[idx].value) }
          }
        }
      })
    })
  }
}

/**
 * TimeRow - 时间选择器（时:分:秒）
 */
@Component
export struct TimeRow {
  label: string = ''
  @Prop value: string = ''
  onSelect?: (v: string) => void

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
      Text(this.value || '请选择' + this.label)
        .fontSize(14).padding({left: 17})
        .fontColor(this.value ? $r('app.color.text') : $r('app.color.text_light'))
        .layoutWeight(1)
      Text('🕐').fontSize(16)
    }
    .width('100%').height(48).padding({ left: 16, right: 16 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
    .onClick(() => {
      TimePickerDialog.show({
        selected: new Date(),
        onAccept: (result: TimePickerResult) => {
          if (result.hour !== undefined && result.minute !== undefined) {
            const hh: string = String(result.hour).padStart(2, '0')
            const mm: string = String(result.minute).padStart(2, '0')
            const ss: string = result.second !== undefined ? String(result.second).padStart(2, '0') : '00'
            const str: string = hh + ':' + mm + ':' + ss
            if (this.onSelect) { this.onSelect(str) }
          }
        }
      })
    })
  }
}

/**
 * CascadeRow - 级联选择器（多级下拉联动）
 */
@Component
export struct CascadeRow {
  label: string = ''
  @Prop value: string = ''
  options: string[] = []
  onSelect?: (v: string) => void

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
      Text(this.value || '请选择' + this.label)
        .fontSize(14).padding({left: 17})
        .fontColor(this.value ? $r('app.color.text') : $r('app.color.text_light'))
        .layoutWeight(1)
      Text('🔗').fontSize(14)
    }
    .width('100%').height(48).padding({ left: 16, right: 16 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
    .onClick(() => {
      if (this.options.length > 0) {
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
      }
    })
  }
}

/**
 * 多选弹窗 —— 包含 Checkbox 列表 + 操作栏。
 * 使用 @Prop 装饰器确保对话框参数在父组件重绘时保持有效引用。
 */
@CustomDialog
struct MultiSelectDialog {
  controller: CustomDialogController
  @Prop title: string = '请选择'
  @Prop options: Option[] = []
  @Prop initialSelected: string[] = []
  onConfirm?: (result: string) => void

  @State private checked: string[] = []

  aboutToAppear(): void {
    this.checked = [...this.initialSelected]
  }

  private isChecked(value: string): boolean {
    return this.checked.indexOf(value) >= 0
  }

  private toggle(value: string): void {
    const idx = this.checked.indexOf(value)
    if (idx >= 0) {
      this.checked.splice(idx, 1)
    } else {
      this.checked.push(value)
    }
    this.checked = [...this.checked]
  }

  private selectAll(): void {
    this.checked = this.options.map((o: Option) => o.value)
  }

  private deselectAll(): void {
    this.checked = []
  }

  build() {
    Column() {
      // ---- 标题栏 ----
      Row() {
        Text(this.title)
          .fontSize(16).fontWeight(FontWeight.Bold).fontColor($r('app.color.text'))
        Blank()
        Text('确定')
          .fontSize(14).fontWeight(FontWeight.Bold).fontColor($r('app.color.primary'))
          .onClick(() => {
            if (this.onConfirm) {
              this.onConfirm(this.checked.join(','))
            }
            this.controller.close()
          })
      }
      .width('100%').padding({ left: 16, right: 16, top: 14, bottom: 10 })
      .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })

      // ---- 快捷操作 ----
      Row({ space: 12 }) {
        Text('全选')
          .fontSize(12).fontColor($r('app.color.primary'))
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .border({ width: 1, color: $r('app.color.primary'), radius: 4 })
          .onClick(() => { this.selectAll() })
        Text('取消全选')
          .fontSize(12).fontColor($r('app.color.text_muted'))
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .border({ width: 1, color: $r('app.color.border_light'), radius: 4 })
          .onClick(() => { this.deselectAll() })
        Blank()
        Text('已选 ' + this.checked.length + '/' + this.options.length)
          .fontSize(12).fontColor($r('app.color.text_muted'))
      }
      .width('100%').padding({ left: 16, right: 16, top: 8, bottom: 8 })

      // ---- 选项列表 ----
      Scroll() {
        Column() {
          ForEach(this.options, (opt: Option, index: number) => {
            Row() {
              Checkbox({ name: opt.value, group: 'multiSelectGroup' })
                .select(this.isChecked(opt.value))
                .selectedColor($r('app.color.primary'))
                .onChange((checked: boolean) => {
                  this.toggle(opt.value)
                })
              Text(opt.label)
                .fontSize(14).fontColor($r('app.color.text'))
                .margin({ left: 8 })
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
            .onClick(() => { this.toggle(opt.value) })
          })
        }
      }
      .layoutWeight(1)
    }
    .width('100%').height('80%')
    .backgroundColor($r('app.color.bg'))
    .borderRadius({ topLeft: 16, topRight: 16 })
  }
}

/**
 * MultiSelectRow - 多选框（Chip 标签流式 + CustomDialog 勾选）。
 */
@Component
export struct MultiSelectRow {
  label: string = ''
  @Prop value: string = ''           // 逗号分隔的已选值
  options: Option[] = []
  onSelect?: (v: string) => void

  private dialogController: CustomDialogController | null = null

  private selectedItems(): string[] {
    if (!this.value || this.value.length === 0) { return [] }
    return this.value.split(',').map((s: string) => s.trim()).filter((s: string) => s.length > 0)
  }

  /** 根据 value 查找对应的 label，找不到时回退显示 value */
  private getLabel(value: string): string {
    const found: Option | undefined = this.options.find((o: Option) => o.value === value)
    return found ? found.label : value
  }

  private removeItem(item: string): void {
    const next = this.selectedItems().filter((s: string) => s !== item)
    if (this.onSelect) { this.onSelect(next.join(',')) }
  }

  private openDialog(): void {
    if (this.options.length === 0) { return }
    this.dialogController = new CustomDialogController({
      builder: MultiSelectDialog({
        title: '请选择' + this.label,
        options: this.options,
        initialSelected: this.selectedItems(),
        onConfirm: (result: string) => {
          if (this.onSelect) { this.onSelect(result) }
        }
      }),
      autoCancel: true,
      customStyle: true,
      maskColor: 'rgba(0,0,0,0.4)',
      alignment: DialogAlignment.Bottom
    })
    this.dialogController.open()
  }

  build() {
    Column() {
      Row() {
        // ---- 左侧标签 ----
        Text(this.label)
          .fontSize(13).fontColor($r('app.color.text_muted'))
          .fontWeight(FontWeight.Bold).width(56).flexShrink(0)

        // ---- 已选 Chip 标签流式布局 ----
        if (this.selectedItems().length > 0) {
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.selectedItems(), (item: string) => {
              Row({ space: 4 }) {
                Text(this.getLabel(item))
                  .fontSize(12).fontColor($r('app.color.primary_dark'))
                  .maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
                  .constraintSize({ maxWidth: 120 })
                Text('×')
                  .fontSize(14).fontColor($r('app.color.primary_dark'))
                  .fontWeight(FontWeight.Bold)
                  .onClick(() => { this.removeItem(item) })
              }
              .padding({ left: 8, right: 6, top: 4, bottom: 4 })
              .margin({ right: 6, bottom: 4 })
              .backgroundColor($r('app.color.primary_bg'))
              .border({ width: 1, color: $r('app.color.primary_border') })
              .borderRadius(4)
            })
          }
          .layoutWeight(1)
        } else {
          Text('请选择' + this.label)
            .fontSize(14).padding({ left: 17 })
            .fontColor($r('app.color.text_light'))
            .layoutWeight(1)
        }

        // ---- 箭头 ----
        Text('›')
          .fontSize(20).fontColor($r('app.color.text_muted'))
          .fontWeight(FontWeight.Bold)
          .padding({ left: 4 })
      }
      .width('100%')
    }
    .width('100%')
    .padding({ left: 16, right: 12, top: 10, bottom: 10 })
    .constraintSize({ minHeight: 48 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
    .onClick(() => { this.openDialog() })
  }
}

/**
 * TagInputRow - 标签输入组件
 */
@Component
export struct TagInputRow {
  label: string = ''
  @Prop value: string = ''
  onChange?: (v: string) => void

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
      TextInput({ text: this.value, placeholder: '输入标签(逗号分隔)' })
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

/**
 * TextAreaRow - 长文本多行输入组件
 */
@Component
export struct TextAreaRow {
  label: string = ''
  @Prop value: string = ''
  onChange?: (v: string) => void

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
        .alignSelf(ItemAlign.Start)
      TextArea({ text: this.value, placeholder: '请输入' + this.label })
        .placeholderColor($r('app.color.text_light'))
        .placeholderFont({size: 14})
        .fontSize(14).fontColor($r('app.color.text'))
        .backgroundColor($r('app.color.bg'))
        .layoutWeight(1)
        .maxLength(500)
        .onChange((v: string) => {
          if (this.onChange) { this.onChange(v) }
        })
    }
    .width('100%').constraintSize({ minHeight: 72 })
    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
  }
}

/**
 * ImagePickerRow - 图片上传选择组件
 */
@Component
export struct ImagePickerRow {
  label: string = ''
  @Prop value: string = ''
  onSelect?: (v: string) => void

  private fileList(): string[] {
    if (!this.value || this.value.length === 0) { return [] }
    return this.value.split(',').map((s: string) => s.trim()).filter((s: string) => s.length > 0)
  }

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
        .alignSelf(ItemAlign.Start)
      if (this.fileList().length > 0) {
        Column({ space: 4 }) {
          ForEach(this.fileList(), (file: string) => {
            Row({ space: 4 }) {
              Text('🖼️').fontSize(10)
              Text(file)
                .fontSize(12).fontColor($r('app.color.text'))
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor($r('app.color.primary_bg'))
            .borderRadius($r('app.float.radius_sm'))
          })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      } else {
        Text('请选择' + this.label)
          .fontSize(14).padding({left: 17})
          .fontColor($r('app.color.text_light'))
          .layoutWeight(1)
      }
      Text('📷').fontSize(16)
    }
    .width('100%').padding({ left: 16, right: 16, top: 10, bottom: 10 })
    .constraintSize({ minHeight: 48 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
    .onClick(() => {
      TextPickerDialog.show({
        range: ['示例图片1.jpg', '示例图片2.jpg', '示例图片3.jpg', '清除选择'],
        selected: 0,
        onAccept: (result: TextPickerResult) => {
          if (result.index !== undefined) {
            const idx: number = result.index as number
            if (idx === 3) {
              if (this.onSelect) { this.onSelect('') }
            } else {
              const picked: string = '示例图片' + (idx + 1) + '.jpg'
              if (this.onSelect) { this.onSelect(picked) }
            }
          }
        }
      })
    })
  }
}

/**
 * VideoPickerRow - 视频上传选择组件
 */
@Component
export struct VideoPickerRow {
  label: string = ''
  @Prop value: string = ''
  onSelect?: (v: string) => void

  private fileList(): string[] {
    if (!this.value || this.value.length === 0) { return [] }
    return this.value.split(',').map((s: string) => s.trim()).filter((s: string) => s.length > 0)
  }

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
        .alignSelf(ItemAlign.Start)
      if (this.fileList().length > 0) {
        Column({ space: 4 }) {
          ForEach(this.fileList(), (file: string) => {
            Row({ space: 4 }) {
              Text('🎬').fontSize(10)
              Text(file)
                .fontSize(12).fontColor($r('app.color.text'))
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor($r('app.color.warning_bg'))
            .borderRadius($r('app.float.radius_sm'))
          })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      } else {
        Text('请选择' + this.label)
          .fontSize(14).padding({left: 17})
          .fontColor($r('app.color.text_light'))
          .layoutWeight(1)
      }
      Text('▶️').fontSize(14)
    }
    .width('100%').padding({ left: 16, right: 16, top: 10, bottom: 10 })
    .constraintSize({ minHeight: 48 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
    .onClick(() => {
      TextPickerDialog.show({
        range: ['示例视频1.mp4', '示例视频2.mp4', '示例视频3.mp4', '清除选择'],
        selected: 0,
        onAccept: (result: TextPickerResult) => {
          if (result.index !== undefined) {
            const idx: number = result.index as number
            if (idx === 3) {
              if (this.onSelect) { this.onSelect('') }
            } else {
              const picked: string = '示例视频' + (idx + 1) + '.mp4'
              if (this.onSelect) { this.onSelect(picked) }
            }
          }
        }
      })
    })
  }
}

/**
 * FilePickerRow - 文件上传选择组件
 */
@Component
export struct FilePickerRow {
  label: string = ''
  @Prop value: string = ''
  onSelect?: (v: string) => void

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
      Text(this.value || '请选择' + this.label)
        .fontSize(14).padding({left: 17})
        .fontColor(this.value ? $r('app.color.text') : $r('app.color.text_light'))
        .layoutWeight(1)
      Text('📎').fontSize(16)
    }
    .width('100%').height(48).padding({ left: 16, right: 16 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
    .onClick(() => {
      TextPickerDialog.show({
        range: ['示例文档1.pdf', '示例文档2.docx', '示例文档3.xlsx', '清除选择'],
        selected: 0,
        onAccept: (result: TextPickerResult) => {
          if (result.index !== undefined) {
            const idx: number = result.index as number
            if (idx === 3) {
              if (this.onSelect) { this.onSelect('') }
            } else {
              const picked: string = '示例文档' + (idx + 1) + '.pdf'
              if (this.onSelect) { this.onSelect(picked) }
            }
          }
        }
      })
    })
  }
}

/**
 * AvatarPickerRow - 头像选择组件
 */
@Component
export struct AvatarPickerRow {
  label: string = ''
  @Prop value: string = ''
  onSelect?: (v: string) => void

  build() {
    Row() {
      Text(this.label).fontSize(13).fontColor($r('app.color.text_muted'))
        .fontWeight(FontWeight.Bold).width(56).flexShrink(0)
      // 头像预览
      if (this.value) {
        Avatar({ text: this.value, avatarSize: 36 })
      } else {
        Text('❓')
          .fontSize(20)
          .width(36).height(36)
          .borderRadius(18)
          .textAlign(TextAlign.Center)
          .backgroundColor($r('app.color.border_light'))
      }
      Text(this.value ? '点击更换' : '请选择' + this.label)
        .fontSize(14).padding({left: 12})
        .fontColor(this.value ? $r('app.color.text') : $r('app.color.text_light'))
        .layoutWeight(1)
      Text('📷').fontSize(16)
    }
    .width('100%').height(56).padding({ left: 16, right: 16 })
    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
    .onClick(() => {
      TextPickerDialog.show({
        range: ['头像选项A', '头像选项B', '头像选项C', '清除头像'],
        selected: 0,
        onAccept: (result: TextPickerResult) => {
          if (result.index !== undefined) {
            const idx: number = result.index as number
            if (idx === 3) {
              if (this.onSelect) { this.onSelect('') }
            } else {
              const picked: string = ['A', 'B', 'C'][idx]
              if (this.onSelect) { this.onSelect(picked) }
            }
          }
        }
      })
    })
  }
}

/**
 * 加载更多底部指示器。
 * - isLoading=true  → 显示加载动画 + "加载中..."
 * - isLoading=false → 有数据时显示 "上拉加载更多"，无数据时空白
 */
@Component
export struct LoadingFooter {
  @Prop isLoading: boolean = false
  @Prop hasData: boolean = true

  build() {
    Row() {
      if (this.isLoading) {
        LoadingProgress()
          .width(20).height(20)
          .color($r('app.color.primary'))
        Text('加载中...')
          .fontSize(13)
          .fontColor($r('app.color.text_muted'))
          .margin({ left: 8 })
      } else {
        Text(this.hasData ? '上拉加载更多' : '')
          .fontSize(13)
          .fontColor($r('app.color.text_muted'))
          .textAlign(TextAlign.Center)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 12, bottom: 12 })
    .backgroundColor($r('app.color.bg_page'))
  }
}
