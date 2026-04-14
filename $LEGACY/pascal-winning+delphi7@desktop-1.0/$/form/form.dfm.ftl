<#import "/$/guidbase.ftl" as guidbase>
object ${pascal.nameVariable(id)}: TGroupBox
  Left = ${left}
  Top = ${top}
  Width = ${width}
  Height = ${height}
  Caption = ${delphi7.ansi(title)}
  TabOrder = ${guidbase.get_tab_order(id, pageOwner)}
<#list children as child>
${plugin.render(child, 2, 'dfm')}
</#list>
end