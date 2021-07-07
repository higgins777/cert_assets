select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="https://cert.bocatc.org/bocdevssa/ssaapexmnucall?p_app_id=BOCSSA&p_page_id=2517&p_cust_id=' || :cust_id ||'">Link Myself to a Program/School</a>
    </div>
  </div>
  <div class="col s2">
      <!-- <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
        <i class="boc-todo-info material-icons">info</i>
      </a> -->
  </div>
</div>'
from dual
where not exists (
  SELECT 1
  FROM CEN_CUST_EMP
  WHERE EMPLOYEE_ID = :cust_id 
  AND FUNCTION_CD='STUDENT'
)