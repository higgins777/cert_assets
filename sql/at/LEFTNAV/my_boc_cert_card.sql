select '<div class="boc-left-nav">
  <a target="_blank" href="/f?p=STDSSA:1000:12327616278413::::G_CUST_ID:BOC391820#?p_cust_id=BOC391820">
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
