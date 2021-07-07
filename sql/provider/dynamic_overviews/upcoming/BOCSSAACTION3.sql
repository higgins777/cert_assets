select '<div class="boc-todo-row row">
  <div class="col s10">
  <div class="boc-todo-action">
  <a href="ssaapexmnucall?p_app_id=BETASSA&p_page_id=53015&p_clearcache=53015&p_itemnames=P53015_PROVIDER_ID&p_itemvalues=' || bocdashboardlib.get_provider(:cust_id) || '">
    Manage My CE Programs
  </a>
  </div>
  <div class="boc-todo-date">
  </div>
  </div>
  <div class="col s2">
  <!-- <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
  <i class="boc-todo-info material-icons">info</i>
  </a> -->
  </div>
</div>', 1
from dual
where exists (select 'Approved Provider Needed' 
                from crt_cust_mast c
               where c.cust_id = bocdashboardlib.get_provider(:cust_id)
                and c.cert_ty = 'APPROVED_PROVIDER'
                and c.level_id in ('ACTIVE', 'ANNUAL_REPORT'))
union
select '<div class="boc-todo-row row">
  <div class="col s10">
  <div class="boc-todo-action">
  <a href="ssaapexmnucall?p_app_id=STDSSA&p_page_id=998&p_clearcache=APP&p_itemnames=CUST_CONTEXT&p_itemvalues=EBP_CREATE">
    Submit EBP Application (optional)
  </a>
  </div>
  <div class="boc-todo-date">
  </div>
  </div>
  <div class="col s2">
  <!-- <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
  <i class="boc-todo-info material-icons">info</i>
  </a> -->
  </div>
</div>', 2
from dual
where exists (select 'Approved Provider Needed' 
                from crt_cust_mast c
               where c.cust_id = bocdashboardlib.get_provider(:cust_id)
                and c.cert_ty = 'APPROVED_PROVIDER'
                and c.level_id in ('ACTIVE', 'ANNUAL_REPORT'))
union
select 
'<div class="boc-todo-row row">
  <div class="col s10">
  <div class="boc-todo-action">
  <a href="sbmssamysubmittals.display_page?p_collection_id=EBP_APP">
    Action Required: Annual Report
  </a>
  </div>
  <div class="boc-todo-date">
  </div>
  </div>
  <div class="col s2">
  <!-- <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
  <i class="boc-todo-info material-icons">info</i>
  </a> -->
  </div>
</div>', 3
from dual
where exists (select 'IA in NMI' 
                from sbm_submittal s
               where s.parent_cust_id = bocdashboardlib.get_provider(:cust_id)
                and collection_id = 'EBP_APP'
                and wkfcfglib.getcurrentstate(s.wkf_serno) in ('NMI'))
order by 2