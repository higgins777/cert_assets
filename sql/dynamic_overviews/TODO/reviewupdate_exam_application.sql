-- CUST_ID: 401244
select '<a href='https://cert.bocatc.org/bocdevssa/sbmssamysubmittals.display_page?p_collection_id=AT_INITIAL_APP&p_cust_id=' || :cust_id || ''>Apply for Exam (step 1 of 2)</a>'

from dual
where exists (
  SELECT *
  FROM SBM_SUBMITTAL s
  INNER JOIN CRT_CUST_MAST m ON m.cust_id=s.primary_cust_id
  WHERE s.primary_cust_id = :cust_id
  AND m.cert_ty='ATHLETIC_TRAINER'
  AND s.collection_id = 'AT_INITIAL_APP'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('BOC_CONFIRM_NMI', 'NMI')
)