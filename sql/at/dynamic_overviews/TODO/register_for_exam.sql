-- WKF_INSTANCE has the current state
-- 401331
select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="https://cert.bocatc.org/bocdevssa/sbmssamysubmittals.display_page?p_collection_id=AT_INITIAL_EXAM&p_cust_id=' || :cust_id || '">Register for Exam</a>
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
  AND p.level_id = 'EXAM_ELIGIBLE'
  AND p.start_dt > cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_ELIGIBILITY_CLOSED', p_attribute_cd => 'AT_ELIGIBILITY_CLOSED')
  AND SYSDATE NOT BETWEEN
      cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'EXAM_WIN_START', p_attribute_cd => 'EXAM_WIN_START')
      AND 
      cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'EXAM_WIN_START', p_attribute_cd => 'EXAM_WIN_START')
  AND m.cert_ty='ATHLETIC_TRAINER'
  AND m.level_id='EXAM_ELIGIBLE'
  AND s.collection_id = 'AT_EXAM_APP'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('PENDING', 'CHECKOUT', 'AWAITING_PAYMENT', 'REGISTRATION_STAFF_REVIEW', NULL)
)