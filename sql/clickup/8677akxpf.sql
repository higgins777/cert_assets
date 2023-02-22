select
'<a href="sbmssamysubmittals.display_page?p_collection_id=AT_ANNUAL_ATTEST_1&p_cust_id=' || :cust_id || '">
<div class="boc-todo-row row">
<div class="col s10">
<div class="boc-todo-action">
Pay 2022 Cert Maintenance Fee
</div>
<div class="boc-todo-date">
Payment deadline: 12/31/2022 11:59pm CT
</div>
</div>
<div class="col s2">
</div>
</div>
</a>'
FROM
  CRT_CUST_MAST ccm
WHERE
  ccm.cust_id = :cust_id
  AND ccm.cert_ty = 'ATHLETIC_TRAINER'
  AND exists (
    SELECT
      1
    FROM
      CRT_CUST_MAST c
      LEFT JOIN SBM_SUBMITTAL s ON s.primary_cust_id = c.cust_id
    WHERE
      c.cust_id = :cust_id
      AND (
        (
          --- 1a. CERTIFIED or EXPIRED_REACTIVATE with Certified Since Date between 1/1/2022 and 12/31/2022 and Expiration Date = 12/31/2023
          c.level_id IN ('CERTIFIED','EXPIRED_REACTIVE')
          AND c.certified_since_dt >= '1/1/2022'
          AND c.certified_since_dt <= '12/31/2022'
          AND c.current_exp_date = '12/31/2023'
        )
        OR (
          --- 1b. CERTIFIED or EXPIRED_REACTIVATE  with Certified Since Date before 1/1/2022 and Expiration Date = 12/31/2023 AND submittal AT_ANNUAL_ATTEST_1 with Status = COMPLETE
          c.level_id IN ('CERTIFIED','EXPIRED_REACTIVE')
          AND c.certified_since_dt <= '1/1/2022'
          AND c.current_exp_date = '12/31/2023'
          AND s.collection_id = 'AT_ANNUAL_ATTEST_1'
          AND wkfcfglib.getcurrentstate(s.wkf_serno) IN ('COMPLETE')
        )
        OR (
          --- 1c. CERTIFIED or EXPIRED_REACTIVATE with a submittal AT_ANNUAL_ATTEST_2 with Status IN (PENDING, CHECKOUT, AWAITING_PAYMENT)
          c.level_id IN ('CERTIFIED','EXPIRED_REACTIVE')
          AND EXISTS (
            SELECT
              1
            FROM
              SBM_SUBMITTAL s
            WHERE
              s.primary_cust_id = :cust_id
              AND s.collection_id = 'AT_ANNUAL_ATTEST_2'
              AND wkfcfglib.getcurrentstate(s.wkf_serno) IN ('PENDING', 'CHECKOUT', 'AWAITING_PAYMENT')
          )
        )
      )
  )
  AND NOT EXISTS (
    --- 2a. CERTIFIED with Certified Since Date > 12/31/2022 and Expiration Date = 12/31/2025
    SELECT
      1
    FROM
      CRT_CUST_MAST c
    WHERE
      c.cust_id = :cust_id
      AND c.level_id IN ('CERTIFIED')
      AND c.certified_since_dt >= '12/31/2022'
      AND c.current_exp_date = '12/31/2025'
    )
  AND NOT EXISTS (
    --- 2b.CERTIFIED or EXPIRED_REACTIVATE with a submittal AT_ANNUAL_ATTEST_2 with Status = COMPLETE
    SELECT
      1
    FROM
      SBM_SUBMITTAL s
      INNER JOIN CRT_CUST_MAST c ON s.primary_cust_id = c.cust_id
    WHERE
      s.primary_cust_id = :cust_id
      AND c.level_id IN ('CERTIFIED', 'EXPIRED_REACTIVATE')
      AND s.collection_id = 'AT_ANNUAL_ATTEST_2'
      AND wkfcfglib.getcurrentstate(s.wkf_serno) IN ('COMPLETE')
  )
