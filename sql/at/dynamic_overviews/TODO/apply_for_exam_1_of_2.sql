select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="sbmssamysubmittals.display_page?p_collection_id=AT_INITIAL_APP&p_cust_id=' || :cust_id || '">Apply for Exam (step 1 of 2)</a>
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
where not exists (
  SELECT 1
  FROM CRT_CUST_MAST ccm
  WHERE ccm.cust_id = :cust_id
)
AND EXISTS (
  SELECT 1 FROM CEN_CUST_ATTRDTL cca
  WHERE cca.cust_id=:cust_id
  AND cca.ATTRIBUTE_TY = 'AT_REGISTRATION_REASON' 
  AND cca.ATTRIBUTE_CD = 'BOC_EXAM'
) 
AND NOT EXISTS (
  SELECT 1
  FROM SBM_SUBMITTAL s
  WHERE s.primary_cust_id = :cust_id
  AND s.collection_id = 'AT_INITIAL_APP'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('IN_PROCESS', 'CHECKOUT', 'AWAITING_PAYMENT')
) 
AND EXISTS (
  SELECT 1 FROM CEN_CUST_EMP WHERE EMPLOYEE_ID = :cust_id  AND FUNCTION_CD='STUDENT'
)

-- # 406126 / BOC 393218