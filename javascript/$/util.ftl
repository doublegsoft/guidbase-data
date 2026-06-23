<#function get_button_role button>
  <#if (button.value("action")!"") == "save">
    <#return "primary">
  <#elseif (button.value("action")!"") == "search">
    <#return "primary">  
  <#elseif (button.value("action")!"") == "edit">
    <#return "primary">    
  <#elseif (button.value("action")!"") == "clear">
    <#return "warning">
  <#elseif (button.value("action")!"") == "reset">
    <#return "warning">  
  <#elseif (button.value("action")!"") == "delete">
    <#return "danger">  
  <#elseif (button.value("action")!"") == "cancel">
    <#return "default">
  <#else>
    <#return "default">
  </#if>
</#function>

<#function get_button_method_name button>
  <#local methodName = "handle">
  <#if button.ancestor("entry_form")??>
    <#local ancestor = button.ancestor("entry_form")>
  <#elseif button.ancestor("criteria_form")??>
    <#local ancestor = button.ancestor("criteria_form")>
  <#elseif button.ancestor("paged_table")??>
    <#local ancestor = button.ancestor("paged_table")>  
  <#elseif button.ancestor("paged_grid")??>
    <#local ancestor = button.ancestor("paged_grid")>    
  </#if>
  <#if methodName == "handle">
    <#if ancestor??>
      <#local methodName += js.nameType(ancestor.id)>
    <#else>
      <#local methodName += js.nameType(button.value("ref"))>
      <#local ancestor = button.page.byId(button.value("ref"))>
    </#if>
  </#if>
  <#if button.id??>
    <#local methodName += js.nameType(button.id)>
  <#else>
    <#local methodName += (js.nameType(button.value("action", "custom")))>  
  </#if>
  <#return methodName>
</#function>

<#function get_input_model_name input>
  <#if input.container.type == "criteria_form">
    <#return js.nameVariable(input.container.id) + "Crit." + js.nameVariable(input.id)>
  <#else>
    <#return js.nameVariable(input.container.id) + "Data." + js.nameVariable(input.id)>
  </#if>
</#function>

<#function is_ref_or_ancestor widget typename>
  <#if widget.ancestor(typename)??>
    <#return true>
  </#if>
  <#if widget.page.byId(widget.value("ref"))??>
    <#local ref = widget.page.byId(widget.value("ref"))>
    <#if ref.type == typename>
      <#return true>
    </#if>
  </#if>
  <#return false>
</#function>