-- 401331
select 'Register for Exam'
from dual
where exists (
  SELECT *
  FROM SBM_SUBMITTAL s
  INNER JOIN CRT_CUST_MAST m ON m.cust_id=s.primary_cust_id
  LEFT JOIN CEN_CUST_ATTRDTL boc_attr ON boc_attr.cust_id='BOCATC'
  WHERE s.primary_cust_id = :cust_id
  AND boc_attr.attribute_ty='EXAM_WIN_START'
  AND boc_attr.attribute_cd='EXAM_WIN_START'
  AND dvar part of the query
  AND m.cert_ty='ATHLETIC_TRAINER'
  AND m.level_id='EXAM_ELIGIBLE'
  AND s.collection_id = 'AT_INITIAL_APP'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('EXAM_ELIGIBLE')
)

SELECT cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'EXAM_WIN_START', p_attribute_cd => 'EXAM_WIN_START') FROM dual

-- SELECT wkfcfglib.getcurrentstate('2539') FROM dual
-- BOCATC	EXAM_WIN_START	EXAM_WIN_START	-	-	07/06/2021	03/31/2021	ACGIADMIN	03/31/2021	ACGIADMIN	-

-- cencustlib.get_cust_attrdtl_dvar(p_cust_id => :cust_id, p_attribute_ty => 'LAST_PROFILE_UPDATE', p_attribute_cd => 'LAST_PROFILE_UPDATE') >= trunc(sysdate) - 90)
