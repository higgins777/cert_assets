SELECT NVL2(c2.certificate_no, '<br><strong>Certification #:</strong> ' || c2.certificate_no, '<br><strong>Customer ID:</strong> ' || c1.cust_id)
FROM cen_cust_mast c1
LEFT JOIN crt_cust_mast c2 ON c2.cust_id=c1.cust_id AND c2.cert_ty = 'ATHLETIC_TRAINER'
WHERE c1.cust_id = :p_cust_id