<#import '/$/gmui.ftl' as gmui>
<form id="${js.nameVariable(id)}" class="ui form">
<#list children as child>
  <div class="field">
    <label>${child.title}</label>
${plugin.render(child, 4, 'html')}    
  </div>
</#list>
</form>