-- CUST_ID: 401244
select '<a href="https://cert.bocatc.org/bocdevssa/sbmssamysubmittals.display_page?p_collection_id=AT_INITIAL_APP&p_cust_id=' || :cust_id || '">Apply for Exam (step 1 of 2)</a>'
from dual
where exists (
  SELECT 1
  FROM SBM_SUBMITTAL s
  INNER JOIN CRT_CUST_MAST m ON m.cust_id=s.primary_cust_id
  INNER JOIN CRT_CUST_PERIOD p ON p.period_serno=m.period_serno
  WHERE s.primary_cust_id = :cust_id
  AND m.cert_ty='ATHLETIC_TRAINER'
  AND p.start_dt < cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_ELIGIBILITY_CLOSED', p_attribute_cd => 'AT_ELIGIBILITY_CLOSED')
  AND s.collection_id = 'AT_EXAM_APP'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('NMI')
)