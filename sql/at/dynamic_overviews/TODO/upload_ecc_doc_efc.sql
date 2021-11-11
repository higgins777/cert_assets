select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
<a href="sbmssamysubmittals.display_page?p_collection_id=AT_EXAM_ECC_APP">Upload Emergency Cardiac Care</a>
    </div>
    <div class="boc-todo-date">
      Must be current and valid
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
    AND m.level_id IN ('CERTIFICATION_ELIGIBLE')
) AND NOT EXISTS (
  SELECT 1 FROM CEN_CUST_TX tx 
  WHERE tx.cust_id= :cust_id
  AND tx.category_cd = 'ECC'
  AND tx.end_dt > SYSDATE
  AND tx.status_cd = 'APPROVED'
)