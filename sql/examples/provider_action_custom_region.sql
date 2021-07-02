"select '<td style=""width: 110px; text-align: center; vertical-align: top;""><a href=""ssaauthmain.id_passwd_update?p_application_cd=SSA&p_cust_id=' || p_cust_id || '"" target=""_self"" title=""Password Update""><img alt=""Password Update"" src=""/images/My_Images/reset-my-password.svg"" border=""0""></a></td>' display, 1
from dual
where not exists
   (select 'Password Updated'
      from cen_cust_login
     where cust_id = p_cust_id
       and application_cd = 'SSA'
       and trunc(last_passwd_change_dt) >= trunc(sysdate) - 180)
union
select '<td style=""width: 110px; text-align: center; vertical-align: top;""><a href=""censsaindprofile.display_profile?p_profile_ty=INDIVIDUAL_PROFILE&p_cust_id=' || p_cust_id || '"" target=""_self"" title=""Update Profile""><img alt=""Profile"" src=""/images/My_Images/verify-my-contact-info.svg"" border=""0""></a></td>', 2
from dual
where not exists (select 'Recently Updated'
                    from dual
                   where cencustlib.get_cust_attrdtl_dvar(p_cust_id => p_cust_id, p_attribute_ty => 'LAST_PROFILE_UPDATE', p_attribute_cd => 'LAST_PROFILE_UPDATE') >= trunc(sysdate) - 90)
union
select '<td style=""width: 110px; text-align: center; vertical-align: top;""><a href=""ssaapexmnucall?p_app_id=BOCSSA&p_page_id=2505&p_cust_id=' || p_cust_id || '"" target=""_self"" title=""Provider Link""><img alt=""Provider Link"" src=""/images/My_Images/link-myself-to-a-provider-account.svg"" border=""0""></a></td>', 3
from dual
where not exists
   (select 'Provider Link Exists'
      from dual
     where bocdashboardlib.get_provider(p_cust_id) is not null)
order by 2;"
