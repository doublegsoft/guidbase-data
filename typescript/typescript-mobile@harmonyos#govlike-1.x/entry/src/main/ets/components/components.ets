// components/Components.ets
import { Theme } from '../common/theme/Theme';

/**
 * 1. Topbar Component (政务红色渐变头)
 */
@Component
export struct Topbar {
  private logoText: string = '政务办公平台';
  private logoEmText: string = '【主系统】';
  @BuilderParam customRightSlot?: () => void;

  build() {
    Row() {
      // Logo block
      Row() {
        Text(this.logoText)
          .fontSize(15)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .fontFamily(Theme.FONT_FAMILY)
        Text(this.logoEmText)
          .fontSize(15)
          .fontColor($r('app.color.gold'))
          .fontWeight(FontWeight.Bolder)
          .fontFamily(Theme.FONT_FAMILY)
      }
      .padding({ right: 16 })
      .margin({ right: 16 })
      .border({ width: { right: 1 }, color: 'rgba(255,255,255,0.2)' })

      // Flexible space
      Blank()

      // Right slot
      if (this.customRightSlot) {
        this.customRightSlot()
      } else {
        Row({ space: 14 }) {
          Text('管理员')
            .fontSize(12)
            .fontColor(Color.White)
          Text('安全退出')
            .fontSize(12)
            .fontColor($r('app.color.gold'))
        }
      }
    }
    .width('100%')
    .height(Theme.TOPBAR_HEIGHT)
    .padding({ left: 20, right: 20 })
    .linearGradient({
      angle: 135,
      colors: [
        ['#7A0000', 0.0],
        ['#A30000', 0.45],
        ['#BE0000', 0.70],
        ['#8A0000', 1.0]
      ]
    })
    .border({ width: { bottom: 3 }, color: $r('app.color.gold') })
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.15)', offsetY: 3 })
  }
}

/**
 * 2. Panel Component (左红带经典面板)
 */
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
        
        Text(this.title)
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.type === 'default' ? $r('app.color.primary_dark') : this.getAccentColor())
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

/**
 * 3. Tag / Badge (高饱和度标签)
 */
@Component
export struct Tag {
  private text: string = '标签';
  private variant: 'success' | 'danger' | 'warning' | 'primary' | 'neutral' = 'neutral';

  private getColors(): { bg: Resource, text: Resource, border: Resource } {
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
    Text(this.text)
      .fontSize(10)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.getColors().text)
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor(this.getColors().bg)
      .border({ width: 1, color: this.getColors().border })
      .borderRadius($r('app.float.radius_sm'))
  }
}