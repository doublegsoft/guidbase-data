<#import "/$/guidbase-tile.ftl" as guidbase_tile>

<!----------------------------------------------------------------------------->
<!--                            SCROLL NAVIGATOR                             -->
<!----------------------------------------------------------------------------->
<#macro print_scroll_navigator_layout navigator indent=0>
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
<#macro print_slide_navigator_layout navigator indent=0>
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
<#macro print_button_navigator_layout navigator indent=0>
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
<#macro print_list_navigator_layout navigator indent=0>
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
<#macro print_list_view_layout list indent=0>
  <#local url = valuebase.url(list.value("data"))>
${""?left_pad(indent)}Refresh({ refreshing: $$this.isRefreshing${ts.nameType(list.id)} }) {
${""?left_pad(indent)}  List({ space: 8 }) {
${""?left_pad(indent)}    ForEach(this.${js.nameVariable(list.id)}Rows, (row: ${ts.nameType(url.resource)}) => {
${""?left_pad(indent)}      ListItem() {
${""?left_pad(indent)}        Column() {
<@guidbase_tile.print_layout_tile widget=list indent=indent+10 />
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .onClick(() => {  
${""?left_pad(indent)}        this.handle${ts.nameType(list.id)}Click(row)
${""?left_pad(indent)}      })
${""?left_pad(indent)}    })
${""?left_pad(indent)}    ListItem() {
${""?left_pad(indent)}      Row() {
${""?left_pad(indent)}        if (this.isLoading${ts.nameType(list.id)}) {
${""?left_pad(indent)}          LoadingProgress().width(20).height(20).color($r('app.color.primary'))
${""?left_pad(indent)}          Text('加载中...').fontSize(13).fontColor($r('app.color.text_muted')).margin({ left: 8 })
${""?left_pad(indent)}        } else {
${""?left_pad(indent)}          Text('上拉加载更多').fontSize(13).fontColor($r('app.color.text_muted'))
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .width('100%')
${""?left_pad(indent)}      .justifyContent(FlexAlign.Center)
${""?left_pad(indent)}      .padding({ top: 12, bottom: 12 })
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .width('100%')
${""?left_pad(indent)}  .backgroundColor($r('app.color.bg_page'))
${""?left_pad(indent)}  .onReachEnd(() => {
${""?left_pad(indent)}     this.handle${ts.nameType(list.id)}Load()
${""?left_pad(indent)}  })
${""?left_pad(indent)}}
${""?left_pad(indent)}.layoutWeight(1)
${""?left_pad(indent)}.onRefreshing(() => {
${""?left_pad(indent)}  this.handle${ts.nameType(list.id)}Refresh()
${""?left_pad(indent)}})
</#macro>

<#macro print_list_view_variables list indent=0>
  <#local url = valuebase.url(list.value("data"))>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 【${list.id}】列表视图相关变量，包括列表数据、正在刷新、正在加载等变量
${""?left_pad(indent)} */
${""?left_pad(indent)}@State
${""?left_pad(indent)}private ${ts.nameVariable(list.id)}Rows: ${ts.nameType(url.resource)}[] = []
${""?left_pad(indent)}@State
${""?left_pad(indent)}private isRefreshing${ts.nameType(list.id)}: boolean = false
${""?left_pad(indent)}@State
${""?left_pad(indent)}private isLoading${ts.nameType(list.id)}: boolean = false
</#macro>

<#macro print_list_view_methods list indent=0>
  <#local url = valuebase.url(list.value("data"))>
  <#local next = valuebase.url(list.value("next"))>
  <#local nextPage = guidbase.get_page(app, next.resource)>
  <#local obj = model.findObjectByName(url.resource)>
  <#local idAttr = obj.identifiableAttribute>
${""?left_pad(indent)}  
${""?left_pad(indent)}aboutToAppear(): void {
${""?left_pad(indent)}  this.load${ts.nameType(list.id)}Rows()
${""?left_pad(indent)}}
${""?left_pad(indent)}  
${""?left_pad(indent)}async load${ts.nameType(list.id)}Rows(): Promise<void> {
${""?left_pad(indent)}  const result = await sdk.fetch${ts.nameType(inflector.pluralize(url.resource))}({})
${""?left_pad(indent)}  this.${ts.nameVariable(list.id)}Rows = result.data
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}async handle${ts.nameType(list.id)}Refresh(): Promise<void> {
${""?left_pad(indent)}  this.isRefreshing${ts.nameType(list.id)} = true
${""?left_pad(indent)}  const result = await sdk.fetch${ts.nameType(inflector.pluralize(url.resource))}({})
${""?left_pad(indent)}  this.demoListRows = result.data
${""?left_pad(indent)}  this.isRefreshing${ts.nameType(list.id)} = false
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}async handle${ts.nameType(list.id)}Load(): Promise<void> {
${""?left_pad(indent)}  if (this.isLoading${ts.nameType(list.id)}) {
${""?left_pad(indent)}    return
${""?left_pad(indent)}  }
${""?left_pad(indent)}  this.isLoading${ts.nameType(list.id)} = true
${""?left_pad(indent)}  const result = await sdk.fetch${ts.nameType(inflector.pluralize(url.resource))}({})
${""?left_pad(indent)}  this.${ts.nameVariable(list.id)}Rows = this.${ts.nameVariable(list.id)}Rows.concat(result.data)
${""?left_pad(indent)}  this.isLoading${ts.nameType(list.id)} = false
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}handle${ts.nameType(list.id)}Click(row: ${ts.nameType(url.resource)}) {
${""?left_pad(indent)}  const uiContext = this.getUIContext();
${""?left_pad(indent)}  const router = uiContext.getRouter();
${""?left_pad(indent)}  router.pushUrl({
${""?left_pad(indent)}    url: 'pages/${nextPage.module}/${ts.nameType(nextPage.name)}',
${""?left_pad(indent)}    params: { ${modelbase.get_attribute_sql_name(idAttr)}: row.${modelbase.get_attribute_sql_name(idAttr)} }
${""?left_pad(indent)}  }).catch(() => {
${""?left_pad(indent)}    // nothing to do
${""?left_pad(indent)}  })
${""?left_pad(indent)}}
</#macro>

<!----------------------------------------------------------------------------->
<!--                               GRID VIEW                                 -->
<!----------------------------------------------------------------------------->
<#macro print_grid_view_layout grid indent=0>
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
<#macro print_entry_form_layout form indent=0>
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
<#macro print_display_form_layout form indent=0>
  <#local url = valuebase.url(form.value("data"))>
${""?left_pad(indent)}Column() {
  <#list form.groups() as group>
${""?left_pad(indent)}  FormSection({
${""?left_pad(indent)}    title: '${group}',
${""?left_pad(indent)}    rows: [
    <#local rows = form.rows(group, 1)>
    <#list rows as row>
      <#list row as input>
        <#if input.type == "hidden"><#continue></#if>
${""?left_pad(indent)}      { label: '${input.title}', value: String(this.${ts.nameVariable(form.id)}Data!.${ts.nameVariable(input.id)}) },    
      </#list>
    </#list>
${""?left_pad(indent)}    ],
${""?left_pad(indent)}  })   
  </#list>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(16)
${""?left_pad(indent)}.backgroundColor($r('app.color.bg'))
${""?left_pad(indent)}.borderRadius(8)
</#macro>

<#macro print_display_form_variables form indent=0>
  <#local url = valuebase.url(form.value("data"))>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 【${form.id}】只读表单相关变量，包括表单数据、正在加载等变量
${""?left_pad(indent)} */
${""?left_pad(indent)}@State
${""?left_pad(indent)}private ${ts.nameVariable(form.id)}Data: ${ts.nameType(url.resource)} | null = null
${""?left_pad(indent)}@State
${""?left_pad(indent)}private isLoading${ts.nameType(form.id)}: boolean = false
</#macro>

<#macro print_display_form_methods form indent=0>
  <#local url = valuebase.url(form.value("data"))>
  <#local obj = model.findObjectByName(url.resource)>
  <#local idAttr = obj.identifiableAttribute>
${""?left_pad(indent)}  
${""?left_pad(indent)}aboutToAppear(): void {
${""?left_pad(indent)}  const uiContext = this.getUIContext();
${""?left_pad(indent)}    const router = uiContext.getRouter();
${""?left_pad(indent)}    const params = router.getParams() as Record<string, Object>
${""?left_pad(indent)}    let ${modelbase.get_attribute_sql_name(idAttr)}: number = 0
${""?left_pad(indent)}    if (params && params['${modelbase.get_attribute_sql_name(idAttr)}']) {
${""?left_pad(indent)}      ${modelbase.get_attribute_sql_name(idAttr)} = params['${modelbase.get_attribute_sql_name(idAttr)}'] as number
${""?left_pad(indent)}    }
${""?left_pad(indent)}  this.load${ts.nameType(form.id)}Data(${modelbase.get_attribute_sql_name(idAttr)})
${""?left_pad(indent)}}
${""?left_pad(indent)}  
${""?left_pad(indent)}async load${ts.nameType(form.id)}Data(${modelbase.get_attribute_sql_name(idAttr)}: ${guidbase4ts.type_attribute_primitive(idAttr)}): Promise<void> {
${""?left_pad(indent)}  const result = await sdk.fetch${ts.nameType(url.resource)}({
${""?left_pad(indent)}    '${modelbase.get_attribute_sql_name(idAttr)}': ${modelbase.get_attribute_sql_name(idAttr)},
${""?left_pad(indent)}  })
${""?left_pad(indent)}  this.${ts.nameVariable(form.id)}Data = result
${""?left_pad(indent)}}
${""?left_pad(indent)}
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 TABS                                    -->
<!----------------------------------------------------------------------------->
<#macro print_tabs_layout tabs indent=0>
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
<#macro print_segments_layout segments indent=0>
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
<#macro print_tile_layout tile indent=0>
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
<#macro print_button_layout button indent=0>
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
<#macro print_input_layout input indent=0>
${""?left_pad(indent)}TextInput({ text: this.${js.nameVariable(input.id)}, placeholder: '请输入${input.title}' })
${""?left_pad(indent)}  .placeholderColor($r('app.color.text_light'))
${""?left_pad(indent)}  .fontColor($r('app.color.text'))
${""?left_pad(indent)}  .backgroundColor($r('app.color.bg'))
${""?left_pad(indent)}  .border({ width: 1, color: $r('app.color.border'), radius: 4 })
${""?left_pad(indent)}  .onChange((val: string) => { this.handle${js.nameType(input.id)}Change(val) })
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 WIDGET                                  -->
<!----------------------------------------------------------------------------->
<#macro print_widget_layout widget indent=0>
  <#if widget.type == "scroll_navigator">
<@print_scroll_navigator_layout navigator=widget indent=indent />
  <#elseif widget.type == "slide_navigator">
<@print_slide_navigator_layout navigator=widget indent=indent />
  <#elseif widget.type == "button_navigator">
<@print_button_navigator_layout navigator=widget indent=indent />
  <#elseif widget.type == "list_navigator">
<@print_list_navigator_layout navigator=widget indent=indent />
  <#elseif widget.type == "list_view">
<@print_list_view_layout list=widget indent=indent />
  <#elseif widget.type == "grid_view">
<@print_grid_view_layout grid=widget indent=indent />
  <#elseif widget.type == "entry_form">
<@print_entry_form_layout form=widget indent=indent />
  <#elseif widget.type == "criteria_form">
<@print_criteria_form_layout form=widget indent=indent />
  <#elseif widget.type == "display_form">
<@print_display_form_layout form=widget indent=indent />
  <#elseif widget.type == "tabs">
<@print_tabs_layout tabs=widget indent=indent />
  <#elseif widget.type == "segments">
<@print_segments_layout segments=widget indent=indent />
  <#elseif widget.type == "tile">
<@print_tile_layout tile=widget indent=indent />
  <#elseif widget.type == "button">
<@print_button_layout button=widget indent=indent />
  <#elseif widget.type == "input">
<@print_input_layout input=widget indent=indent />
  </#if>
</#macro>

<#macro print_widget_variables widget indent=0>
  <#if widget.type == "scroll_navigator">
  <#elseif widget.type == "slide_navigator">
  <#elseif widget.type == "button_navigator">
  <#elseif widget.type == "list_navigator">
  <#elseif widget.type == "list_view">
<@print_list_view_variables list=widget indent=indent />
  <#elseif widget.type == "grid_view">
  <#elseif widget.type == "entry_form">
  <#elseif widget.type == "criteria_form">
  <#elseif widget.type == "display_form">
<@print_display_form_variables form=widget indent=indent />  
  <#elseif widget.type == "tabs">
  <#elseif widget.type == "segments">
  <#elseif widget.type == "tile">
  <#elseif widget.type == "button">
  <#elseif widget.type == "input">
  </#if>
</#macro>

<#macro print_widget_methods widget indent=0>
  <#if widget.type == "scroll_navigator">
  <#elseif widget.type == "slide_navigator">
  <#elseif widget.type == "button_navigator">
  <#elseif widget.type == "list_navigator">
  <#elseif widget.type == "list_view">
<@print_list_view_methods list=widget indent=indent />
  <#elseif widget.type == "grid_view">
  <#elseif widget.type == "entry_form">
  <#elseif widget.type == "criteria_form">
  <#elseif widget.type == "display_form">
<@print_display_form_methods form=widget indent=indent />  
  <#elseif widget.type == "tabs">
  <#elseif widget.type == "segments">
  <#elseif widget.type == "tile">
  <#elseif widget.type == "button">
  <#elseif widget.type == "input">
  </#if>
</#macro>
<!----------------------------------------------------------------------------->
<!--                                  PAGE                                   -->
<!----------------------------------------------------------------------------->
<#macro print_page_layout page indent=0>
  <#list page.children as child>
<@print_widget_layout widget=child indent=indent />   
  </#list>
</#macro>

<#macro print_page_variables page indent=0>
  <#list page.children as child>
<@print_widget_variables widget=child indent=indent />   
  </#list>
</#macro>

<#macro print_page_methods page indent=0>
  <#list page.children as child>
<@print_widget_methods widget=child indent=indent />   
  </#list>
</#macro>