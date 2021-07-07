select '<div class="boc-upcoming-row row">
  <div class="col s10">
    <div class="boc-upcoming-action">
      Apply for Exam (step 2 of 2)
    </div>
  </div>
  <div class="col s2">
      <!-- <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
        <i class="boc-upcoming-info material-icons">info</i>
      </a> -->
  </div>
</div>'
from dual
where exists (
  SELECT 1
  FROM SBM_SUBMITTAL s
  INNER JOIN CEN_CUST_EMP e ON s.primary_cust_id=e.employee_id
  WHERE e.employee_id = :cust_id
  AND s.collection_id = 'AT_INITIAL_APP'
  AND e.function_cd = 'STUDENT'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('PENDING','PROGRAM_CONFIRM','BOC_CONFIRM','BOC_CONFIRM_NMI', NULL)
)
