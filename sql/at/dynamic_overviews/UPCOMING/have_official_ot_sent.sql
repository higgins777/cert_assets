select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      Have Official Transcript Sent to BOC
    </div>
    <div class="boc-todo-date">
      Directly from University or transcript sxervice (and after graduation)
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
  INNER JOIN CEN_CUST_TX tx ON m.cust_id=tx.cust_id
  WHERE m.cust_id = :cust_id
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND m.level_id IN ('EXAM_ELIGIBLE')
    AND tx.category_cd = 'TRANSCRIPT'
    AND tx.level1 = 'OFFICIAL'
    AND tx.status_cd = 'Approved'
)

