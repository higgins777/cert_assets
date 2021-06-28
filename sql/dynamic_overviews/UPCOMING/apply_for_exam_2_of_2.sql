-- CUST_ID: 401244
select 'Apply for Exam (step 2 of 2)'
from dual
where exists (
  SELECT *
  FROM SBM_SUBMITTAL s
  INNER JOIN CEN_CUST_EMP e ON s.primary_cust_id=e.employee_id
  WHERE e.employee_id = :cust_id
  AND s.collection_id = 'AT_INITIAL_APP'
  AND e.function_cd = 'STUDENT'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('PENDING','PROGRAM_CONFIRM','BOC_CONFIRM','BOC_CONFIRM_NMI', NULL)
)


