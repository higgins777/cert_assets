select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      Take Exam and Await Results
    </div>
    <div class="boc-todo-date">
      October exam window: 10/9-10/23
      <br>
      Results (approximate): 11/6-11/20
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
  INNER JOIN CRT_CUST_MAST m ON s.primary_cust_id = m.cust_id
  INNER JOIN CRT_CUST_PERIOD p ON s.primary_cust_id = p.cust_id
  WHERE m.cust_id = :cust_id
    AND s.collection_id = 'AT_EXAM_APP'
    AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('EXAM_REGISTERED', NULL)
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND m.level_id = 'EXAM_ELIGIBLE'
    AND m.start_dt < cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_ELIGIBILITY_CLOSED', p_attribute_cd => 'AT_ELIGIBILITY_CLOSED')