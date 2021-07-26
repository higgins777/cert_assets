select '<div class="boc-left-nav">
  <a target="_blank" href="wkfinstantiation.instantiate?p_workflow=ECC_UPDATE&p_event_id=">
    Submit Emergency Cardiac Care
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