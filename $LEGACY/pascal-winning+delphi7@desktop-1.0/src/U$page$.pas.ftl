<#import "/$/guidbase.ftl" as guidbase>
unit U${naming.nameType(page.id)};

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ComCtrls, OleCtrls, SHDocVw, OleAuto, ExtCtrls,
  Provider, DB, ADODB, StdCtrls, Grids, DBGrids, DBClient, printers;

type
  T${naming.nameType(page.id)} = class(TForm)
<#list page.pageWidgets as widget>
  <#assign widgetType = guidbase.type_widget(widget, 'delphi')!>
  <#if widgetType == ''><#continue></#if>
  <#if widgetType == 'TEdit'>
    Label${naming.nameType(widget.id)}: TLabel;
  </#if>
    ${naming.nameType(widget.id)}: ${widgetType};
</#list>

  procedure FormCreate(Sender: TObject);

  private
    
  public
    
  end;

var
  ${naming.nameType(page.id)}: T${naming.nameType(page.id)};

implementation

{$R *.dfm}

procedure T${naming.nameType(page.id)}.FormCreate(Sender: TObject);
begin
  Left := (Screen.Width - Width) div 2;
  Top := (Screen.Height - Height) div 2;
end;


end.