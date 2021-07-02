/*
  Excluded Criteria for ATTR_TY=AT_REGISTRATION_REASON && ATTR_CD=BOC_EXAM || Null
  Rationale: We cannot find this, and do not understand its purpose

  Excluded Confirmation of current_user type == "I" && employer type == "PS"
  Rationale: 
    Query is running on Candidate Dashboard, confirms I Type
    Query confirms we are a student, would we ever be joined here to anything other than a PS Type
*/
select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="https://cert.bocatc.org/bocdevssa/ssaapexmnucall?p_app_id=BOCSSA&p_page_id=2517&p_cust_id=' || :cust_id ||'">Link Myself to a Program/School</a>
    </div>
  </div>
  <div class="col s2">
      <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
        <i class="boc-todo-info material-icons">info</i>
      </a>
  </div>
</div>'
from dual
where not exists (
  SELECT 1
  FROM CEN_CUST_EMP
  WHERE EMPLOYEE_ID = :cust_id 
  AND FUNCTION_CD='STUDENT'
)