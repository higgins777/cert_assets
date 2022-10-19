SELECT DISTINCT(ccta.attribute_ty)
FROM CEN_CUST_TX cct
  LEFT JOIN CEN_CUST_TX_ATTRDTL ccta ON ccta.tx_serno=cct.tx_serno
WHERE CATEGORY_CD IN ('CAT_A', 'CAT B', 'CAT_C', 'CAT_D', 'CAT_EBP', 'ECC');


ATTRIBUTE_TY


'AT_MAINTAIN_DISSERTATION',
'AT_EXAM_ECC_UPLOAD',
'AT_MAINTAIN_CEUS',
'AT_MAINTAIN_INSTITUTION',
'AT_MAINTAIN_PROVIDER_NUMBER',
'AT_EXAM_ECC_ID',
'AT_MAINTAIN_RESIDENCY_FOCUS',
'AT_EXAM_ECC_UPLOAD1',
'AT_MAINTAIN_PUBLICATION',
'AT_MAINTAIN_COURSE_TITLE',
'AT_MAINTAIN_NON_BOC_PROVIDER',
'AT_MAINTAIN_PROGRAM',
'AT_MAINTAIN_ARTICLE',
'AT_MAINTAIN_BOC_PROVIDER',
'AT_MAINTAIN_CREDIT_HOURS',
'AT_MAINTAIN_YEARS',