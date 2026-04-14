<#import "/$/guidbase.ftl" as guidbase>
object Page${naming.nameType(app.name)}: TPage${naming.nameType(app.name)}
  Left = 0
  Top = 0
  Width = 800
  Height = 600
  BorderStyle = bsSingle
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = ${delphi7.ansi(app.name + '测试程序')}
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
<#assign top = 15>
<#list app.usecases as usecase>
  <#assign page = usecase.page>
  object Button${pascal.nameType(page.id)}: TButton
    Left = 15
    Top = ${top}
    Width = 240
    Height = 24
    Cursor = crHandPoint
    Caption = ${delphi7.ansi(page.title + '测试')}
    OnClick = Button${pascal.nameType(usecase.page.id)}Click
  end
  <#assign top = top + 10 + 24>
</#list>
end
