select '<div class="boc-left-nav">
  <a target="_blank" href="/sbmssamysubmittals.display_page?p_collection_id=AT_RESIGNATION&p_cust_id=BOC391820">
    Retire/Resign Certification
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
