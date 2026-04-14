<#import "/$/guidbase.ftl" as guidbase>
object Label${naming.nameType(id)}: TLabel
  Left = ${left}
  Top = ${top + 2}
  Width = 80
  Height = 14
  Caption = ${delphi7.ansi(title)}#65306
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  ParentFont = False
end
object ${naming.nameVariable(id)}: TEdit
  Left = ${(left + 80)?string["0"]}
  Top = ${top}
  Width = ${(width - 80)?string["0"]}
  Height = ${height}
  Enabled = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #23435#20307
  Font.Style = []
  ParentFont = False
  TabOrder = ${guidbase.get_tab_order(id, pageOwner)}
end