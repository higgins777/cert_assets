/* EXAM_ELIGIBLE with effective date prior to AT_ELIGIBILITY_CLOSED (date on BOCATC NA record) */
/* When their current status == EXAM_ELIGIBLE AND current_status.effective date <= the date that we set on the global BOCATC NA record */
-- 4/26/21
select '<h1>Schedule Exam</h1>'
from dual
where exists (
  SELECT 1
  FROM CRT_CUST_MAST m
  INNER JOIN CRT_CUST_PERIOD p ON m.cust_id=p.cust_id
  WHERE m.cust_id='BOC391820'
  AND m.cert_ty = 'ATHLETIC_TRAINER'
  AND m.level_id in ('EXAM_ELIGIBLE')
  AND p.start_dt <=  (
    trunc()
  )
)


SELECT  FROM dual
-- Next test usage of select value in condition

SELECT cencustlib.get_cust_attrdtl_dvar(p_cust_id = > 'BOCATC', p_attribute_ty = > 'AT_ELIGIBILITY_CLOSED',p_attribute_cd = > 'AT_ELIGIBILITY_CLOSED') FROM CRT_CUST_MAST


select 'WAZZZZZUP'
from dual
where exists (
  SELECT 1
  FROM CRT_CUST_MAST m
  INNER JOIN CRT_CUST_PERIOD p ON m.cust_id=p.cust_id
  WHERE m.cust_id='BOC391820'
  AND m.cert_ty = 'ATHLETIC_TRAINER'
  AND m.level_id in ('EXAM_ELIGIBLE')
)
/* SQL COMMANDS TEST

SELECT m.cust_id, p.start_dt
FROM CRT_CUST_MAST m
INNER JOIN CRT_CUST_PERIOD p ON m.cust_id=p.cust_id
WHERE m.cust_id='BOC391820'
AND m.cert_ty = 'ATHLETIC_TRAINER'
AND m.level_id in ('EXAM_ELIGIBLE')
AND p.start_dt <= '04/27/2021'

*/