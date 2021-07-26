select '<div class="boc-left-nav">
  <a target="_blank" href="censsareqauth?p_vc=PANDA&p_url=https%3A%2F%2Fat.bocatc.org%2Fusr%2Facgi_ssos%2Fauth_sso%3Fp_aa_token%3D__AUTHTOKEN__%26route%3Dto_assessment">
    Take Needs Assessment
  </a>
</div>'
from dual
where exists (
  SELECT 1
  FROM CRT_CUST_MAST m
  WHERE m.cust_id = :cust_id
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND m.level_id IN ('CERTIFIED')
)


-- https%3A%2F%2Fat.bocatc.org%2Fusr%2Fssos_controller%2Fauth_sso%3Fp_aa_token%3D__AUTHTOKEN__%26route%3Dto_exam_attempts

--https://at.bocatc.org/usr/ssos_controller/auth_sso?p_aa_token=__AUTHTOKEN__&route=to_exam_attempts

-- censsareqauth?p_vc=PANDA&p_url=https%3A%2F%2Fat.bocatc.org%2Fusr%2Fssos_controller%2Fauth_sso%3Fp_aa_token%3D__AUTHTOKEN__%26route%3Dto_exam_attempts
