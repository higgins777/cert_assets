select 
'<span style="display: none" id="redirect-to-ap">' || :cust_id || '</span>'
from dual
where exists (
  SELECT 1 FROM CEN_CUST_ATTRDTL WHERE ATTRIBUTE_TY='AT_REGISTRATION_REASON' AND ATTRIBUTE_CD='BOC_PROVIDER'
)