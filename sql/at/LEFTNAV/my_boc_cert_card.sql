select '<div class="boc-left-nav">
  <a target="_blank" href="/boccertcardpdf.generate_cert?p_cust_id=BOC122903&p_cust_id=BOC122903">
    My BOC Certification Card
  </a>
</div>'
from dual
where exists (
  SELECT 1
  FROM CRT_CUST_MAST m
  WHERE m.cust_id = :cust_id
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND m.level_id IN ('EXPIRED_REACTIVATE', 'CERTIFIED')
)
