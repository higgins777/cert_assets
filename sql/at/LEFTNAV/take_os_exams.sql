select '<div class="boc-left-nav">

<a target="_blank" href="censsareqauth?p_vc=PANDA&p_url=https%3A%2F%2Fsae.bocatc.org%2Facgi_ssos%2Fauth_sso%3Fp_aa_token%3D__AUTHTOKEN__%26route%3Dincoming_from_acgi_to_ose%26registry_id%3D' || n.cust_id || '%26first_name%3D' || n.first_nm || '%26last_name%3D' || n.last_nm || '%26email%3D' || y.cyber_txt || '%26certification_status%3D' || r.level_id || '%26certification_number%3D' || r.certificate_no || '">Take Self-Assessment Exam</a></div>'
FROM CEN_CUST_MAST n
LEFT JOIN CRT_CUST_MAST r ON n.cust_id=r.cust_id
LEFT JOIN CEN_CUST_CYBER y ON n.cust_id=y.cust_id
WHERE n.cust_id = :cust_id AND r.level_id IS NOT NULL
FETCH FIRST 1 ROWS ONLY

select '<div class="boc-left-nav">
<a target="_blank" href="censsareqauth?p_vc=PANDA&p_url=https%3A%2F%2Fsae.bocatc.org%2Facgi_ssos%2Fauth_sso%3Fp_aa_token%3D__AUTHTOKEN__%26route%3Dincoming_from_acgi_to_ose%26registry_id%3D' || n.cust_id || '%26first_name%3D' || n.first_nm || '%26last_name%3D' || n.last_nm || '%26email%3D' || y.cyber_txt || '%26certification_status%3D' || r.level_id || '%26certification_number%3D' || r.certificate_no || '">Take Self-Assessment Exam</a></div>'
FROM dual
WHERE exists (
  SELECT 1
  FROM CEN_CUST_MAST n
  LEFT JOIN CRT_CUST_MAST m
  INNER JOIN CEN_CUST_CYBER y ON m.cust_id=y.cust_id
  WHERE m.cust_id = :cust_id
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND m.level_id IN ('CERTIFIED')
)