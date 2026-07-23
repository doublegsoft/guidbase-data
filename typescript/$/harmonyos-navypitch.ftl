<#include "harmonyos.ftl" as harmonyos>
<!----------------------------------------------------------------------------->
<!--                            SCROLL NAVIGATOR                             -->
<!----------------------------------------------------------------------------->
<#macro print_layout_scroll_navigator navigator indent=0>
${""?left_pad(indent)}Scroll() {
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(this.${js.nameVariable(navigator.id)}Items, (item: any) => {
${""?left_pad(indent)}      Column() {
${""?left_pad(indent)}        Text(item.title)
${""?left_pad(indent)}          .fontSize(14)
${""?left_pad(indent)}          .fontColor(this.activeNavId === item.id ? $r('app.color.primary') : $r('app.color.text'))
${""?left_pad(indent)}          .fontWeight(this.activeNavId === item.id ? FontWeight.Bold : FontWeight.Normal)
${""?left_pad(indent)}        if (this.activeNavId === item.id) {
${""?left_pad(indent)}          Row()
${""?left_pad(indent)}            .width(20)
${""?left_pad(indent)}            .height(2)
${""?left_pad(indent)}            .backgroundColor($r('app.color.primary'))
${""?left_pad(indent)}            .margin({ top: 4 })
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .margin({ left: 16, right: 16 })
${""?left_pad(indent)}      .onClick(() => { this.handle${js.nameType(navigator.id)}Click(item.id) })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}.scrollable(ScrollDirection.Horizontal)
${""?left_pad(indent)}.scrollBar(BarState.Off)
</#macro>

<!----------------------------------------------------------------------------->
<!--                             SLIDE NAVIGATOR                             -->
<!----------------------------------------------------------------------------->
<#macro print_layout_slide_navigator navigator indent=0>
${""?left_pad(indent)}Swiper() {
${""?left_pad(indent)}  ForEach(this.${js.nameVariable(navigator.id)}Items, (item: any) => {
${""?left_pad(indent)}    Image(item.imageUrl)
${""?left_pad(indent)}      .width('100%')
${""?left_pad(indent)}      .height('100%')
${""?left_pad(indent)}      .objectFit(ImageFit.Cover)
${""?left_pad(indent)}      .onClick(() => { this.handle${js.nameType(navigator.id)}Click(item.link) })
${""?left_pad(indent)}  })
${""?left_pad(indent)}}
${""?left_pad(indent)}.width('100%')
${""?left_pad(indent)}.height(180)
${""?left_pad(indent)}.autoPlay(true)
${""?left_pad(indent)}.interval(3000)
${""?left_pad(indent)}.indicatorStyle({ selectedColor: $r('app.color.primary'), color: $r('app.color.border_light') })
</#macro>

<!----------------------------------------------------------------------------->
<!--                            BUTTON NAVIGATOR                             -->
<!----------------------------------------------------------------------------->
<#macro print_layout_button_navigator navigator indent=0>
${""?left_pad(indent)}Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceAround }) {
${""?left_pad(indent)}  ForEach(this.${js.nameVariable(navigator.id)}Items, (item: any) => {
${""?left_pad(indent)}    Column() {
${""?left_pad(indent)}      Image(item.iconUrl)
${""?left_pad(indent)}        .width(44)
${""?left_pad(indent)}        .height(44)
${""?left_pad(indent)}        .margin({ bottom: 8 })
${""?left_pad(indent)}      Text(item.title)
${""?left_pad(indent)}        .fontSize(12)
${""?left_pad(indent)}        .fontColor($r('app.color.text'))
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .width('25%')
${""?left_pad(indent)}    .margin({ top: 12, bottom: 12 })
${""?left_pad(indent)}    .alignItems(HorizontalAlign.Center)
${""?left_pad(indent)}    .onClick(() => { this.handle${js.nameType(navigator.id)}Click(item) })
${""?left_pad(indent)}  })
${""?left_pad(indent)}}
${""?left_pad(indent)}.backgroundColor($r('app.color.bg'))
${""?left_pad(indent)}.padding({ top: 8, bottom: 8 })
</#macro>

<!----------------------------------------------------------------------------->
<!--                             LIST NAVIGATOR                              -->
<!----------------------------------------------------------------------------->
<#macro print_layout_list_navigator navigator indent=0>
${""?left_pad(indent)}List() {
${""?left_pad(indent)}  ForEach(this.${js.nameVariable(navigator.id)}Items, (item: any) => {
${""?left_pad(indent)}    ListItem() {
${""?left_pad(indent)}      Row() {
${""?left_pad(indent)}        Row() {
${""?left_pad(indent)}          if (item.icon) {
${""?left_pad(indent)}            Image(item.icon)
${""?left_pad(indent)}              .width(24)
${""?left_pad(indent)}              .height(24)
${""?left_pad(indent)}              .margin({ right: 12 })
${""?left_pad(indent)}          }
${""?left_pad(indent)}          Text(item.title)
${""?left_pad(indent)}            .fontSize(16)
${""?left_pad(indent)}            .fontColor($r('app.color.text'))
${""?left_pad(indent)}        }
${""?left_pad(indent)}        Text('>')
${""?left_pad(indent)}          .fontSize(16)
${""?left_pad(indent)}          .fontColor($r('app.color.text_light'))
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .width('100%')
${""?left_pad(indent)}      .justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
${""?left_pad(indent)}      .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
${""?left_pad(indent)}      .onClick(() => { this.handle${js.nameType(navigator.id)}Click(item) })
${""?left_pad(indent)}    }
${""?left_pad(indent)}  })
${""?left_pad(indent)}}
${""?left_pad(indent)}.width('100%')
${""?left_pad(indent)}.backgroundColor($r('app.color.bg'))
</#macro>

<!----------------------------------------------------------------------------->
<!--                               LIST VIEW                                 -->
<!----------------------------------------------------------------------------->
<#macro print_layout_list_view list indent=0>
${""?left_pad(indent)}List({ space: 8 }) {
${""?left_pad(indent)}  ForEach(this.${js.nameVariable(list.id)}Items, (item: any) => {
${""?left_pad(indent)}    ListItem() {
${""?left_pad(indent)}      Column() {
${""?left_pad(indent)}        Text(item.title)
${""?left_pad(indent)}          .fontSize(16)
${""?left_pad(indent)}          .fontColor($r('app.color.text'))
${""?left_pad(indent)}          .fontWeight(FontWeight.Medium)
${""?left_pad(indent)}        if (item.desc) {
${""?left_pad(indent)}          Text(item.desc)
${""?left_pad(indent)}            .fontSize(14)
${""?left_pad(indent)}            .fontColor($r('app.color.text_muted'))
${""?left_pad(indent)}            .margin({ top: 4 })
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .width('100%')
${""?left_pad(indent)}      .padding(16)
${""?left_pad(indent)}      .backgroundColor($r('app.color.bg'))
${""?left_pad(indent)}      .borderRadius(8)
${""?left_pad(indent)}      .onClick(() => { this.handle${js.nameType(list.id)}ItemClick(item) })
${""?left_pad(indent)}    }
${""?left_pad(indent)}  })
${""?left_pad(indent)}}
${""?left_pad(indent)}.width('100%')
${""?left_pad(indent)}.backgroundColor($r('app.color.bg_page'))
</#macro>

<!----------------------------------------------------------------------------->
<!--                               GRID VIEW                                 -->
<!----------------------------------------------------------------------------->
<#macro print_layout_grid_view grid indent=0>
${""?left_pad(indent)}Grid() {
${""?left_pad(indent)}  ForEach(this.${js.nameVariable(grid.id)}Items, (item: any) => {
${""?left_pad(indent)}    GridItem() {
${""?left_pad(indent)}      Column() {
${""?left_pad(indent)}        Image(item.iconUrl)
${""?left_pad(indent)}          .width(60)
${""?left_pad(indent)}          .height(60)
${""?left_pad(indent)}          .objectFit(ImageFit.Contain)
${""?left_pad(indent)}          .margin({ bottom: 8 })
${""?left_pad(indent)}        Text(item.title)
${""?left_pad(indent)}          .fontSize(14)
${""?left_pad(indent)}          .fontColor($r('app.color.text'))
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .width('100%')
${""?left_pad(indent)}      .padding(12)
${""?left_pad(indent)}      .backgroundColor($r('app.color.bg'))
${""?left_pad(indent)}      .borderRadius(8)
${""?left_pad(indent)}      .onClick(() => { this.handle${js.nameType(grid.id)}ItemClick(item) })
${""?left_pad(indent)}    }
${""?left_pad(indent)}  })
${""?left_pad(indent)}}
${""?left_pad(indent)}.columnsTemplate('1fr 1fr')
${""?left_pad(indent)}.rowsGap(8)
${""?left_pad(indent)}.columnsGap(8)
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.backgroundColor($r('app.color.bg_page'))
</#macro>

<!----------------------------------------------------------------------------->
<!--                              ENTRY FORM                                 -->
<!----------------------------------------------------------------------------->
<#macro print_layout_entry_form form indent=0>
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  ForEach(this.${js.nameVariable(form.id)}Fields, (field: any) => {
${""?left_pad(indent)}    Column() {
${""?left_pad(indent)}      Row() {
${""?left_pad(indent)}        Text(field.label)
${""?left_pad(indent)}          .fontSize(14)
${""?left_pad(indent)}          .fontColor($r('app.color.text'))
${""?left_pad(indent)}        if (field.required) {
${""?left_pad(indent)}          Text('*')
${""?left_pad(indent)}            .fontColor($r('app.color.danger'))
${""?left_pad(indent)}            .margin({ left: 4 })
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .width('100%')
${""?left_pad(indent)}      .margin({ bottom: 8 })
${""?left_pad(indent)}
${""?left_pad(indent)}      TextInput({ text: field.value, placeholder: field.placeholder })
${""?left_pad(indent)}        .width('100%')
${""?left_pad(indent)}        .placeholderColor($r('app.color.text_light'))
${""?left_pad(indent)}        .onChange((val: string) => { this.handle${js.nameType(form.id)}FieldChange(field.id, val) })
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .margin({ bottom: 16 })
${""?left_pad(indent)}  })
${""?left_pad(indent)}
${""?left_pad(indent)}  Button('提交')
${""?left_pad(indent)}    .backgroundColor($r('app.color.primary'))
${""?left_pad(indent)}    .width('100%')
${""?left_pad(indent)}    .margin({ top: 16 })
${""?left_pad(indent)}    .onClick(() => { this.handle${js.nameType(form.id)}Submit() })
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(16)
${""?left_pad(indent)}.backgroundColor($r('app.color.bg'))
</#macro>

<!----------------------------------------------------------------------------->
<!--                             DISPLAY FORM                                -->
<!----------------------------------------------------------------------------->
<#macro print_layout_display_form form indent=0>
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  ForEach(this.${js.nameVariable(form.id)}Details, (item: any) => {
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      Text(item.label)
${""?left_pad(indent)}        .fontSize(14)
${""?left_pad(indent)}        .fontColor($r('app.color.text_muted'))
${""?left_pad(indent)}        .width(100)
${""?left_pad(indent)}      Text(item.value)
${""?left_pad(indent)}        .fontSize(14)
${""?left_pad(indent)}        .fontColor($r('app.color.text'))
${""?left_pad(indent)}        .layoutWeight(1)
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .width('100%')
${""?left_pad(indent)}    .padding({ top: 12, bottom: 12 })
${""?left_pad(indent)}    .border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
${""?left_pad(indent)}  })
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(16)
${""?left_pad(indent)}.backgroundColor($r('app.color.bg'))
${""?left_pad(indent)}.borderRadius(8)
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 TABS                                    -->
<!----------------------------------------------------------------------------->
<#macro print_layout_tabs tabs indent=0>
${""?left_pad(indent)}Tabs() {
${""?left_pad(indent)}  ForEach(this.${js.nameVariable(tabs.id)}List, (tab: any) => {
${""?left_pad(indent)}    TabContent() {
${""?left_pad(indent)}      // 占位区域，可嵌入自定义 Builder
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .tabBar(tab.title)
${""?left_pad(indent)}  })
${""?left_pad(indent)}}
${""?left_pad(indent)}.barMode(BarMode.Fixed)
${""?left_pad(indent)}.onChange((index: number) => { this.handle${js.nameType(tabs.id)}Change(index) })
</#macro>

<!----------------------------------------------------------------------------->
<!--                               SEGMENTS                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_segments segments indent=0>
${""?left_pad(indent)}Row() {
${""?left_pad(indent)}  ForEach(this.${js.nameVariable(segments.id)}List, (item: any, index: number) => {
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      Text(item.label)
${""?left_pad(indent)}        .fontSize(14)
${""?left_pad(indent)}        .fontColor(this.${js.nameVariable(segments.id)}Index === index ? $r('app.color.bg') : $r('app.color.text_muted'))
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .layoutWeight(1)
${""?left_pad(indent)}    .height(36)
${""?left_pad(indent)}    .justifyContent(FlexAlign.Center)
${""?left_pad(indent)}    .backgroundColor(this.${js.nameVariable(segments.id)}Index === index ? $r('app.color.primary') : $r('app.color.bg'))
${""?left_pad(indent)}    .borderRadius(18)
${""?left_pad(indent)}    .onClick(() => { this.handle${js.nameType(segments.id)}Click(index) })
${""?left_pad(indent)}  })
${""?left_pad(indent)}}
${""?left_pad(indent)}.width('100%')
${""?left_pad(indent)}.padding(4)
${""?left_pad(indent)}.backgroundColor($r('app.color.border_light'))
${""?left_pad(indent)}.borderRadius(20)
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 TILE                                    -->
<!----------------------------------------------------------------------------->
<#macro print_layout_tile tile indent=0>
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    if (this.${js.nameVariable(tile.id)}.image) {
${""?left_pad(indent)}      Image(this.${js.nameVariable(tile.id)}.image)
${""?left_pad(indent)}        .width(60)
${""?left_pad(indent)}        .height(60)
${""?left_pad(indent)}        .borderRadius(4)
${""?left_pad(indent)}        .margin({ right: 12 })
${""?left_pad(indent)}    }
${""?left_pad(indent)}    Column() {
${""?left_pad(indent)}      Text(this.${js.nameVariable(tile.id)}.title)
${""?left_pad(indent)}        .fontSize(16)
${""?left_pad(indent)}        .fontColor($r('app.color.text'))
${""?left_pad(indent)}        .fontWeight(FontWeight.Bold)
${""?left_pad(indent)}      if (this.${js.nameVariable(tile.id)}.desc) {
${""?left_pad(indent)}        Text(this.${js.nameVariable(tile.id)}.desc)
${""?left_pad(indent)}          .fontSize(12)
${""?left_pad(indent)}          .fontColor($r('app.color.text_muted'))
${""?left_pad(indent)}          .margin({ top: 4 })
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .layoutWeight(1)
${""?left_pad(indent)}    .alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .width('100%')
${""?left_pad(indent)}  .padding(12)
${""?left_pad(indent)}  .backgroundColor($r('app.color.bg'))
${""?left_pad(indent)}  .borderRadius(8)
${""?left_pad(indent)}  .onClick(() => { this.handle${js.nameType(tile.id)}Click() })
${""?left_pad(indent)}}
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 BUTTON                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_button button indent=0>
${""?left_pad(indent)}Button('${button.title}')
${""?left_pad(indent)}  .fontSize(16)
${""?left_pad(indent)}  .fontColor($r('app.color.bg'))
${""?left_pad(indent)}  .backgroundColor($r('app.color.primary'))
${""?left_pad(indent)}  .borderRadius(8)
${""?left_pad(indent)}  .height(44)
${""?left_pad(indent)}  .onClick(() => { this.handle${js.nameType(button.id)}Tap() })
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  INPUT                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_input input indent=0>
${""?left_pad(indent)}TextInput({ text: this.${js.nameVariable(input.id)}, placeholder: '请输入${input.title}' })
${""?left_pad(indent)}  .placeholderColor($r('app.color.text_light'))
${""?left_pad(indent)}  .fontColor($r('app.color.text'))
${""?left_pad(indent)}  .backgroundColor($r('app.color.bg'))
${""?left_pad(indent)}  .border({ width: 1, color: $r('app.color.border'), radius: 4 })
${""?left_pad(indent)}  .onChange((val: string) => { this.handle${js.nameType(input.id)}Change(val) })
</#macro>