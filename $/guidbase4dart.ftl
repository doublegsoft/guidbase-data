<#--
 ###############################################################################
 ### 测试数据
 ###############################################################################
 -->
<#macro print_dart_declare_testdata widget indent> 
  <#if (widget.id!"unknown")?ends_with("name")>
${""?left_pad(indent)}'${js.nameVariable(widget.id!"unknown")}': '${tatabase.string(4)}', 
  <#elseif (widget.type!"unknown") == "select">
    <#if widget.options["values"]??>
${""?left_pad(indent)}'${js.nameVariable(widget.id!"unknown")}': '${tatabase.enumcode("enum" + widget.options["values"])}',
    <#else>
${""?left_pad(indent)}"${js.nameVariable(widget.id!"unknown")}': '1',     
    </#if>
  <#elseif (widget.id!"unknown") == "id_card_number">
${""?left_pad(indent)}'${js.nameVariable(widget.id!"unknown")}': '${tatabase.random("id_card_number", "")}',   
  <#elseif (widget.id!"unknown") == "avatar">
${""?left_pad(indent)}'${js.nameVariable(widget.id!"unknown")}': '',   
  <#elseif (widget.type!"unknown") == "image">
${""?left_pad(indent)}'${js.nameVariable(widget.id!"unknown")}': '',   
  <#elseif (widget.type!"unknown") == "mobile">  
${""?left_pad(indent)}'${js.nameVariable(widget.id!"unknown")}': '${tatabase.random("mobile", "")}',    
  <#elseif (widget.type!"unknown") == "email">  
${""?left_pad(indent)}'${js.nameVariable(widget.id!"unknown")}': '${tatabase.random("user", "")}@${tatabase.random("domain", "")}',     
  <#elseif (widget.type!"unknown") == "longtext">  
${""?left_pad(indent)}'${js.nameVariable(widget.id!"unknown")}': '${tatabase.value("note")}',    
  <#elseif (widget.type!"unknown") == "number">  
${""?left_pad(indent)}'${js.nameVariable(widget.id!"unknown")}': '${tatabase.number(1, 100)}',    
  <#elseif (widget.type!"unknown") == "date">  
${""?left_pad(indent)}'${js.nameVariable(widget.id!"unknown")}': '${tatabase.date()}',  
  <#elseif (widget.type!"unknown") == "datetime">  
${""?left_pad(indent)}'${js.nameVariable(widget.id!"unknown")}': '${tatabase.datetime()}',     
  <#else>
${""?left_pad(indent)}'${js.nameVariable(widget.id!"unknown")}': '${tatabase.string(8)}',
  </#if>
  <#if (widget.id!"unknown")?ends_with("_id")>
${""?left_pad(indent)}'${js.nameVariable((widget.id!"unknown")?replace("_id", "_name"))}': '${tatabase.string(4)}',
  </#if>
</#macro>