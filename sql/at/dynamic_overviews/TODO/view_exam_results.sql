select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      View Exam Results (Panda Link)
    </div>
    <div class="boc-todo-date">
    </div>
  </div>
  <div class="col s2">
      <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
        <i class="boc-todo-info material-icons">info</i>
      </a>
  </div>
</div>'
from dual
where exists (
  SELECT 1
  FROM SBM_SUBMITTAL s
  INNER JOIN CRT_CUST_MAST m ON s.primary_cust_id = m.cust_id
  INNER JOIN CRT_CUST_PERIOD p ON s.primary_cust_id = p.cust_id
  WHERE m.cust_id = :cust_id
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND SYSDATE < (cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'EXAM_POSTED_DATE', p_attribute_cd => 'EXAM_POSTED_DATE') + 30)
)