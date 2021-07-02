select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="https://cert.bocatc.org/bocdevssa/sbmssamysubmittals.display_page?p_collection_id=AT_MAINTAIN_APP&p_cust_id=' || :cust_id || '">
        Enter/Report CE Activity (50 CEUs Due)
      </a>
    </div>
    <div class="boc-todo-date">
      Due by 12/31/2021
    </div>
  </div>
  <div class="col s2">
      <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
        <i class="boc-todo-info material-icons">info</i>
      </a>
  </div>
</div>'
from dual
where exists (
  SELECT 1
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
        AND c.current_exp_date = '2/28/2022'
        AND p.level_id = 'CERTIFIED'
        AND p.start_dt < '1/1/2020'
      )
    )
)