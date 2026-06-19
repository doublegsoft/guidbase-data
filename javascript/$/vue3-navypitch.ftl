<#include "vue3.ftl">
<!----------------------------------------------------------------------------->
<!--                                   TABS                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_tabs tabs indent=0>
${""?left_pad(indent)}<div class="card">
${""?left_pad(indent)}  <div class="card-body">
${""?left_pad(indent)}    <div class="tabs">
${""?left_pad(indent)}      <div class="tabs-nav">
${""?left_pad(indent)}        <div v-for="tab in tabs${js.nameType(tabs.id)}" :key="tab.key"
${""?left_pad(indent)}             class="tab"
${""?left_pad(indent)}             :class="{ 'active': activeTab${js.nameType(tabs.id)} === tab.key }"
${""?left_pad(indent)}             @click="activeTab${js.nameType(tabs.id)} = tab.key">
${""?left_pad(indent)}          <span>{{ tab.label }}</span>
${""?left_pad(indent)}          <span v-if="tab.badge" class="${namespace}-tab-badge">{{ tab.badge }}</span>
${""?left_pad(indent)}        </div>
${""?left_pad(indent)}      </div>
  <#list tabs.children as tab>
${""?left_pad(indent)}      <div class="tabs-actions" v-show="activeTab${js.nameType(tabs.id)} === '${js.nameVariable(tab.id)}'">
    <#list tab.children as button>
      <#if button.type != "button"><#continue></#if>
<@print_layout_widget widget=button indent=indent+8 />
    </#list>
${""?left_pad(indent)}      </div>
  </#list>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="tab-panel active" ref="${js.nameVariable(tabs.id)}Ref">
  <#list tabs.children as tab>
${""?left_pad(indent)}      <div v-show="activeTab${js.nameType(tabs.id)} === '${js.nameVariable(tab.id)}'" class="tab-content">
    <#if tab.children?size == 0>
${""?left_pad(indent)}    ${tab.title}
    <#else>
      <#list tab.children as child>
        <#if child.type == "button"><#continue></#if>
<@print_layout_widget widget=child indent=indent+8 />
      </#list>
    </#if>
${""?left_pad(indent)}      </div>
  </#list>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_layout_entry_form form indent=0>
  <#local cols = form.value("cols","2")>
  <#local groups = form.groups()>
${""?left_pad(indent)}<div class="card">  
${""?left_pad(indent)}  <div id="entry${js.nameType(form.id)}" class="card-body">
  <#list groups as group>
    <#local rows = form.rows(group, cols?number)>
${""?left_pad(indent)}    <div class="form-row form-row-${cols}">
    <#list rows as row>
      <#list row as child>
        <#local span = child.value("span","1")>
${""?left_pad(indent)}      <div class="form-group form-col-span-${span}">
${""?left_pad(indent)}        <label class="form-label">${child.title}
${""?left_pad(indent)}          <span style="color: var(--color-red);">*</span>
${""?left_pad(indent)}        </label>
<@print_layout_widget widget=child indent=indent+8 />
${""?left_pad(indent)}      </div>
      </#list>
    </#list>
${""?left_pad(indent)}    </div>  
  </#list>
${""?left_pad(indent)}    <div class="card-actions">
  <#list form.children as child>
    <#if child.type != "button"><#continue></#if>
${""?left_pad(indent)}    ${""?left_pad(indent)}<button class="btn btn-${get_button_role(child)}" @click="${get_button_method_name(child)}">${child.title}</button> 
  </#list>
${""?left_pad(indent)}    </div>   
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              OFFICIAL FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_layout_official_form form indent>
  <#local cols = form.value("cols")!"3">
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
${""?left_pad(indent)}            class="form-input"
${""?left_pad(indent)}            :class="{ '${namespace}-of__readonly': readonly }"
${""?left_pad(indent)}            :placeholder="${child.value("placeholder", "请填写" + child.title)}"
${""?left_pad(indent)}            :value="${js.nameVariable(form.id)}Data.${js.nameVariable(child.id)}"
${""?left_pad(indent)}            :readonly="readonly || ${child.value("readonly","false")}"
${""?left_pad(indent)}            @input=""></textarea>      
          <#else>
${""?left_pad(indent)}          <input type="text"
${""?left_pad(indent)}            class="form-input"
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
  <#local cols = form.value("cols","3")>
${""?left_pad(indent)}<div id="criteria${js.nameType(form.id)}" class="form-row form-row-${cols}">
  <#list form.children as widget>
    <#if widget.type == "button">
      <#continue>
    </#if>
<@print_layout_widget widget=widget indent=indent+2 />
  </#list>
${""?left_pad(indent)}</div>
${""?left_pad(indent)}<div class="btn-group">
  <#list form.children as widget>
    <#if widget.type != "button">
      <#continue>
    </#if>
<@print_layout_widget widget=widget indent=indent+2 />
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_layout_display_form form indent=0>
  <#local cols = form.value("cols", "3")>
  <#list form.groups() as group>
${""?left_pad(indent)}<div class="card">
${""?left_pad(indent)}  <div class="card-header">
${""?left_pad(indent)}    <div class="card-title"><#if group == "">${form.title}<#else>${group}</#if></div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="card-body">
    <#local rows = form.rows(group, cols?number)>
    <#list rows as row>
${""?left_pad(indent)}    <div class="df-grid df-grid--${cols}">    
      <#list row as input>
        <#local span = input.value("span","1")>
${""?left_pad(indent)}      <div class="df-field--span-${span}">
${""?left_pad(indent)}        <div class="df-label">${input.title}</div>
${""?left_pad(indent)}        <div class="df-value">{{ ${js.nameVariable(form.id)}Data.${js.nameVariable(input.id)} }}</div>
${""?left_pad(indent)}      </div>
      </#list>
${""?left_pad(indent)}    </div>
    </#list>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 TIME GRID                               -->
<!----------------------------------------------------------------------------->
<#macro print_layout_week_grid grid indent=0>
${""?left_pad(indent)}<${namespace}-weekgrid
${""?left_pad(indent)}  v-model="calendarDate"
${""?left_pad(indent)}  :events="${js.nameVariable(grid.id)}Rows"
${""?left_pad(indent)}  :start-hour="0"
${""?left_pad(indent)}  :end-hour="23"
${""?left_pad(indent)}  :first-day-of-week="1"
${""?left_pad(indent)}  @event-click="handle${js.nameType(grid.id)}EventClick"
${""?left_pad(indent)}  @slot-click="handle${js.nameType(grid.id)}SlotClick"
${""?left_pad(indent)}/>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                LIST VIEW                                -->
<!----------------------------------------------------------------------------->
<#macro print_layout_list_view list indent=0>
${""?left_pad(indent)}<div class="card">
${""?left_pad(indent)}  <div class="card-header">
${""?left_pad(indent)}    <div class="card-title">${list.title}</div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="card-body">
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  BUTTON                                 -->
<!----------------------------------------------------------------------------->
<#macro print_layout_buttons buttons indent=0>
  <#if buttons.ancestor("tabs")??>
    <#return>
  </#if>
${""?left_pad(indent)}<div class="form-footer form-footer--right">
  <#list buttons.children as child>
<@print_layout_widget widget=child indent=indent+4 />
  </#list>    
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   PAGE                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_container widget indent>
${""?left_pad(indent)}<div class="card">
${""?left_pad(indent)}  <div class="card-body">
<@print_layout_widget widget=widget indent=indent />
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_layout_custom widget indent>
  <#if widget.type == "card">
${""?left_pad(indent)}<div class="card">
${""?left_pad(indent)}  <div class="card-header">
${""?left_pad(indent)}    <div>
${""?left_pad(indent)}      <div class="card-title">${widget.title}</div>
${""?left_pad(indent)}      <div class="card-sub"></div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="card-body">
  <#list widget.children as child>
<@print_layout_widget widget=child indent=indent+2 />
  </#list>
${""?left_pad(indent)}  </div>  
${""?left_pad(indent)}</div>  
  <#elseif widget.type == "button">    
    <#if widget.ancestor("paged_table")??>
${""?left_pad(indent)}<button class="btn btn-sm btn-${get_button_role(widget)}" @click="${get_button_method_name(widget)}(row)">${widget.title}</button> 
    <#elseif widget.container.type == "tab">
${""?left_pad(indent)}<button class="btn-tab btn-${get_button_role(widget)}" @click="${get_button_method_name(widget)}">${widget.title}</button>   
    <#else>
${""?left_pad(indent)}<button class="btn btn-${get_button_role(widget)}" @click="${get_button_method_name(widget)}">${widget.title}</button>
    </#if>
  <#elseif widget.type == "longtext">
${""?left_pad(indent)}<textarea class="form-input resize-v" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}          v-model="${get_input_model_name(widget)}" placeholder="${widget.value("placeholder",("请输入" + widget.title))}"></textarea>  
  <#elseif widget.type == "text">
${""?left_pad(indent)}<div class="input-with-unit">
${""?left_pad(indent)}  <input class="form-input" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}         v-model="${get_input_model_name(widget)}" 
    <#if (widget.value("readonly")!"") == "true">
${""?left_pad(indent)}         :disabled="true">
    <#else>
${""?left_pad(indent)}         placeholder="${widget.value("placeholder",("请输入" + widget.title))}">
    </#if>
    <#if widget.value("unit") != "">
${""?left_pad(indent)}  <span class="input-unit-label">${widget.value("unit")}</span>
    </#if>
${""?left_pad(indent)}</div>    
  <#elseif widget.type == "number">
${""?left_pad(indent)}<div class="input-with-unit">  
${""?left_pad(indent)}  <input class="form-input" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}         v-model="${get_input_model_name(widget)}" 
    <#if (widget.value("readonly")!"") == "true">
${""?left_pad(indent)}         :disabled="true">
    <#else>
${""?left_pad(indent)}         placeholder="${widget.value("placeholder",("请输入" + widget.title))}">
    </#if>
    <#if widget.value("unit") != "">
${""?left_pad(indent)}  <span class="input-unit-label">${widget.value("unit")}</span>
    </#if>
${""?left_pad(indent)}</div>
  </#if>
</#macro>

<#macro print_layout_divider indent=0>
${""?left_pad(indent)}<div style="height:16px;"></div>
</#macro>