select '
<a href="sbmssamysubmittals.display_page?p_collection_id=AT_INITIAL_APP&p_cust_id=' || :cust_id || '"><div class="boc-todo-row row">
<div class="col s10">
<div class="boc-todo-action">
Apply for Exam (step 2 of 2)
</div>
<div class="boc-todo-date">May/June application deadline: 4/25/2022 5:00pm CT
</div>
</div>
<div class="col s2">
<!-- <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
<i class="boc-todo-info material-icons">info</i>
</a> -->
</div>
</div>
</a>'
from dual
where (
exists (
SELECT 1
FROM SBM_SUBMITTAL s
WHERE s.collection_id = 'AT_INITIAL_APP'
AND s.primary_cust_id = :cust_id
AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('IN_PROCESS', 'CHECKOUT', 'AWAITING_PAYMENT')
) AND not exists (
SELECT 1 FROM CRT_CUST_MAST ccm WHERE cust_id = :cust_id
) AND exists (
SELECT 1 FROM CEN_CUST_EMP WHERE EMPLOYEE_ID = :cust_id AND FUNCTION_CD='STUDENT' AND EMPLOYER_ID <> 'INTERN'
)
)
OR EXISTS (
SELECT 1
FROM CRT_CUST_MAST ccm
WHERE ccm.cust_id = :cust_id
AND ccm.cert_ty='ATHLETIC_TRAINER'
AND ccm.level_id = ('EXAM_ELIGIBLE_EXPIRED')
AND not exists (
SELECT 1 FROM CEN_CUST_EMP WHERE EMPLOYEE_ID = :cust_id AND FUNCTION_CD='STUDENT' AND EMPLOYER_ID='INTERN'
)
)