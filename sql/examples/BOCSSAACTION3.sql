-- Manage CE, Submit EBP App, Need more Info EBP APP
select '<a href="ssaapexmnucall?p_app_id=BETASSA&p_page_id=53015&p_clearcache=53015&p_itemnames=P53015_PROVIDER_ID&p_itemvalues=' || bocdashboardlib.get_provider(:cust_id) || '" target="_self" title="CE Program Info"><img alt="Manage my CE Programs" src="/images/My_Images/manage-my-ce-programs.svg" border="0"></a>', 1
from dual
where exists (select 'Approved Provider Needed' 
                from crt_cust_mast c
               where c.cust_id = bocdashboardlib.get_provider(:cust_id)
                and c.cert_ty = 'APPROVED_PROVIDER'
                and c.level_id in ('ACTIVE', 'ANNUAL_REPORT'))
union
select '<a href="ssaapexmnucall?p_app_id=STDSSA&p_page_id=998&p_clearcache=APP&p_itemnames=CUST_CONTEXT&p_itemvalues=EBP_CREATE" target="_self" title="Submit EBP Application"><img alt="Submit EBP --Application" src="/images/My_Images/submit-ebp-application-optional.svg" border="0"></a>', 2
from dual
where exists (select 'Approved Provider Needed' 
                from crt_cust_mast c
               where c.cust_id = bocdashboardlib.get_provider(:cust_id)
                and c.cert_ty = 'APPROVED_PROVIDER'
                and c.level_id in ('ACTIVE', 'ANNUAL_REPORT'))
union
select '<a href="sbmssamysubmittals.display_page?p_collection_id=EBP_APP" target="_self" title="Need More Information"><img alt="Need More Information" src="/images/My_Images/action-required-ebp-application.svg" border="0"></a>', 3
from dual
where exists (select 'IA in NMI' 
                from sbm_submittal s
               where s.parent_cust_id = bocdashboardlib.get_provider(:cust_id)
                and collection_id = 'EBP_APP'
                and wkfcfglib.getcurrentstate(s.wkf_serno) in ('NMI'))
order by 2