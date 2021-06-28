SELECT *
FROM SBM_SUBMITTAL s
  INNER JOIN CRT_CUST_MAST c ON s.primary_cust_id = c.cust_id
  INNER JOIN CRT_CUST_PERIOD p ON s.primary_cust_id = p.cust_id
WHERE c.cust_id = :cust_id
  AND s.collection_id = 'AT_MAINTAIN_APP'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('PENDING', NULL)
  AND (
    (
      c.level_id = 'CERTIFIED'
      AND c.certified_since_dt < '1/1/2020'
      AND c.current_exp_date = '12/31/2021'
    )
    OR (
      c.level_id = 'EXPIRED_REACTIVATE'
      AND p.level_id = 'CERTIFIED'
      AND p.start_dt < '1/1/2020'
      AND p.end_dt = '2/28/2022'
    )
  )



-- CERTIFIED with certification date BEFORE 1/1/2020 and expiration date EQUAL TO 12/31/2021

-- EXPIRED_REACTIVATE with previous certification date BEFORE 1/1/2020 and expiration date EQUAL TO 02/28/2022