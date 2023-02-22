select '<div class="boc-upcoming-row row">
  <div class="col s10">
    <div class="boc-upcoming-action">
      Pay 2023 Cert Maintenance Fee by 12/31/2023
    </div>
  </div>
  <div class="col s2">
    <!-- <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
      <i class="boc-todo-info material-icons">info</i>
    </a> -->
  </div>
</div>'
from dual
where exists (
  SELECT 1
  FROM CRT_CUST_MAST m
  WHERE m.cust_id = :cust_id
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND m.level_id IN ('EXPIRED_REACTIVATE', 'CERTIFIED')
    AND m.CURRENT_EXP_DATE IN ('12/31/2023', '2/28/2024')
    AND m.certified_since_dt < '1/1/2023'
    AND m.current_exp_date <> '12/31/2025'
) AND NOT EXISTS (
  SELECT 1
  FROM sbm_submittal s
  WHERE s.primary_cust_id = :cust_id
    AND s.collection_id = 'AT_ANNUAL_ATTEST_1'
    AND wkfcfglib.getcurrentstate(s.wkf_serno) IN ('COMPLETE')
);

select '<div class="boc-upcoming-row row">
  <div class="col s10">
    <div class="boc-upcoming-action">
      Pay 2023 Cert Maintenance Fee by 12/31/2023
    </div>
  </div>
  <div class="col s2">
  </div>
</div>'
from dual
where exists (
  SELECT 1
  FROM CRT_CUST_MAST m
  WHERE m.cust_id = :cust_id
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND m.level_id IN ('EXPIRED_REACTIVATE', 'CERTIFIED')
    AND m.CURRENT_EXP_DATE IN ('12/31/2023', '2/28/2024')
    AND m.certified_since_dt < '1/1/2023'
    AND m.current_exp_date <> '12/31/2025'
) AND NOT EXISTS (
  SELECT 1
  FROM sbm_submittal s
  WHERE s.primary_cust_id = :cust_id
    AND s.collection_id = 'AT_ANNUAL_ATTEST_1'
    AND wkfcfglib.getcurrentstate(s.wkf_serno) IN ('COMPLETE')
);
