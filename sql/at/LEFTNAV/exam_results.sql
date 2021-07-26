select '<div class="boc-left-nav">
  <a target="_blank" href="censsareqauth?p_vc=PANDA&p_url=https%3A%2F%2Fat.bocatc.org%2Fusr%2Facgi_ssos%2Fauth_sso%3Fp_aa_token%3D__AUTHTOKEN__%26route%3Dto_exam_attempts">
    View Exam Results
  </a>
</div>'
from dual
-- where exists (
--   SELECT 1
--   FROM CEN_CUST_TX tx
--   WHERE tx.cust_id = :cust_id
--     AND tx.level1 IN ('ATHLETIC_TRAINER', 'BOC_AT')
--     AND tx.CATEGORY_CD = 'EXAM_SCANTRON'
-- )

-- https%3A%2F%2Fat.bocatc.org%2Fusr%2Fssos_controller%2Fauth_sso%3Fp_aa_token%3D__AUTHTOKEN__%26route%3Dto_exam_attempts

--https://at.bocatc.org/usr/ssos_controller/auth_sso?p_aa_token=__AUTHTOKEN__&route=to_exam_attempts

-- censsareqauth?p_vc=PANDA&p_url=https%3A%2F%2Fat.bocatc.org%2Fusr%2Fssos_controller%2Fauth_sso%3Fp_aa_token%3D__AUTHTOKEN__%26route%3Dto_exam_attempts
