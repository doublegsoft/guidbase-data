<#import "/$/guidbase.ftl" as guidbase>
unit U${naming.nameType(app.name)};

interface

uses
  Windows, Dialogs, Messages, SysUtils, Classes, Controls, OleAuto, OleCtrls,
  IniFiles, Variants, ShellApi, IdCoder, IdCoder3to4, IdCoderMIME,
<#list app.usecases as usecase>
  U${pascal.nameType(usecase.page.id)}<#if usecase?index == app.usecases?size - 1>; <#else>, </#if>
</#list>
<#list app.usecases as usecase>

  {*!
  ** Open the ${usecase.page.id} dialog implemented by this plugin.
  **
  ** @param Param
  **        the parameter passing from main frame
  *}
  procedure Open${pascal.nameType(usecase.page.id)}(Param: PChar); stdcall;
</#list>

implementation

<#list app.usecases as usecase>

{*!
** Open the ${usecase.page.id} dialog implemented by this plugin.
**
** @param Param
**        the parameter passing from main frame
*}
procedure Open${pascal.nameType(usecase.page.id)}(Param: PChar);
var 
  ${pascal.nameType(usecase.page.id)}: T${pascal.nameType(usecase.page.id)};
begin
  ${pascal.nameType(usecase.page.id)} := T${pascal.nameType(usecase.page.id)}.Create(nil);
  ${pascal.nameType(usecase.page.id)}.Show;
end;
</#list>

end.

