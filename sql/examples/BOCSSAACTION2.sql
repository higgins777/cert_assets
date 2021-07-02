-- Need more Info, Submit App, Need More Info2 (all link to app)
select '<a href="sbmssamysubmittals.display_page?p_collection_id=ANNUAL_REPORT" target="_self" title="Need More Information"><img alt="Need More Information" src="/images/My_Images/action-required-annual-report.svg" border="0"></a>', 1
from dual
where exists (select 'AR in NMI' 
                from sbm_submittal s
               where s.parent_cust_id = bocdashboardlib.get_provider(:cust_id)
                and collection_id = 'ANNUAL_REPORT'
                and wkfcfglib.getcurrentstate(s.wkf_serno) in ('NMI'))
union
select '<a href="sbmssamysubmittals.display_page?p_collection_id=INITIAL_APP" target="_self" title="Submit Provider Application"><img alt="Submit Provider Application" src="/images/My_Images/submit-provider-application.svg" border="0"></a>', 2
from dual
where not exists (select 'Approved Provider Needed' 
                from crt_cust_mast c
               where c.cust_id = bocdashboardlib.get_provider(:cust_id)
                and c.cert_ty = 'APPROVED_PROVIDER'
                and c.level_id != 'EXPIRED')
union                
select '<a href="sbmssamysubmittals.display_page?p_collection_id=INITIAL_APP" target="_self" title="Need More Information"><img alt="Need More Information" src="/images/My_Images/action-required-provider-application.svg" border="0"></a>', 3
from dual
where exists (select 'IA in NMI' 
                from sbm_submittal s
               where s.parent_cust_id = bocdashboardlib.get_provider(:cust_id)
                and collection_id = 'INITIAL_APP'
                and wkfcfglib.getcurrentstate(s.wkf_serno) in ('NMI'))
order by 2