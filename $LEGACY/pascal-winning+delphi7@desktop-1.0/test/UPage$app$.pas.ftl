<#import "/$/guidbase.ftl" as guidbase>
unit UPage${naming.nameType(app.name)};

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ComCtrls, OleCtrls, SHDocVw, OleAuto, ExtCtrls,
  Provider, DB, ADODB, StdCtrls, Grids, DBGrids, DBClient, printers;

type
  TPage${naming.nameType(app.name)} = class(TForm)
<#list app.usecases as usecase>
  <#assign page = usecase.page>
    Button${pascal.nameType(page.id)}: TButton;
</#list>

    procedure FormCreate(Sender: TObject);
<#list app.usecases as usecase>
    procedure Button${pascal.nameType(usecase.page.id)}Click(Sender: TObject);
</#list>

  private
    
  public
    
  end;

var
  Page${naming.nameType(app.name)}: TPage${naming.nameType(app.name)};
<#list app.usecases as usecase>

  Open${pascal.nameType(usecase.page.id)}: procedure (Param: PChar); stdcall;
</#list>

implementation

{$R *.dfm}

procedure TPage${naming.nameType(app.name)}.FormCreate(Sender: TObject);
begin
  Left := (Screen.Width - Width) div 2;
  Top := (Screen.Height - Height) div 2;
end;
<#list app.usecases as usecase>

procedure TPage${pascal.nameType(app.name)}.Button${pascal.nameType(usecase.page.id)}Click(Sender: TObject);
var
  DllHandle: THandle;
begin
  DllHandle := LoadLibrary('${pascal.nameFile(app.name)}.dll');
  @Open${pascal.nameType(usecase.page.id)} := GetProcAddress(DllHandle, 'Open${pascal.nameType(usecase.page.id)}');
  Open${pascal.nameType(usecase.page.id)}(nil);
  // FreeLibrary(DllHandle);
end;
</#list>

end.