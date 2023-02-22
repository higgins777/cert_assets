SELECT NVL2(ccm.certificate_no, '<br><br><strong>2023 Cert Maintenance Fee:<br><font color="#6FBD45">PAID</font></strong>', '')
FROM
  CRT_CUST_MAST ccm
INNER JOIN sbm_submittal ss on ss.primary_cust_id = ccm.cust_id
WHERE
  ss.primary_cust_id = :p_cust_id
  AND ss.collection_id = 'AT_ANNUAL_ATTEST_2'
  AND wkfcfglib.getcurrentstate(ss.wkf_serno) IN ('COMPLETE')
  AND ccm.cust_id = :p_cust_id
  AND ccm.cert_ty = 'ATHLETIC_TRAINER'
  AND ccm.current_exp_date <> '12/31/2025'
  AND (
    ccm.level_id = 'CERTIFIED'
    AND ccm.certified_since_dt < '1/1/2023'
    AND ccm.current_exp_date = '12/31/2023'
  )
  OR (
    ccm.level_id = 'EXPIRED_REACTIVATE'
    AND ccm.certified_since_dt < '1/1/2023'
    AND ccm.current_exp_date = '2/28/2024'
  )
  FETCH FIRST 1 ROWS ONLY