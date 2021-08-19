select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a href="ssaapexmnucall?p_app_id=ARSSA&p_page_id=6100&p_clearcache=6100">Pay 2020 Cert Maintenance Fee</a>
    </div>
    <div class="boc-todo-date">
    Payment deadline: 12/31/2021 11:59pm CT
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
  INNER JOIN MEM_SGP_MAST msm ON msm.cust_id = :cust_id
  WHERE m.cust_id = :cust_id
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND m.level_id IN ('EXPIRED_REACTIVATE', 'CERTIFIED')
    AND msm.paid_thru_dt = '12/31/2019'
  ) OR exists (
  SELECT 1
  FROM CRT_CUST_MAST m
  INNER JOIN MEM_SGP_MAST msm ON msm.cust_id = :cust_id
  INNER JOIN MEM_SGP_ORD mso ON mso.cust_id = :cust_id
  INNER JOIN MEM_SGP_ORD_LINE msol ON mso.MEMB_SERNO = msol.MEMB_SERNO
  WHERE m.cust_id = :cust_id
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND m.level_id IN ('EXPIRED_REACTIVATE', 'CERTIFIED')
    AND msm.paid_thru_dt = '12/31/2021'
    AND msol.amount = 55
)
