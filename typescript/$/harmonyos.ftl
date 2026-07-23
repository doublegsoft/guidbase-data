<!----------------------------------------------------------------------------->
<!--                                 WIDGET                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_widget widget indent=0>
  <#if widget.type == "scroll_navigator">
    <@print_layout_scroll_navigator navigator=widget indent=indent />
  <#elseif widget.type == "slide_navigator">
    <@print_layout_slide_navigator navigator=widget indent=indent />
  <#elseif widget.type == "button_navigator">
    <@print_layout_button_navigator navigator=widget indent=indent />
  <#elseif widget.type == "list_navigator">
    <@print_layout_list_navigator navigator=widget indent=indent />
  <#elseif widget.type == "list_view">
    <@print_layout_list_view list=widget indent=indent />
  <#elseif widget.type == "grid_view">
    <@print_layout_grid_view grid=widget indent=indent />
  <#elseif widget.type == "entry_form">
    <@print_layout_entry_form form=widget indent=indent />
  <#elseif widget.type == "criteria_form">
    <@print_layout_criteria_form form=widget indent=indent />
  <#elseif widget.type == "display_form">
    <@print_layout_display_form form=widget indent=indent />
  <#elseif widget.type == "tabs">
    <@print_layout_tabs tabs=widget indent=indent />
  <#elseif widget.type == "segments">
    <@print_layout_segments segments=widget indent=indent />
  <#elseif widget.type == "tile">
    <@print_layout_tile tile=widget indent=indent />
  <#elseif widget.type == "button">
    <@print_layout_button button=widget indent=indent />
  <#elseif widget.type == "input">
    <@print_layout_input input=widget indent=indent />
  </#if>
</#macro>