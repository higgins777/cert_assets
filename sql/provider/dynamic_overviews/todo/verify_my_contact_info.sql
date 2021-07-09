select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="censsaindprofile.display_profile?p_profile_ty=INDIVIDUAL_PROFILE&p_cust_id=' || :cust_id || '">
        Verify My Contact Info
      </a>
    </div>
    <div class="boc-todo-date">
    </div>
  </div>
  <div class="col s2">
      <a class="tooltipped" data-position="bottom" data-tooltip="Verify My Contact Info">
        <i class="boc-todo-info material-icons">info</i>
      </a>
  </div>
</div>'
  from dual
  where not exists (select 'Recently Updated'
  from dual
  where cencustlib.get_cust_attrdtl_dvar(p_cust_id => :cust_id, p_attribute_ty => 'LAST_PROFILE_UPDATE', p_attribute_cd => 'LAST_PROFILE_UPDATE') >= trunc(sysdate) - 90)