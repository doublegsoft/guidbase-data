<#import "/$/guidbase.ftl" as guidbase>
object ${naming.nameType(id)}: TButton
  Left = ${left}
  Top = ${top}
  Width = 75
  Height = 24
  Cursor = crHandPoint
  Caption = ${delphi7.ansi(title)}
  TabOrder = ${guidbase.get_tab_order(id, pageOwner)}
end