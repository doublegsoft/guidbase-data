<#import "/$/modelbase.ftl" as modelbase>
import Foundation

enum BusinessError : Error {

  case error(Int, String)

}

class ObjectMap : Equatable, Identifiable, Hashable {

  static func == (lhs: ObjectMap, rhs: ObjectMap) -> Bool {
    return lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  init(_ idName:String, values:[String:Any]) {
    id = values[idName] as! String;
    self.values = values
  }

  var id: String = ""

  var values: [String:Any] = [:]
}

func convert(rows: NSArray?) -> [[String:Any]] {
  var ret: [[String: Any]] = []
  if rows == nil {
    return ret
  }
  guard let count = rows?.count else {
    return ret
  }
  for index in (0..<count) {
    guard var row = rows?.object(at: index) as? [String:Any] else {
      continue
    }
    for key in row.keys {
      if row[key] is NSArray {
        row[key] = convert(rows: row[key] as? NSArray)
      }
    }
    ret.append(row)
  }
  return ret
}

extension URLSession {

  func single(at urlString: String, params: [String:Any] = [:], success: @escaping ([String:Any]) -> Void, fail: @escaping ([String:Any]) -> Void) {
    let urlBuilder = URLComponents(string: urlString)

    guard let url = urlBuilder?.url else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("1234567", forHTTPHeaderField: "apptoken")

    guard let bytes = try? JSONSerialization.data(withJSONObject: params) else {
      fail([
        "code": 500,
        "message": "序列化字符串失败",
      ])
      return
    }
    request.httpBody = bytes

    self.dataTask(with: request) { (json, response, error) in
      if let error = error {
        fail([
          "code": 406,
          "message": "\(error)",
        ])
      }

      if let json = json {
        do {
          let res = try JSONSerialization.jsonObject(with: json, options: []) as? [String:Any]
          let data = res?["data"]
          let error = res?["error"] as? [String:Any]
          if error != nil {
            fail(error!)
          } else {
            success(data as! [String:Any])
          }
        } catch let ex {
          fail([
            "code": 406,
            "message": "\(ex)",
          ])
        }
      }
    }.resume()
  }

  func many(at urlString: String, params: [String:Any] = [:], success: @escaping ([[String:Any]]) -> Void, fail: @escaping ([String:Any]) -> Void) {
    let urlBuilder = URLComponents(string: urlString)

    guard let url = urlBuilder?.url else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("1234567", forHTTPHeaderField: "apptoken")

    guard let bytes = try? JSONSerialization.data(withJSONObject: params) else {
      fail([
        "code": 500,
        "message": "序列化字符串失败",
      ])
      return
    }
    request.httpBody = bytes

    self.dataTask(with: request) { (json, response, error) in
      if let error = error {
        fail([
          "code": 406,
          "message": "\(error)",
        ])
      }

      if let json = json {
        do {
          let res = try JSONSerialization.jsonObject(with: json, options: []) as? [String:Any]
          let data = res?["data"]
          let error = res?["error"] as? [String:Any]
          if error != nil {
            fail(error!)
          } else {
            success(convert(rows: data as? NSArray))
          }
        } catch let ex {
          fail([
            "code": 406,
            "message": "\(ex)",
          ])
        }
      }
    }.resume()
  }

  func asyncSingle(at urlString: String, params: [String:Any] = [:]) async throws -> [String:Any] {
    let urlBuilder = URLComponents(string: urlString)

    let url = urlBuilder?.url
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("1234567", forHTTPHeaderField: "apptoken")

    let bytes = try? JSONSerialization.data(withJSONObject: params)
    request.httpBody = bytes!

    let (json, _) = try await self.data(for: request)

    let res = try JSONSerialization.jsonObject(with: json, options: []) as? [String:Any]
    let data = res?["data"]
    let error = res?["error"] as? [String:Any]
    if error != nil {
      throw BusinessError.error(error?["code"] as! Int, error?["message"] as! String)
    }
    return data as! [String:Any]
  }

  func asyncMany(at urlString: String, params: [String:Any] = [:]) async throws -> [[String:Any]] {
    let urlBuilder = URLComponents(string: urlString)

    let url = urlBuilder?.url
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("1234567", forHTTPHeaderField: "apptoken")

    let bytes = try? JSONSerialization.data(withJSONObject: params)
    request.httpBody = bytes!

    let (json, _) = try await self.data(for: request)

    let res = try JSONSerialization.jsonObject(with: json, options: []) as? [String:Any]
    let data = res?["data"]
    let error = res?["error"] as? [String:Any]
    if error != nil {
      throw BusinessError.error(error?["code"] as! Int, error?["message"] as! String)
    } else {
      return convert(rows: data as? NSArray)
    }
  }
}

<#assign methodAndWidgets = {}>
<#list pages![] as page>
  <#assign pageName = modelbase.url_to_page_name(page.uri)>
  <#list page.widgets as widget>
    <#assign variable = widget.variable!'todo'>
    <#if widget.widgetType == '传统列表' || widget.widgetType == 'ListView'>
      <#assign methodAndWidgets = methodAndWidgets + {('load' + swift.nameType(variable) + '4' + swift.nameType(pageName)): widget}>
    <#elseif widget.widgetType == '编辑表单' || widget.widgetType == 'FormLayout'>
      <#assign methodAndWidgets = methodAndWidgets + {('save' + swift.nameType(variable) + '4' + swift.nameType(pageName)): widget}>
      <#assign methodAndWidgets = methodAndWidgets + {('read' + swift.nameType(variable) + '4' + swift.nameType(pageName)): widget}>
    <#elseif widget.widgetType == '只读表单' || widget.widgetType == 'ReadonlyForm'>
      <#assign methodAndWidgets = methodAndWidgets + {('read' + swift.nameType(variable) + '4' + swift.nameType(pageName)): widget}>
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

  let HOST = "http://localhost:8888";
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
  <#if method?starts_with("load")>

  /**
   * 加载【${widget.variable?upper_case}】数据。
   */
  func ${method}(params: [String:Any], success: @escaping ([[String:Any]]) -> Void, fail: @escaping ([String:Any]) -> Void) {
    URLSession.shared.many(at: HOST + "/api/v3/common/script/", success: success, fail: fail)
  }

<#--  func async${swift.nameType(method)}(params: [String:Any]) async throws -> [ObjectMap] {-->
<#--    let data:[[String:Any]] = try await URLSession.shared.asyncmany(at: HOST + "/api/v3/common/script/") as! [[String:Any]]-->
<#--    var ret:[ObjectMap] = []-->
<#--    for i in (0..<data.count) {-->
<#--      let row = data[i]-->
<#--      ret.append(ObjectMap("${swift.nameVariable(widget.variable)}Id", values: row))-->
<#--    }-->
<#--    return ret-->
<#--  }-->
  <#elseif method?starts_with("read")>

  /**
   * 读取【${widget.variable?upper_case}】数据。
   */
  func ${method}(params: [String:Any], success: @escaping ([String:Any]) -> Void, fail: @escaping ([String:Any]) -> Void) {
    URLSession.shared.many(at: HOST + "/api/v3/common/script/", success: { rows in
      if (rows.count == 0) {
        success([:])
      } else {
        success(rows[0])
      }
    }, fail: fail)
  }
  <#elseif method?starts_with("save")>
    <#if widget.widgetType == "编辑表单">
      <#assign custom = widget.customForm>
    <#elseif widget.widgetType == "花式表单">
      <#assign custom = widget.customStyled>
    </#if>

  /**
   * 保存【${widget.variable?upper_case}】数据。
   */
  func ${method}(params: [String:Any], success: @escaping ([String:Any]) -> Void, fail: @escaping ([String:Any]) -> Void) {
    var payload: [String:Any] = [:]
    <#list custom.fields as field>
    payload[""] = params["${modelbase.get_field_name(field)}"]
    </#list>
    URLSession.shared.many(at: HOST + "/api/v3/common/script/", params: payload, success: { rows in
      if (rows.count == 0) {
        success([:])
      } else {
        success(rows[0])
      }
    }, fail: fail)
  }
  </#if>
</#list>
}

struct Test {
  static func main() async {
    URLSession.shared.many(at: "http://localhost:8888/api/v3/common/script/stdbiz/sam/user/find", success:  { data in
      for i in (0..<data.count) {
        let item = data[i]
        let email = item["email"] ?? ""
        print(email)
      }

    }, fail: {error in
      print(error)
    })

    do {
      print("this is async load")
      let many = try await URLSession.shared.asyncMany(at: "http://localhost:8888/api/v3/common/script/stdbiz/sam/user/find")
      for i in (0..<many.count) {
        let item = many[i]
        let email = item["email"] ?? ""
        print(email)
      }
      let single = try await URLSession.shared.asyncSingle(at: "http://localhost:8888/api/v3/common/script/stdbiz/sam/user/read", params: [
        "userId": "1"
      ])
      print(single["username"] as! String)
    } catch let err {
      print(err)
    }
  }
}

await Test.main()