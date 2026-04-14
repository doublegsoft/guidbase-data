<#import "/$/guidbase.ftl" as guidbase>
<#-- 计算排列坐标 -->
<#assign children = delphi7.layout(page)>
object ${naming.nameType(id)}: T${naming.nameType(id)}
  Left = 0
  Top = 0
  Width = ${page.width}
  Height = ${page.height}
  BorderStyle = bsSingle
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = ${delphi7.ansi(title)}
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  OnCreate = FormCreate
<#list children as child>
${plugin.render(child, 2, 'dfm')}
</#list>
end
