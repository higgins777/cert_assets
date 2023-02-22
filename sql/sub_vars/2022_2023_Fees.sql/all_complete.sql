SELECT
  NVL2(
    ccm.cust_id,
    'All 2022-2023 CE and fee requirements have been completed',
    ''
  )
FROM
  CRT_CUST_MAST ccm
WHERE
  CERT_TY = 'ATHLETIC_TRAINER'
  AND LEVEL_ID = 'CERTIFIED'
  AND CURRENT_EXP_DATE = '12/31/2025'
  AND CERTIFIED_SINCE_DT < '1/1/2023'
  AND CUST_ID = :p_cust_id
  FETCH FIRST 1 ROWS ONLY