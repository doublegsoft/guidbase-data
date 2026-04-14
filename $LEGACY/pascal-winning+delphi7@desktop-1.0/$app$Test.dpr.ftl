program ${pascal.nameType(app.name)}Test;

uses
  Forms,
  UPage${pascal.nameType(app.name)} in 'test\UPage${pascal.nameType(app.name)}.pas';

{$R res\${pascal.nameType(app.name)}.RES}

begin
  Application.Initialize;
  Application.CreateForm(TPage${pascal.nameType(app.name)}, Page${pascal.nameType(app.name)});
  Application.Run;
end.