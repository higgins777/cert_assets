select '<div class="boc-todo-row row">
  <div class="col s10">
    <div class="boc-todo-action">
      Have Official Transcript Sent to BOC
    </div>
    <div class="boc-todo-date">
      Directly from university or transcript service (and after graduation)
    </div>
  </div>
  <div class="col s2">
      <!-- <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
        <i class="boc-todo-info material-icons">info</i>
      </a> -->
  </div>
</div>'
from dual
where exists (
  SELECT 1
  FROM CRT_CUST_MAST m
  WHERE m.cust_id = :cust_id
    AND m.cert_ty = 'ATHLETIC_TRAINER'
    AND m.level_id IN ('CERTIFICATION_ELIGIBLE')
) AND exists (
  SELECT 1
  FROM SBM_SUBMITTAL s
  WHERE s.primary_cust_id = :cust_id
  AND s.collection_id = 'AT_INITIAL_EXAM'
  AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('TRANSCRIPT_NMI','TRANSCRIPT_ECC_NMI')
)