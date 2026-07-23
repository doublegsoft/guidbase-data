<#import "/$/modelbase.ftl" as modelbase>
/**
 * 【${page.title}】页面。
 */
@Entry
@Component
struct ${ts.nameType(page.name)}Index {
  build() {
    Column() {
      Text('Hello World')
        .fontSize(20)
        .fontColor('#333333')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}