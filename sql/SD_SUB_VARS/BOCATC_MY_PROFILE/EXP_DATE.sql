SELECT NVL2(c2.current_exp_date, '<br><strong>Expiration Date:</strong> ' || c2.current_exp_date, '') 
FROM cen_cust_mast c1
  LEFT JOIN crt_cust_mast c2 ON c2.cust_id=c1.cust_id 
    AND c2.cert_ty = 'ATHLETIC_TRAINER' 
    AND c2.level_id NOT IN ('EXAM_ELIGIBLE_EXPIRED', 'EXPIRED_RBE')
WHERE c1.cust_id = :p_cust_id


-- EXCLUDES THE EXPIRED STATUSES