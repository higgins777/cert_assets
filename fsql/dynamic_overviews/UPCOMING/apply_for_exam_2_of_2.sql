select '<a href="www.example.com">Apply for Exam (step 1 of 2)</a>'
from dual
where exists (
  SELECT 1 FROM CEN_CUST_EMP WHERE EMPLOYEE_ID = :cust_id AND FUNCTION_CD='STUDENT'
)