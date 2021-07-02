select 
'<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="ssaauthmain.id_passwd_update?p_application_cd=SSA&p_cust_id=' || :cust_id || '">
        Reset my Password
      </a>
    </div>
    <div class="boc-todo-date">
    </div>
  </div>
  <div class="col s2">
      <a class="tooltipped" data-position="bottom" data-tooltip="Reset your Password">
        <i class="boc-todo-info material-icons">info</i>
      </a>
  </div>
</div>'
from dual
where not exists
   (select 'Password Updated'
      from cen_cust_login
     where cust_id = :cust_id
       and application_cd = 'SSA'
       and trunc(last_passwd_change_dt) >= trunc(sysdate) - 180)