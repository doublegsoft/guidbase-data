<#import "/$/guidbase.ftl" as guidbase>
<#include "tile-html.ftl">
<#include "vue3.ftl">
<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_layout_entry_form form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              OFFICIAL FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_layout_official_form form indent>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              CRITERIA FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_layout_criteria_form form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_layout_display_form form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                EXCEL FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_layout_excel_form form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               PAGED TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_layout_paged_table table indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               PAGED GRID                                -->
<!----------------------------------------------------------------------------->
<#macro print_layout_paged_grid grid indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                TIME GRID                                -->
<!----------------------------------------------------------------------------->
<#macro print_layout_time_grid grid indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                GRID VIEW                                -->
<!----------------------------------------------------------------------------->
<#macro print_layout_grid_view grid indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                LIST VIEW                                -->
<!----------------------------------------------------------------------------->
<#macro print_layout_list_view list indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   TABS                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_tabs tabs indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 SEGMENTS                                -->
<!----------------------------------------------------------------------------->
<#macro print_layout_segments segments indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  BUTTONS                                -->
<!----------------------------------------------------------------------------->
<#macro print_layout_buttons buttons indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  BUTTON                                 -->
<!----------------------------------------------------------------------------->
<#macro print_layout_button button indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  INPUT                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_input input indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   TILE                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_tile tile indent=0>
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

<#macro print_layout_divider indent=0>
${""?left_pad(indent)}<div style="height:16px;"></div>
</#macro>