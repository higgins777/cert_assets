SELECT
  NVL2(
    ccm.certificate_no,
    '<br><br><strong>2022 Cert Maintenance Fee:<br><font color="#FF8772">OVERDUE</font></strong>',
    ''
  )
FROM
  CRT_CUST_MAST ccm
  LEFT JOIN sbm_submittal ss on ss.primary_cust_id = ccm.cust_id
WHERE
  (
    ss.primary_cust_id = :p_cust_id
    AND ss.collection_id = 'AT_ANNUAL_ATTEST_1'
    AND wkfcfglib.getcurrentstate(ss.wkf_serno) NOT IN ('COMPLETE')
    AND wkfcfglib.getcurrentstate(ss.wkf_serno) IN ('PENDING', 'CHECKOUT', 'AWAITING_PAYMENT', NULL)
    OR NOT EXISTS (
      SELECT
        1
      FROM
        SBM_SUBMITTAL ss
      WHERE
        ss.primary_cust_id = :p_cust_id
        AND ss.collection_id = 'AT_ANNUAL_ATTEST_1'
    )
  )
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