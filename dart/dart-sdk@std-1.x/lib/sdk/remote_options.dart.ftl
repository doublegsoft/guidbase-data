<#import "/$/modelbase.ftl" as modelbase>
<#if license??>
${dart.license(license)}
</#if>
import 'base.dart';
import 'remote.dart';
import '/model/dto.dart';

///
/// Extends the Remote class with options
///
extension RemoteOptions on Remote {
<#assign visited_objs = {}>
<#list app.pages as page>
  <#list page.widgets as widget>
    <#if !widget.value("data")?starts_with("enum") || widget.value("data")?contains(":")><#continue></#if>
    <#assign enumVal = typebase.enumref(widget.value("data"))>
    <#assign dataObj = model.findObjectByName(enumVal.name)>
    <#if visited_objs[dataObj.name]??><#continue></#if>
    <#if (widget.type == "select" || widget.type == "multiselect")>
      <#assign visited_objs += {dataObj.name:dataObj}>

  /// Fetches options for widget `${widget.id}`
  Future<List<Option>> fetch${dart.nameType(modelbase.get_object_plural(dataObj))}AsOptions() async {
    final uri = _buildUri('');
    final response = await _client.get(uri, headers: defaultHeaders);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final dynamic decoded = jsonDecode(response.body);
      if (decoded is List) {
        rawList = decoded;
      } else if (decoded is Map && decoded['data'] is List) {
        rawList = decoded['data'] as List;
      } else {
        return [];
      }
      return rawList.map((item) {
        final map = item as Map<String, dynamic>;
        return Option(
          text: (map['${dart.nameVariable(enumVal.text)}'] ?? '').toString(),
          value: (map['${dart.nameVariable(enumVal.code)}'] ?? '').toString(),
        );
      }).toList();
    } else {
      throw SdkException(
        'Failed to execute ',
        statusCode: response.statusCode,
        body: response.body,
      );
    }
  }
    <#elseif widget.type == "cascade">
      <#assign visited_objs += {dataObj.name:dataObj}>

  /// Fetches cascaded options for widget `${widget.id}`
  Future<List<Option>> fetch${dart.nameType(modelbase.get_object_plural(dataObj))}AsOptions() async {
    final queryParams = <String, dynamic>{};
    if (parentId != null) queryParams['parentId'] = parentId;

    final uri = _buildUri('', queryParams);
    final response = await _client.get(uri, headers: defaultHeaders);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final dynamic decoded = jsonDecode(response.body);
      if (decoded is List) {
        rawList = decoded;
      } else if (decoded is Map && decoded['data'] is List) {
        rawList = decoded['data'] as List;
      } else {
        return [];
      }
      return rawList.map((item) {
        final map = item as Map<String, dynamic>;
        return Option(
          text: (map['${dart.nameVariable(enumVal.text)}'] ?? '').toString(),
          value: (map['${dart.nameVariable(enumVal.code)}'] ?? '').toString(),
        );
      }).toList();
    } else {
      throw SdkException(
        'Failed to execute ',
        statusCode: response.statusCode,
        body: response.body,
      );
    }
  }
    </#if>
  </#list>
</#list>
}
