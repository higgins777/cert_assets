-- CUST_ID: 401244
select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      Schedule Exam (review to email from Scantron)
    </div>
  </div>
  <div class="col s2">
      <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
        <i class="boc-todo-info material-icons">info</i>
      </a>
  </div>
</div>'
from dual
where exists (
  SELECT 1
  FROM SBM_SUBMITTAL s
  INNER JOIN CRT_CUST_MAST m ON m.cust_id=s.primary_cust_id
  INNER JOIN CRT_CUST_PERIOD p ON p.period_serno=m.period_serno
  WHERE s.primary_cust_id = :cust_id
  AND m.cert_ty='ATHLETIC_TRAINER'
  AND p.start_dt < cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_ELIGIBILITY_CLOSED', p_attribute_cd => 'AT_ELIGIBILITY_CLOSED')
  AND s.collection_id = 'AT_EXAM_APP'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('EXAM_REGISTERED')
)