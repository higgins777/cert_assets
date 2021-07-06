select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="https://cert.bocatc.org/bocdevssa/wkfinstantiation.instantiate?p_workflow=ECC_UPDATE&p_event_id=&p_cust_id=' || :cust_id || '">Review/Update Emergency Cardiac Care</a>
    </div>
    <div class="boc-todo-date">
      Must be current and valid
    </div>
  </div>
  <div class="col s2">
      <!-- <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
        <i class="boc-todo-info material-icons">info</i>
      </a> -->
  </div>
</div>'
from dual
where exists (
  SELECT 1
  FROM SBM_SUBMITTALS s
  WHERE s.primary_cust_id = :cust_id
    AND s.collection_id = 'AT_ECC_APP'
    AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('NMI')
)