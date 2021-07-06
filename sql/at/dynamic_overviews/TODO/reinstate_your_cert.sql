select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      Pay Late Fee
    </div>
    <div class="boc-todo-date">
      Payment deadline: 02/28/2022 11:59pm CT
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
    AND m.level_id IN ('EXPIRED_REINSTATE', 'EXPIRED_RBE')
)