SELECT NVL2(l.descr, '<br><strong>Status</strong>: ' || l.descr, '') 
FROM cen_cust_mast c1
  LEFT JOIN crt_cust_mast c2 ON c2.cust_id=c1.cust_id 
    AND c2.cert_ty = 'ATHLETIC_TRAINER' 
  LEFT JOIN crt_cfg_speclevel l ON l.level_id=c2.level_id 
    AND l.cert_ty = 'ATHLETIC_TRAINER'
WHERE c1.cust_id = :p_cust_id
