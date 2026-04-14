library ${naming.nameType(app.name)};

{*!
** Important note about DLL memory management: ShareMem must be the
** first unit in your library's USES clause AND your project's (select
** Project-View Source) USES clause if your DLL exports any procedures or
** functions that pass strings as parameters or function results. This
** applies to all strings passed to and from your DLL--even those that
** are nested in records and classes. ShareMem is the interface unit to
** the BORLNDMM.DLL shared memory manager, which must be deployed along
** with your DLL. To avoid using BORLNDMM.DLL, pass string information
** using PChar or ShortString parameters. 
*}

uses
  SysUtils,
  Classes,
  U${pascal.nameType(app.name)} in 'src\U${pascal.nameFile(app.name)}.pas',
<#list app.usecases as usecase>
  U${pascal.nameType(usecase.page.id)} in 'src\U${pascal.nameFile(usecase.page.id)}.pas'<#if usecase?index == app.usecases?size - 1>; <#else>, </#if>
</#list>

exports
<#list app.usecases as usecase>

  {*!
  ** Open the ${usecase.page.id} dialog implemented by this plugin.
  **
  ** @param Param
  **        the parameter passing from main frame
  *}
  Open${pascal.nameType(usecase.page.id)}<#if usecase?index == app.usecases?size - 1>; <#else>, </#if>
</#list>

{$R res\${pascal.nameType(app.name)}.RES}

begin
end.
