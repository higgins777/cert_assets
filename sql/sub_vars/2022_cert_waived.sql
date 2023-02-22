SELECT
  NVL2(
    ccm.certificate_no,
    '<br><br><strong>2022 Cert Maintenance Fee:<br><font color="#6FBD45">WAIVED</font></strong>',
    ''
  )
FROM
  CRT_CUST_MAST ccm
WHERE
  ccm.cust_id = :p_cust_id
  AND ccm.cert_ty = 'ATHLETIC_TRAINER'
  AND (
    (
      ccm.level_id = 'CERTIFIED'
      AND ccm.certified_since_dt > '12/31/2021'
      AND ccm.current_exp_date = '12/31/2023'
    )
    OR (
      ccm.level_id = 'EXPIRED_REACTIVATE'
      AND ccm.certified_since_dt > '12/31/2021'
      AND ccm.current_exp_date = '2/28/2024'
    )
  )