select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="ssaapexmnucall?p_app_id=BOCSSA&p_page_id=2505&p_cust_id=' || :cust_id || '">
        Link Myself to a Provider Account
      </a>
    </div>
    <div class="boc-todo-date">
    </div>
  </div>
  <div class="col s2">
      <a class="tooltipped" data-position="bottom" data-tooltip="Link Myself to a Provider Account">
        <i class="boc-todo-info material-icons">info</i>
      </a>
  </div>
</div>'
from dual
where not exists
   (select 'Provider Link Exists'
      from dual
     where bocdashboardlib.get_provider(:cust_id) is not null)

