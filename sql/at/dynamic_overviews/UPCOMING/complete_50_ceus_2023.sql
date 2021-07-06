select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      Complete 50 CEUs by 12/31/2023
    </div>
    <div class="boc-todo-date">
      Reporting link available in 2022
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
    AND m.level_id IN ('EXPIRED_REACTIVATE', 'CERTIFIED')
    AND m.CERTIFIED_SINCE_DT BETWEEN '1/1/2021' AND '12/31/2021'
    AND m.CURRENT_EXP_DATE = '12/31/2023'
)