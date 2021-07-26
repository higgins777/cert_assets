select '<div class="boc-left-nav">
  <a target="_blank" href="sbmssamysubmittals.display_page?p_collection_id=AT_EXAM_ECC_APP">
    Submit Emergency Cardiac Care
  </a>
</div>'
from dual
where exists (
  SELECT 1 FROM CEN_CUST_ATTRDTL cca
  LEFT JOIN CRT_CUST_MAST ccm ON ccm.cust_id = cca.cust_id
  WHERE cca.cust_id=:cust_id
  AND cca.ATTRIBUTE_TY = 'AT_REGISTRATION_REASON' 
  AND cca.ATTRIBUTE_CD = 'BOC_EXAM'
  AND ccm.CERT_TY IN (NULL, 'ATHLETIC_TRAINER')
  AND ccm.LEVEL_ID IN (NULL, 'EXAM_ELIGIBLE_EXPIRED','CERTIFICATION_ELIGIBLE','EXAM_ELIGIBLE_EXTENDED')
)