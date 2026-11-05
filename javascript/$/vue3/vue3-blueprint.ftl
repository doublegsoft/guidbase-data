<#include "vue3-bnrlike.ftl">
<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_entry_form_layout form indent=0>
  <#local cols = form.value("cols","3")>
  <#local groups = form.groups()>
${""?left_pad(indent)}<div id="entry${js.nameType(form.id)}"<#if guidbase.has_child_widget(form.page, "buttons") && guidbase.is_last_widget(form)> style="padding-bottom:50px;"</#if>>
  <#list groups as group>
    <#local rows = form.rows(group, cols?number)>
    <#if group?index != 0>
${""?left_pad(indent)}  <div class="${namespace}-divider"></div>    
    </#if>
${""?left_pad(indent)}  <div class="${namespace}-panel">
${""?left_pad(indent)}    <div class="${namespace}-panel-head">${group}</div>
${""?left_pad(indent)}    <div class="${namespace}-form ${namespace}-form--${cols}">
    <#list rows as row>
      <#list row as child>
        <#local cType = (child.type!child.value("type")!child.value("widget")!"")?lower_case>
        <#local isTopAlign = ["avatar", "videos", "images", "longtext", "files"]?seq_contains(cType)>
${""?left_pad(indent)}      <div class="${namespace}-field<#if child.value("span")??> ${namespace}-field--span${child.value("span")}</#if><#if isTopAlign> ${namespace}-field--top</#if>">
${""?left_pad(indent)}        <label class="${namespace}-field-label<#if (child.value("required")!"") == "true"> ${namespace}-field-label--required</#if><#if isTopAlign> ${namespace}-field-label--top</#if>">${child.title}</label>
        <#if cType == "switch">
          <#local checked = (child.value("checked")!"") == "true" || (child.value("value")!"") == "1">
          <#local codeBadge = child.value("badge", "")>
          <#local descText = child.value("text", child.value("desc", ""))>
${""?left_pad(indent)}        <label class="${namespace}-switch-wrap">
${""?left_pad(indent)}          <input type="checkbox" class="${namespace}-switch-input" name="${child.name!child.id}"<#if checked> checked</#if><#if (child.value("disabled")!"") == "true"> disabled</#if>>
${""?left_pad(indent)}          <span class="${namespace}-switch-track"></span>
          <#if codeBadge?has_content || descText?has_content>
${""?left_pad(indent)}          <span class="${namespace}-switch-label">
            <#if codeBadge?has_content>
${""?left_pad(indent)}            <span class="${namespace}-switch-badge">${codeBadge}</span>
            </#if>
            <#if descText?has_content>
${""?left_pad(indent)}            ${descText}
            </#if>
${""?left_pad(indent)}          </span>
          </#if>
${""?left_pad(indent)}        </label>
        <#else>
<@print_widget_layout widget=child indent=indent+8 />
        </#if>
${""?left_pad(indent)}      </div>
      </#list>
    </#list>
${""?left_pad(indent)}    </div>    
${""?left_pad(indent)}  </div>  
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              CRITERIA FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_criteria_form_layout form indent=0>
  <#local cols = form.value("cols","3")>
  <#local groups = form.groups()>
${""?left_pad(indent)}<div id="criteria${js.nameType(form.id)}">
  <#list groups as group>
    <#local rows = form.rows(group, cols?number)>
${""?left_pad(indent)}  <div class="${namespace}-panel">
${""?left_pad(indent)}    <div class="${namespace}-form ${namespace}-form--${cols}">
    <#list rows as row>
      <#list row as child>
        <#local cType = (child.type!child.value("type")!child.value("widget")!"")?lower_case>
        <#if cType == "buttons"><#continue></#if>
        <#local isTopAlign = ["avatar", "videos", "images", "longtext", "files"]?seq_contains(cType)>
${""?left_pad(indent)}      <div class="${namespace}-field<#if child.value("span")??> ${namespace}-field--span${child.value("span")}</#if><#if isTopAlign> ${namespace}-field--top</#if>">
${""?left_pad(indent)}        <label class="${namespace}-field-label<#if (child.value("required")!"") == "true"> ${namespace}-field-label--required</#if><#if isTopAlign> ${namespace}-field-label--top</#if>">${child.title}</label>
        <#if cType == "switch">
          <#local checked = (child.value("checked")!"") == "true" || (child.value("value")!"") == "1">
          <#local codeBadge = child.value("badge", "")>
          <#local descText = child.value("text", child.value("desc", ""))>
${""?left_pad(indent)}        <label class="${namespace}-switch-wrap">
${""?left_pad(indent)}          <input type="checkbox" class="${namespace}-switch-input" name="${child.name!child.id}"<#if checked> checked</#if><#if (child.value("disabled")!"") == "true"> disabled</#if>>
${""?left_pad(indent)}          <span class="${namespace}-switch-track"></span>
          <#if codeBadge?has_content || descText?has_content>
${""?left_pad(indent)}          <span class="${namespace}-switch-label">
            <#if codeBadge?has_content>
${""?left_pad(indent)}            <span class="${namespace}-switch-badge">${codeBadge}</span>
            </#if>
            <#if descText?has_content>
${""?left_pad(indent)}            ${descText}
            </#if>
${""?left_pad(indent)}          </span>
          </#if>
${""?left_pad(indent)}        </label>
        <#else>
<@print_widget_layout widget=child indent=indent+8 />
        </#if>
${""?left_pad(indent)}      </div>
      </#list>
    </#list>
${""?left_pad(indent)}    </div>    
${""?left_pad(indent)}  </div>  
  </#list>
  <#-- ★ 按钮靠右包裹层：使用设计系统中原生靠右的 ${namespace}-btns -->
  <#list form.children as widget>
    <#if widget.type != "buttons"><#continue></#if>
${""?left_pad(indent)}  <div class="${namespace}-btns" style="margin-top: 10px;">
    <#list widget.children as button>
<@print_widget_layout widget=button indent=indent+4 />
    </#list>
${""?left_pad(indent)}  </div>
  </#list>
${""?left_pad(indent)}</div>
</#macro>