<#import "/$/modelbase.ftl" as modelbase>
import Foundation

<#assign methodAndWidgets = {}>
<#list pages![] as page>
  <#assign pageName = modelbase.url_to_page_name(page.uri)>
  <#list page.widgets as widget>
    <#assign variable = widget.variable!'todo'>
    <#if widget.widgetType == '传统列表' || widget.widgetType == 'ListView'>
      <#assign methodAndWidgets = methodAndWidgets + {('load' + swift.nameType(variable) + '4' + swift.nameType(pageName)): widget}>
    <#elseif widget.widgetType == '栅格列表'>
      <#assign methodAndWidgets = methodAndWidgets + {('load' + swift.nameType(variable) + '4' + swift.nameType(pageName)): widget}>
    <#elseif widget.widgetType == '编辑表单' ||  widget.widgetType == '花式表单' || widget.widgetType == 'FormLayout'>
      <#assign methodAndWidgets = methodAndWidgets + {('save' + swift.nameType(variable) + '4' + swift.nameType(pageName)): widget}>
      <#assign methodAndWidgets = methodAndWidgets + {('read' + swift.nameType(variable) + '4' + swift.nameType(pageName)): widget}>
    <#elseif widget.widgetType == '只读表单' || widget.widgetType == 'ReadonlyForm'>
      <#assign methodAndWidgets = methodAndWidgets + {('read' + swift.nameType(variable) + '4' + swift.nameType(pageName)): widget}>
    <#elseif widget.widgetType == '滚动导航' || widget.widgetType == '滑动导航'>
      <#assign methodAndWidgets = methodAndWidgets + {('load' + swift.nameType(variable) + '4' + swift.nameType(pageName)): widget}>
    </#if>
  </#list>
</#list>
<#assign optionizedFields = {}>
<#list pages as page>
  <#list page.widgets as widget>
    <#if widget.customForm??>
      <#assign custom = widget.customForm>
    <#elseif widget.customReadonly??>
      <#assign custom = widget.customReadonly>
    <#elseif widget.customStyled??>
      <#assign custom = widget.customStyled>
    </#if>
    <#if custom??>
      <#list custom.fields as field>
        <#if field.input == "select" || field.input == "radio" || field.input == "check">
          <#assign optionizedFields = optionizedFields + {modelbase.get_field_name(field): field}>
        </#if>
      </#list>
    </#if>
  </#list>
</#list>
<#assign methods = methodAndWidgets?keys?sort>
class ${swift.nameType(app.name)} {

  static let HOST = "http://localhost:8888";
<#list optionizedFields as name, field>

  static let options${swift.nameType(name)}: [[String:String]] = [
    ["text": "选项A", "value": "A"],
    ["text": "选项B", "value": "B"],
    ["text": "选项C", "value": "C"],
    ["text": "选项D", "value": "D"],
  ]
</#list>
<#list optionizedFields as name, field>

  public static func getOptionText${swift.nameType(name)}(value: String?) -> String {
    if value == nil {
      return ""
    }
    for option in options${swift.nameType(name)} {
      if value! == option["value"] {
        return option["text"]!
      }
    }
    return ""
  }
</#list>
<#list methods as method>
  <#assign widget = methodAndWidgets[method]>
  <#if method?starts_with('load')>

  /**
   * 加载【${widget.variable?upper_case}】数据。
   */
    <#if widget.widgetType == "滚动导航">
  func ${method}(params: [String:Any], success: @escaping ([ObjectMap]) -> Void, fail: @escaping ([String:Any]) -> Void) {
    Task {
      let data = await async${swift.nameType(method)}(params: params)
      success(data)
    }
  }

  func async${swift.nameType(method)}(params: [String:Any]) async -> [ObjectMap] {
    await Task.sleep(2_000_000_000)
    let data = [
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: ["${swift.nameVariable(widget.variable)}Id": "1", "url": "https://devops.cq-fyy.com/img/placeholder/ad_01.png"]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: ["${swift.nameVariable(widget.variable)}Id": "2", "url": "https://devops.cq-fyy.com/img/placeholder/ad_02.png"]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: ["${swift.nameVariable(widget.variable)}Id": "3", "url": "https://devops.cq-fyy.com/img/placeholder/ad_03.png"]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: ["${swift.nameVariable(widget.variable)}Id": "4", "url": "https://devops.cq-fyy.com/img/placeholder/ad_04.png"]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: ["${swift.nameVariable(widget.variable)}Id": "5", "url": "https://devops.cq-fyy.com/img/placeholder/ad_05.png"]),
    ]
    return data
  }
    <#elseif  widget.widgetType == "滑动导航">
  func ${method}(params: [String:Any], success: @escaping ([ObjectMap]) -> Void, fail: @escaping ([String:Any]) -> Void) {
    Task {
      let data = await async${swift.nameType(method)}(params: params)
      success(data)
    }
  }

  func async${swift.nameType(method)}(params: [String:Any]) async -> [ObjectMap] {
    await Task.sleep(2_000_000_000)
    let data = [
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: ["${swift.nameVariable(widget.variable)}Id": "1", "url": "https://devops.cq-fyy.com/img/placeholder/ad_06.png"]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: ["${swift.nameVariable(widget.variable)}Id": "2", "url": "https://devops.cq-fyy.com/img/placeholder/ad_07.png"]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: ["${swift.nameVariable(widget.variable)}Id": "3", "url": "https://devops.cq-fyy.com/img/placeholder/ad_08.png"]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: ["${swift.nameVariable(widget.variable)}Id": "4", "url": "https://devops.cq-fyy.com/img/placeholder/ad_09.png"]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: ["${swift.nameVariable(widget.variable)}Id": "5", "url": "https://devops.cq-fyy.com/img/placeholder/ad_10.png"]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: ["${swift.nameVariable(widget.variable)}Id": "6", "url": "https://devops.cq-fyy.com/img/placeholder/ad_11.png"]),
    ]
    return data
  }
    <#elseif  widget.widgetType == "传统列表">
  func ${method}(params: [String:Any], success: @escaping ([ObjectMap]) -> Void, fail: @escaping ([String:Any]) -> Void) {
    Task {
      let data = await async${swift.nameType(method)}(params: params)
      success(data)
    }
  }

  func async${swift.nameType(method)}(params: [String:Any]) async -> [ObjectMap] {
    await Task.sleep(2_000_000_000)
    let data = [
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "1",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_01.png",
        "title": "奥林匹克精神超越国界",
        "summary": "6月23日是国际奥林匹克日。习近平总书记曾在多个场合谈到奥林匹克精神，发表一系列重要论述。",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "2",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_02.png",
        "title": "2023年国际划联龙舟世界杯闭幕",
        "summary": "6月23日，2023年国际划联龙舟世界杯收官。",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "3",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_03.png",
        "title": "专访《消失的她》导演：人物是悬疑的核心",
        "summary": "据灯塔专业版实时数据，截至6月23日14时49分，2023年端午档大盘票房突破5亿元(人民币，下同)，其中影片《消失的她》档期内票房2.55亿元，成为中国影史端午档国产片票房冠军。",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "4",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_04.png",
        "title": "熊猫兄妹在广西南宁过生日",
        "summary": "6月23日，来自成都大熊猫繁育研究基地的熊猫兄妹“绩美”和“绩兰”，在南宁动物园过7岁生日，吸引了许多民众前来观看、拍照留念。",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "5",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_05.png",
        "title": "马斯克和扎克伯格“约架”，你看好谁？",
        "summary": "中新网6月23日电 综合外媒报道，近日，科技圈内掀起一场轰动的“决斗”风波。特斯拉CEO马斯克和Facebook创始人扎克伯格和不仅隔空“互掐”，甚至在线“约架”，引起全球网友关注。",
      ]),
    ]
    return data
  }
    <#elseif  widget.widgetType == "栅格列表">
  func ${method}(params: [String:Any], success: @escaping ([ObjectMap]) -> Void, fail: @escaping ([String:Any]) -> Void) {
    Task {
      let data = await async${swift.nameType(method)}(params: params)
      success(data)
    }
  }

  func async${swift.nameType(method)}(params: [String:Any]) async -> [ObjectMap] {
    await Task.sleep(2_000_000_000)
    let data = [
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "1",
        "image": "https://devops.cq-fyy.com/img/placeholder/avt_01.jpg",
        "title": "这是一件商品",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "2",
        "image": "https://devops.cq-fyy.com/img/placeholder/avt_02.jpg",
        "title": "这是一本书",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "3",
        "image": "https://devops.cq-fyy.com/img/placeholder/avt_03.jpg",
        "title": "这是一个名字有点长的人",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "4",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_04.png",
        "title": "这是另一本书",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "5",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_05.png",
        "title": "这个书的销量全球突破10亿元",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "6",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_01.png",
        "title": "这是另一个人",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "7",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_05.png",
        "title": "这个人的名字很长很长很长很长很长",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "8",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_02.png",
        "title": "这是另一件商品",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "9",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_03.png",
        "title": "这是另一本书",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "10",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_04.png",
        "title": "这件商品每年卖出上百万件",
      ]),
      ObjectMap("${swift.nameVariable(widget.variable)}Id", values: [
        "${swift.nameVariable(widget.variable)}Id": "11",
        "image": "https://devops.cq-fyy.com/img/placeholder/mdse_01.png",
        "title": "这件商品每年卖出上百万件",
      ]),
    ]
    return data
  }
    <#else>
  func ${method}(params: [String:Any], success: @escaping ([[String:Any]]) -> Void, fail: @escaping ([String:Any]) -> Void) {

  }
    </#if>
  <#elseif method?starts_with("read")>

  /**
   * 读取【${widget.variable?upper_case}】数据。
   */
  func ${method}(params: [String:Any], success: @escaping ([String:Any]) -> Void, fail: @escaping ([String:Any]) -> Void) {
    <#assign custom = {"fields": []}>
    <#if widget.customForm??>
      <#assign custom = widget.customForm>
    <#elseif widget.customReadonly??>
      <#assign custom = widget.customReadonly>
    <#elseif widget.customStyled??>
      <#assign custom = widget.customStyled>
    </#if>
    var data: [String:Any] = [:]
    <#list custom.fields![] as field>
      <#if field.input == "date">
    data["${swift.nameVariable(modelbase.get_field_name(field))}"] = "2023-01-01"
      <#elseif field.input == "text">
    data["${swift.nameVariable(modelbase.get_field_name(field))}"] = "哈啰哈啰"
      <#elseif field.input == "select">
    data["${swift.nameVariable(modelbase.get_field_name(field))}"] = "A"
      <#elseif field.input == "radio">
    data["${swift.nameVariable(modelbase.get_field_name(field))}"] = "B"
      <#elseif field.input == "bool">
    data["${swift.nameVariable(modelbase.get_field_name(field))}"] = true
      </#if>
    </#list>
    success(data)
  }
  </#if>
</#list>
}
