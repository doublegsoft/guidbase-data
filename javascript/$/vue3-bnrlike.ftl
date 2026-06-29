<#import "/$/guidbase.ftl" as guidbase>
<#include "vue3.ftl">
<!----------------------------------------------------------------------------->
<!--                                   TABS                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_tabs tabs indent=0>
${""?left_pad(indent)}<div class="${namespace}-tabs">
${""?left_pad(indent)}  <div v-for="tab in tabs${js.nameType(tabs.id)}" :key="tab.key"
${""?left_pad(indent)}       class="${namespace}-tab"
${""?left_pad(indent)}       :class="{ '${namespace}-active': activeTab${js.nameType(tabs.id)} === tab.key }"
${""?left_pad(indent)}       @click="activeTab${js.nameType(tabs.id)} = tab.key">
${""?left_pad(indent)}    <span>{{ tab.label }}</span>
${""?left_pad(indent)}    <span v-if="tab.badge" class="${namespace}-tab-badge">{{ tab.badge }}</span>
${""?left_pad(indent)}  </div>
  <#if tabs.contains("buttons")>
    <#local buttons = tabs.byType("buttons")[0]>
${""?left_pad(indent)}  <div class="${namespace}-tabs-right" v-show="activeTab${js.nameType(tabs.id)} === '${js.nameVariable(buttons.container.id)}'">
    <#list buttons.children as button>
<@print_layout_widget widget=button indent=indent+4 />
    </#list>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}</div>
${""?left_pad(indent)}<div class="${namespace}-tabs-content" ref="${js.nameVariable(tabs.id)}Ref">
  <#list tabs.children as tab>
${""?left_pad(indent)}  <div v-show="activeTab${js.nameType(tabs.id)} === '${js.nameVariable(tab.id)}'" :style="{ height: ${js.nameType(tabs.id)}Height + 'px' }">
    <#if tab.children?size == 0>
${""?left_pad(indent)}    ${tab.title}
    <#else>
      <#list tab.children as child>
<@print_layout_widget widget=child indent=indent+4 />
      </#list>
    </#if>
${""?left_pad(indent)}  </div>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_layout_entry_form form indent=0>
  <#local cols = form.value("cols","3")>
  <#local groups = form.groups()>
${""?left_pad(indent)}<div id="entry${js.nameType(form.id)}">
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
${""?left_pad(indent)}      <div class="${namespace}-field<#if child.value("span")??> ${namespace}-field--span${child.value("span")}</#if>">
${""?left_pad(indent)}        <label class="${namespace}-field-label<#if (child.value("required")!"") == "true"> ${namespace}-field-label--required</#if>">${child.title}</label>
<@print_layout_widget widget=child indent=indent+8 />
${""?left_pad(indent)}      </div>
      </#list>
    </#list>
${""?left_pad(indent)}    </div>    
${""?left_pad(indent)}  </div>  
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              OFFICIAL FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_layout_official_form form indent>
  <#local cols = form.value("cols","3")>
  <#local groups = form.groups()>
${""?left_pad(indent)}<div class="${namespace}-of">
${""?left_pad(indent)}  <div ref="${js.nameVariable(form.id)}Ref" class="${namespace}-of__container">
${""?left_pad(indent)}    <div class="${namespace}-of__header">
${""?left_pad(indent)}      <h1>${form.title}</h1>
${""?left_pad(indent)}      <div class="${namespace}-of__meta">
${""?left_pad(indent)}        <span>机密程度：{{ confidentialLevel }}</span>
${""?left_pad(indent)}        <span>流程编号：{{ flowNo }}</span>
${""?left_pad(indent)}        <span>申请日期：{{ applyDate }}</span>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}
${""?left_pad(indent)}    <table class="${namespace}-of__table">
  <#list groups as group>
    <#local rows = form.rows(group, cols?number)>
    <#list rows as row>
${""?left_pad(indent)}      <tr>
      <#list row as child>
${""?left_pad(indent)}        <td class="${namespace}-of__label<#if child.value("required","") == "true"> ${namespace}-of__required</#if>">${child.title}</td>
${""?left_pad(indent)}        <td colspan="${child.value("span","1")?number * 2 - 1}">
          <#if child.type == "date">
${""?left_pad(indent)}          <${namespace}-datepicker data-test="${js.nameVariable(child.id)}" v-model="${js.nameVariable(form.id)}Data.${js.nameVariable(child.id)}" plain />
          <#elseif child.type == "select">
            <#if (child.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(child.id)}" :options="sdk.${js.nameVariable(child.id)}Options" :clearable="true" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />    
            <#else>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(child.id)}" :options="${js.nameVariable(child.id)}Options"  :clearable="true" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />
            </#if>
          <#elseif child.type == "multiselect">
${""?left_pad(indent)}<${namespace}-multiselect data-test="${js.nameVariable(child.id)}" :options="${js.nameVariable(child.id)}Options" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />      
          <#elseif child.type == "tags">
${""?left_pad(indent)}<${namespace}-tagsinput data-test="${js.nameVariable(child.id)}" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />      
          <#elseif child.type == "longtext">
${""?left_pad(indent)}          <textarea
${""?left_pad(indent)}            class="${namespace}-of__textarea"
${""?left_pad(indent)}            :class="{ '${namespace}-of__readonly': readonly }"
${""?left_pad(indent)}            :placeholder="${child.value("placeholder", "请填写" + child.title)}"
${""?left_pad(indent)}            :value="${js.nameVariable(form.id)}Data.${js.nameVariable(child.id)}"
${""?left_pad(indent)}            :readonly="readonly || ${child.value("readonly","false")}"
${""?left_pad(indent)}            @input=""></textarea>      
          <#else>
${""?left_pad(indent)}          <input type="text"
${""?left_pad(indent)}            class="${namespace}-of__input"
${""?left_pad(indent)}            :class="{ '${namespace}-of__readonly': readonly  || ${child.value("readonly","false")} }"
${""?left_pad(indent)}            :value="${js.nameVariable(form.id)}Data.${js.nameVariable(child.id)}"
${""?left_pad(indent)}            :readonly="readonly || ${child.value("readonly","false")}"
${""?left_pad(indent)}            @input="">              
          </#if>
${""?left_pad(indent)}        </td>
      </#list>
${""?left_pad(indent)}      </tr>
    </#list>
  </#list>
${""?left_pad(indent)}    </table>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              CRITERIA FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_layout_criteria_form form indent=0>
${""?left_pad(indent)}<div id="criteria${js.nameType(form.id)}" class="${namespace}-toolbar">
  <#list form.children as widget>
<@print_layout_widget widget=widget indent=indent+2 />
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_layout_display_form form indent=0>
  <#local cols = form.value("cols", "3")>
${""?left_pad(indent)}<div id="${js.nameVariable(form.id)}">  
  <#list form.groups() as group>
    <#if group?index != 0>
${""?left_pad(indent)}  <div class="${namespace}-divider"></div>    
    </#if>
${""?left_pad(indent)}  <div class="${namespace}-panel">
${""?left_pad(indent)}    <div class="${namespace}-panel-head">${group}</div>
    <#local rows = form.rows(group, cols?number)>
    <#list rows as row>
${""?left_pad(indent)}    <div class="${namespace}-fview ${namespace}-fview--${cols}">    
      <#list row as input>
        <#local span = input.value("span","")>
${""?left_pad(indent)}      <div class="${namespace}-fv<#if span != ""> ${namespace}-fv--span${span}</#if>">
${""?left_pad(indent)}        <div class="${namespace}-fv-label">${input.title}</div>
${""?left_pad(indent)}        <div class="${namespace}-fv-val ${namespace}-fv-val--mono">{{ ${js.nameVariable(form.id)}Data.${js.nameVariable(input.id)} }}</div>
${""?left_pad(indent)}      </div>
      </#list>
${""?left_pad(indent)}    </div>      
    </#list>
${""?left_pad(indent)}  </div>
  </#list>
${""?left_pad(indent)}</div>  
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 TIME GRID                               -->
<!----------------------------------------------------------------------------->
<#macro print_layout_week_grid grid indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                LIST VIEW                                -->
<!----------------------------------------------------------------------------->
<#macro print_layout_list_view list indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  BUTTON                                 -->
<!----------------------------------------------------------------------------->
<#macro print_layout_buttons buttons indent=0>
  <#if buttons.ancestor("tabs")??>
    <#return>
  </#if>
${""?left_pad(indent)}<div class="${namespace}-form-footer">
${""?left_pad(indent)}  <div style="margin-left: auto;">
  <#list buttons.children as child>
<@print_layout_widget widget=child indent=indent+4 />
  </#list>    
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   PAGE                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_container widget indent>
<@print_layout_widget widget=widget indent=indent />
</#macro>

<#macro print_layout_custom widget indent>
  <#if widget.type == "card">
${""?left_pad(indent)}<div class="${namespace}-panel">
${""?left_pad(indent)}  <div class="${namespace}-panel-head">${widget.title!"这里是标题"}</div>
    <#list widget.children as child>
<@print_layout_widget widget=child indent=indent+2 />
    </#list>
${""?left_pad(indent)}</div>  
  <#elseif widget.type == "button">
    <#if widget.ancestor("paged_table")??>
${""?left_pad(indent)}<button class="${namespace}-btn btn-sm ${namespace}-btn--${guidbase.get_button_variant(widget)} ${namespace}-btn-gap" @click="${guidbase.name_button_method(widget)}">${widget.title}</button>    
    <#else>
${""?left_pad(indent)}<button class="${namespace}-btn ${namespace}-btn--${guidbase.get_button_variant(widget)} ${namespace}-btn-gap" @click="${guidbase.name_button_method(widget)}">${widget.title}</button>
    </#if>
  <#elseif widget.type == "longtext">
${""?left_pad(indent)}<textarea class="${namespace}-textarea" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}          v-model="${guidbase.name_input_variable(widget)}" placeholder="${widget.value("placeholder",("请输入" + widget.title))}"></textarea>  
  <#elseif widget.type == "text">
${""?left_pad(indent)}<input class="${namespace}-input" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}       v-model="${guidbase.name_input_variable(widget)}" 
    <#if (widget.value("readonly")!"") == "true">
${""?left_pad(indent)}       :class="{ '${namespace}-input--readonly': true }" :disabled="true">
    <#else>
${""?left_pad(indent)}       placeholder="${widget.value("placeholder",("请输入" + widget.title))}">
    </#if>
    <#if widget.value("unit") != "">
${""?left_pad(indent)}<span class="${namespace}-field-unit">${widget.value("unit")}</span>
    </#if>
  <#elseif widget.type == "number">
${""?left_pad(indent)}<input class="${namespace}-input" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}       v-model="${guidbase.name_input_variable(widget)}" 
    <#if (widget.value("readonly")!"") == "true">
${""?left_pad(indent)}       :class="{ '${namespace}-input--readonly': true }" :disabled="true">
    <#else>
${""?left_pad(indent)}       placeholder="${widget.value("placeholder",("请输入" + widget.title))}">
    </#if>
    <#if widget.value("unit") != "">
${""?left_pad(indent)}<span class="${namespace}-field-unit">${widget.value("unit")}</span>
    </#if>
  </#if>
</#macro>