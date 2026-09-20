<#import "/$/guidbase.ftl" as guidbase>
<#include "vue3-default.ftl">
<#include "vue3.ftl">
<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_entry_form_layout form indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                              OFFICIAL FORM                              -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_official_form_layout form indent>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                              CRITERIA FORM                              -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_criteria_form_layout form indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_display_form_layout form indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                                EXCEL FORM                               -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_excel_form_layout form indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                               PAGED TABLE                               -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_paged_table_layout table indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                               PAGED GRID                                -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_paged_grid_layout grid indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                                TIME GRID                                -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_time_grid_layout grid indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                                GRID VIEW                                -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_grid_view_layout grid indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                                LIST VIEW                                -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_list_view_layout list indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                                   TABS                                  -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_tabs_layout tabs indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                                 SEGMENTS                                -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_segments_layout segments indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                                  BUTTONS                                -->
<!----------------------------------------------------------------------------->
<#macro print_buttons_layout buttons indent=0>
${""?left_pad(indent)}<div class="${namespace}-btns">
  <#list buttons.children as button>
${""?left_pad(indent)}  <button @click="${guidbase.name_button_method(button)}" class="${namespace}-btn ${namespace}-btn--${guidbase.get_button_variant(button)}">${button.title}</button>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  INPUT                                  -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_input_layout input indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                                   TILE                                  -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_tile_layout tile indent=0>
</#macro>  -->

<!----------------------------------------------------------------------------->
<!--                                   PAGE                                  -->
<!----------------------------------------------------------------------------->
<#--  <#macro print_container_layout widget indent>
${""?left_pad(indent)}<div class="card">
${""?left_pad(indent)}  <div class="card-body">
<@print_widget_layout widget=widget indent=indent />
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_custom_layout widget indent>
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
${""?left_pad(indent)}<button class="btn btn-sm btn-${guidbase.get_button_role(widget)}" @click="${guidbase.name_button_method(widget)}(row)">${widget.title}</button> 
    <#elseif widget.container.type == "tab">
${""?left_pad(indent)}<button class="btn-tab btn-${guidbase.get_button_role(widget)}" @click="${guidbase.name_button_method(widget)}">${widget.title}</button>   
    <#else>
${""?left_pad(indent)}<button class="btn btn-${guidbase.get_button_role(widget)}" @click="${guidbase.name_button_method(widget)}">${widget.title}</button>
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

<#macro print_divider_layout indent=0>
${""?left_pad(indent)}<div style="height:16px;"></div>
</#macro>  -->