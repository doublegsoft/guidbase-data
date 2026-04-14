truncate table tn_sam_fun;
truncate table tn_sam_usr;
truncate table tx_sam_usrfun;

INSERT INTO tn_sam_fun (funid, parfunid, funnm, funtyp, ico, entpt, ordpos, sta)
VALUES ('01', '0', '应用程序', 'G', '', '', 0, 'E');
<#list managedViews as managedView>

INSERT INTO tn_sam_fun (funid, parfunid, funnm, funtyp, ico, entpt, ordpos, sta)
VALUES ('01${managedView?index?string["00"]}', '01', '${managedView.managedViewName}', 'E', '<i class="nav-icon fas fa-circle" style="font-size: 6px; position: relative; top: -8px !important;"></i>',
'html/${managedView.uri}.html', 91, 'E');
</#list>

update tn_sam_fun
set ordpos = funid;

-- ------------------------------------------------------------------------------
-- 系统管理员
-- ------------------------------------------------------------------------------

insert into tn_sam_usr (usrid, usrnm, encpwd, fulnm, mob, eml, sta)
values ('1', 'admin', 'C4CA4238A0B923820DCC509A6F75849B', '管理员', '18983619807', '598807227@qq.com', 'E');

insert into tx_sam_usrfun (usrid, funid)
select '1', funid
from tn_sam_fun;
