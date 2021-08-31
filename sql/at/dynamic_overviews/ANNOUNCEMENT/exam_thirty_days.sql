select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      <a target="_blank" href="censsareqauth?p_vc=PANDA&p_url=https%3A%2F%2Fat.bocatc.org%2Fusr%2Facgi_ssos%2Fauth_sso%3Fp_aa_token%3D__AUTHTOKEN__%26route%3Dto_exam_attempts">
        Exam Results Posted
      </a>
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
  FROM SBM_SUBMITTAL ss
  INNER JOIN SBM_SUBMITTAL_ATTRDTL ssa ON ss.submittal_serno=ssa.submittal_serno
  WHERE ss.primary_cust_id = :cust_id
  AND ssa.attribute_ty = 'AT_EXAM_POSTED_DATE' 
  AND ssa.dvar > (SYSDATE - 30)
)