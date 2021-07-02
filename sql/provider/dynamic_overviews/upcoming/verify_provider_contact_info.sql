select '<a href="censsacmpprofile.display_profile?p_profile_ty=PROVIDER_PROFILE&p_cust_id='  || :cust_id || '" target="_self" title="Provider Profile"><img alt="Provider Profile" src="/images/My_Images/verify-provider-contact-info.svg" border="0"></a>', 1
from dual
where not exists (select 'Recently Updated Provider Profile'
                    from dual
                   where trunc(cencustlib.get_cust_attrdtl_dvar(p_cust_id => bocdashboardlib.get_provider(:cust_id), p_attribute_ty => 'LAST_PROFILE_UPDATE', p_attribute_cd => 'LAST_PROFILE_UPDATE')) >= trunc(sysdate) - 90)
union
select '<a href="ssaapexmnucall?p_app_id=BETASSA&p_page_id=53015&p_clearcache=53015&p_itemnames=P53015_PROVIDER_ID&p_itemvalues=' || bocdashboardlib.get_provider(:cust_id) || '" target="_self" title="CE Program Info"><img alt="CE Program Info" src="/images/My_Images/verify-ce-program-info.svg" border="0"></a>', 2
from dual
where not exists (select 'Recently Updated Program Data'
                    from boc_vw_offering vw
                   where vw.provider_id = bocdashboardlib.get_provider(:cust_id)
                     and (trunc(nvl(vw.create_dt, sysdate-91)) >= trunc(sysdate - 90)
                          or trunc(nvl(vw.last_change_dt, sysdate-91)) >= trunc(sysdate - 90)))
union                     
select '<a href="arssainvpay.pay_page" target="_self" title="Pay Fee"><img alt="Renewal Fee Due" src="/images/My_Images/pay-renewal-fee.svg" border="0"></a>', 3
from dual
where exists (select 'Active Approved Provider' 
                from crt_cust_mast c
               where c.cust_id = bocdashboardlib.get_provider(:cust_id)
                and c.cert_ty = 'APPROVED_PROVIDER'
                and c.level_id in ('ACTIVE')
                and to_char(trunc(c.current_exp_date), 'MM/DD/YYYY') = '12/31/2020')
and exists (select 'Open Invoice'
                from acgiapps.ar_vw_rct_invbalance ar
               where ar.billto_cust_id = bocdashboardlib.get_provider(:cust_id)
                 and ar.product_area = 'MEM'
                 and ar.balance > 0)
union
select '<a href="sbmssamysubmittals.display_page?p_collection_id=ANNUAL_REPORT" target="_self" title="Complete Report"><img alt="Annual Report Due" src="/images/My_Images/submit-annual-report.svg" border="0"></a>', 4
from dual
where to_char(sysdate, 'YYYYMMDD') between '20200901' and '20210331'
and exists (select 'Annual Report' 
                from crt_cust_mast c
               where c.cust_id = bocdashboardlib.get_provider(:cust_id)
                and c.cert_ty = 'APPROVED_PROVIDER'
                and c.level_id in ('ANNUAL_REPORT')
                and to_char(trunc(c.current_exp_date), 'MM/DD/YYYY') = '03/31/2021')
and not exists (select 'Open Invoice'
                from acgiapps.ar_vw_rct_invbalance ar
               where ar.billto_cust_id = bocdashboardlib.get_provider(:cust_id)
                 and ar.product_area = 'MEM'
                 and ar.balance > 0)                
and NOT exists (select 'X' 
                from sbm_submittal s
               where s.parent_cust_id = bocdashboardlib.get_provider(:cust_id)
                and collection_id = 'ANNUAL_REPORT'
                and wkfcfglib.getcurrentstate(s.wkf_serno) not in ('PENDING', 'STAFF_REVIEW', 'NMI', 'NO_PROGRAMS')
                and to_char(s.create_dt, 'YYYYMMDD') between '20201015' and '20210331')
order by 2