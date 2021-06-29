-- WKF_INSTANCE has the current state
-- 401331
select 'Register for Exam'
from dual
where exists (
  SELECT *
  FROM SBM_SUBMITTAL s
  INNER JOIN CRT_CUST_MAST m ON m.cust_id=s.primary_cust_id
  INNER JOIN CRT_CUST_PERIOD p ON p.period_serno=m.period_serno
  WHERE s.primary_cust_id = :cust_id
  AND p.level_id = 'EXAM_ELIGIBLE'
  AND p.start_dt > cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_ELIGIBILITY_CLOSED', p_attribute_cd => 'AT_ELIGIBILITY_CLOSED')
  AND SYSDATE NOT BETWEEN 
    cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'EXAM_WIN_START', p_attribute_cd => 'EXAM_WIN_START') 
    AND 
    cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'EXAM_WIN_START', p_attribute_cd => 'EXAM_WIN_START')
  AND m.cert_ty='ATHLETIC_TRAINER'
  AND m.level_id='EXAM_ELIGIBLE'
  AND s.collection_id = 'AT_INITIAL_APP'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('EXAM_ELIGIBLE')
)