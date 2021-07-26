select '<div class="boc-left-nav">
  <a target="_blank" href="boccertcardpdf.generate_cert?p_cust_id=' || :cust_id || '">
    My BOC Card
  </a>
</div>'
from dual
where exists (
  SELECT 1
  FROM CRT_CUST_MAST m
  WHERE m.cust_id = :cust_id
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND m.level_id IN ('CERTIFIED')
)
