SELECT
  NVL2(
    ccm.cust_id,
    '<br><br><strong>2022 Cert Maintenance Fee:<br><font color="#6FBD45">PAID</font></strong><br><br><strong>2022 Cert Maintenance Fee:<br><font color="#FF8772">NOT PAID</font></strong>',
    ''
  )
FROM
  CRT_CUST_MAST ccm
  LEFT JOIN sbm_submittal ss1 on ss1.primary_cust_id = ccm.cust_id
  AND ss1.collection_id = 'AT_ANNUAL_ATTEST_1'
  LEFT JOIN sbm_submittal ss2 on ss2.primary_cust_id = ccm.cust_id
  AND ss2.collection_id = 'AT_ANNUAL_ATTEST_2'
WHERE
  AND ss1.collection_id = 'AT_ANNUAL_ATTEST_1'
  AND wkfcfglib.getcurrentstate(ss1.wkf_serno) IN ('COMPLETE')
  AND ss2.collection_id = 'AT_ANNUAL_ATTEST_2'
  AND wkfcfglib.getcurrentstate(ss2.wkf_serno) IN ('COMPLETE')
  AND ccm.cust_id = :p_cust_id
  AND ccm.cert_ty = 'ATHLETIC_TRAINER'
  AND (
    ccm.level_id = 'CERTIFIED'
    AND ccm.certified_since_dt < '1/1/2022'
    AND ccm.current_exp_date = '12/31/2023'
  )
  OR (
    ccm.level_id = 'EXPIRED_REACTIVATE'
    AND ccm.certified_since_dt < '1/1/2022'
    AND ccm.current_exp_date = '2/28/2024'
  )