select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="sbmssamysubmittals.display_page?p_collection_id=AT_MAINTAIN_APP&p_cust_id=' || :cust_id || '">
        Enter/Report CE Activity (25 CEUs Due)
      </a>
    </div>
    <div class="boc-todo-date">
      Reporting deadline: 12/31/2021 11:59pm CT
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
  FROM CRT_CUST_MAST c
  INNER JOIN CRT_CUST_PERIOD p ON c.cust_id = p.cust_id
  WHERE c.cust_id = :cust_id
  AND (
    (
      c.level_id = 'CERTIFIED'
      AND c.certified_since_dt BETWEEN '1/1/2020' and '12/31/2020'
      AND c.current_exp_date = '12/31/2021'
    )
    OR (
      c.level_id = 'EXPIRED_REACTIVATE'
      AND c.current_exp_date = '2/28/2022'
      AND p.level_id = 'CERTIFIED'
      AND p.start_dt BETWEEN '1/1/2020' and '12/31/2020'
    )
  )
) AND (
  (NOT EXISTS 
    (SELECT 1
    FROM SBM_SUBMITTAL s
    WHERE s.primary_cust_id = :cust_id
    AND s.collection_id = 'AT_MAINTAIN_APP'
    AND wkfcfglib.getcurrentstate(s.wkf_serno) IN ('COMPLETE_AUDIT_SELECTED', 'COMPLETE') 
    )
  ) 
  OR 
  (EXISTS
    (SELECT 1
    FROM SBM_SUBMITTAL s
    WHERE s.primary_cust_id = :cust_id
    AND s.collection_id = 'AT_MAINTAIN_APP'
    AND wkfcfglib.getcurrentstate(s.wkf_serno) = 'PENDING')
  )
)