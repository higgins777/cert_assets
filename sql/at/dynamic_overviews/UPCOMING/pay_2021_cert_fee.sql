select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      Pay 2021 Cert Maintenance Fee
    </div>
    <div class="boc-todo-date">
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
  INNER JOIN MEM_SGP_MAST msm ON m.cust_id=msm.cust_id
  WHERE m.cust_id = :cust_id
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND m.level_id IN ('EXPIRED_REACTIVATE', 'CERTIFIED')
    AND msm.PARENT_SUBGROUP_ID = 'BOCATC'
    AND msm.EXPIRE_DT = '12/31/2021'
)