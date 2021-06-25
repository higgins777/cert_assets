/*
  Excluded Criteria for ATTR_TY=AT_REGISTRATION_REASON && ATTR_CD=BOC_EXAM || Null
  Rationale: We cannot find this, and do not understand its purpose

  Excluded Confirmation of current_user type == "I" && employer type == "PS"
  Rationale: 
    Query is running on Candidate Dashboard, confirms I Type
    Query confirms we are a student, would we ever be joined here to anything other than a PS Type
*/
select '<div class="todo"><a href="https://cert.bocatc.org/bocdevssa/ssaapexmnucall?p_app_id=BOCSSA&p_page_id=2517">Link Myself to a Program/School</a></div>'
from dual
where not exists (
  SELECT 1 FROM CEN_CUST_EMP WHERE EMPLOYEE_ID = :p_cust_id AND FUNCTION_CD='STUDENT'
)