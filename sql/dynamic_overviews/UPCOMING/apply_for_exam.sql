-- AT_REGISTRATION_REASON	BOC_EXAM or null	
-- SSA user (I customer type) DOES NOT HAVE active relationship with program/school record (PS customer type)
select '<div class="boc-upcoming-item">Apply for Exam<div>'
from dual
where not exists (
  SELECT 1 FROM CEN_CUST_EMP WHERE EMPLOYEE_ID = :cust_id AND FUNCTION_CD='STUDENT'
)