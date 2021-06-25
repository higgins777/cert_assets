-- BOC118600


select '<a href="www.example.com">Apply for Exam (step 1 of 2)</a>'
from dual
where exists (
  SELECT 1 FROM CEN_CUST_EMP WHERE EMPLOYEE_ID = :cust_id AND FUNCTION_CD='STUDENT'

  SELECT 1
  FROM CRT_CUST_MAST m
  INNER JOIN CEN_CUST_EMP e ON m.cust_id=e.employee_id
  WHERE m.cust_id= :cust_id
  AND m.cert_ty = 'ATHLETIC_TRAINER'
  AND m.level_id in ('EXAM_ELIGIBLE')
  AND p.start_dt <= cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_ELIGIBILITY_CLOSED', p_attribute_cd => 'AT_ELIGIBILITY_CLOSED')
)