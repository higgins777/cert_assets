select '<div class="boc-todo-row row">
  <div class="col s10">
  <div class="boc-todo-action">
  <a href="sbmssamysubmittals.display_page?p_collection_id=ANNUAL_REPORT">
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
</div>', 1
from dual
where exists (select 'AR in NMI' 
  from sbm_submittal s
   where s.parent_cust_id = bocdashboardlib.get_provider(:cust_id)
  and collection_id = 'ANNUAL_REPORT'
  and wkfcfglib.getcurrentstate(s.wkf_serno) in ('NMI'))
union
select '<div class="boc-todo-row row">
  <div class="col s10">
  <div class="boc-todo-action">
  <a href="sbmssamysubmittals.display_page?p_collection_id=INITIAL_APP">
  Submit Provider Application
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
where not exists (select 'Approved Provider Needed' 
  from crt_cust_mast c
   where c.cust_id = bocdashboardlib.get_provider(:cust_id)
  and c.cert_ty = 'APPROVED_PROVIDER'
  and c.level_id != 'EXPIRED')
union  
select '<div class="boc-todo-row row">
  <div class="col s10">
  <div class="boc-todo-action">
  <a href="sbmssamysubmittals.display_page?p_collection_id=INITIAL_APP">
  Submit Provider Application
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
  and collection_id = 'INITIAL_APP'
  and wkfcfglib.getcurrentstate(s.wkf_serno) in ('NMI'))
order by 2