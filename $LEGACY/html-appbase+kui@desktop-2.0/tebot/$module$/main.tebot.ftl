<#import '/$/guidbase.ftl' as guidbase>
<#assign objname = module?substring(module?index_of('/') + 1)>
goto("http://localhost:8088")

click("//button[text()='登录']")

sleep(5)

click("//a[contains(@href,'${module}/main.html')]")

sleep(5)

click("//button[text()='新建']")

sleep(5)

<#list app.pages as page>
  <#if page.module != module><#continue></#if>
  <#if page.id == 'edit'>
    <#list page.pageWidgets as widget>
      <#if widget.type?? && widget.type != 'form'><#continue></#if>
      <#list widget.widgets as childWidget>
        <#if childWidget.type?? && childWidget.type == 'input'>
          <#if childWidget.getOption('role') == 'text'>
input("//div[@id='${js.nameVariable(widget.id)}']//input[@name='${js.nameVariable(childWidget.id)}']" = "测试${js.nameVariable(childWidget.id)?upper_case}")
          <#elseif childWidget.getOption('role') == 'select'>
click("//div[@id='${js.nameVariable(widget.id)}']//select[@name='${js.nameVariable(childWidget.id)}']/../span[contains(@class,'select2')]")
click("//li[contains(@class,'select2-results__option')]")
          <#elseif childWidget.getOption('role') == 'date'>
input("//div[@id='${js.nameVariable(widget.id)}']//input[@name='${js.nameVariable(childWidget.id)}']" = "2020-05-01")
          </#if>
        </#if>
      </#list>
    </#list>
  </#if>
</#list>

click("//button[text()='保存']")
sleep(5)

click("//a[text()='确定']")
