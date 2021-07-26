select '<div class="boc-left-nav">
  <a target="_blank" href="ssaapexmnucall?p_app_id=BOCSSA&p_page_id=1000&p_clearcache=1000">
    Manage Students
  </a>
</div>'
from dual
where exists (
  SELECT 1 
  FROM CEN_CUST_EMP e
  WHERE e.EMPLOYEE_ID = :cust_id
  AND FUNCTION_CD = 'ADMIN'
)