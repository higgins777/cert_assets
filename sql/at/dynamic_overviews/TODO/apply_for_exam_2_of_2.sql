select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="sbmssamysubmittals.display_page?p_collection_id=AT_INITIAL_APP&p_cust_id=' || :cust_id || '">Apply for Exam (step 2 of 2)</a>
    </div>
    <div class="boc-todo-date">October application deadline: 9/13/2021 5:00pm CT
    </div>
  </div>
  <div class="col s2">
    <!-- <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
      <i class="boc-todo-info material-icons">info</i>
    </a> -->
  </div>
</div>'
from dual
where (
  exists (
  SELECT 1
  FROM SBM_SUBMITTAL s
  WHERE s.collection_id = 'AT_INITIAL_APP'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('IN_PROCESS', 'CHECKOUT', 'AWAITING_PAYMENT')
  ) AND not exists (
    SELECT 1 FROM CRT_CUST_MAST ccm WHERE cust_id = :cust_id
  ) AND exists (
    SELECT 1 FROM CEN_CUST_EMP WHERE EMPLOYEE_ID = :cust_id  AND FUNCTION_CD='STUDENT'
  )
)
 OR EXISTS (
  SELECT 1
  FROM CRT_CUST_MAST ccm
  WHERE ccm.cust_id = :cust_id
  AND ccm.cert_ty='ATHLETIC_TRAINER'
  AND ccm.level_id = ('EXAM_ELIGIBLE_EXPIRED')
)