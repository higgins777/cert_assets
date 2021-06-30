-- CUST_ID: 401244
select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="https://cert.bocatc.org/bocdevssa/sbmssamysubmittals.display_page?p_collection_id=AT_INITIAL_APP&p_cust_id=' || :cust_id || '">Apply for Exam (step 1 of 2)</a>
    </div>
    <div class="boc-todo-date">
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
  SELECT *
  FROM SBM_SUBMITTAL s
  INNER JOIN CEN_CUST_EMP e ON s.primary_cust_id=e.employee_id
  WHERE e.employee_id = :cust_id
  AND s.collection_id = 'AT_INITIAL_APP'
  AND e.function_cd = 'STUDENT'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('PENDING', NULL)
)