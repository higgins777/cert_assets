select '<div class="boc-upcoming-row row">
  <div class="col s10">
    <div class="boc-upcoming-action">
      Apply for Exam
    </div>
  </div>
  <div class="col s2">
      <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
        <i class="boc-upcoming-info material-icons">info</i>
      </a>
  </div>
</div>'
from dual
where not exists (
  SELECT 1 
  FROM CEN_CUST_EMP 
  WHERE EMPLOYEE_ID = :cust_id 
  AND FUNCTION_CD='STUDENT'
)