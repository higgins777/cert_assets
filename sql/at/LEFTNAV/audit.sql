select '<div class="boc-left-nav">
  <a target="_blank" href="censsareqauth?p_vc=PANDA&p_url=https%3A%2F%2Fat.bocatc.org%2Fusr%2Facgi_ssos%2Fauth_sso%3Fp_aa_token%3D__AUTHTOKEN__%26route%3Dto_audit">
    Access My Audit
  </a>
</div>'
from dual
where exists (
  SELECT 1 
  FROM CEN_CUST_ATTRDTL 
  WHERE ATTRIBUTE_TY='PANDA_AUDIT'
  AND NVAR=1
  AND CUST_ID = :cust_id
)