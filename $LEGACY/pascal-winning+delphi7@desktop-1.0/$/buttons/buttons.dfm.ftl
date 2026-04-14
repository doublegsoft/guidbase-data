<#import "/$/guidbase.ftl" as guidbase>
<#list children as child>
${plugin.render(child, 2, 'dfm')}
</#list>