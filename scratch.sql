[5:17 PM] Kendra Aspegren
select '<a href="sbmssamysubmittals.display_page?p_collection_id=AT_INITIAL_EXAM&p_cust_id=' || :cust_id || '">
<div class="boc-todo-row row">
<div class="col s10">
<div class="boc-todo-action">
Register for Exam
</div>
<div class="boc-todo-date">March/April registration window: 2/17-2/28</div>
</div>
<div class="col s2">
<!-- <a class="tooltipped" data-position="bottom" data-tooltip="Do your CEUs">
<i class="boc-todo-info material-icons">info</i>
</a> -->
</div>
</div>
</a>'
from dual
where exists 
(
  (
    SELECT 1
    FROM CRT_CUST_MAST m
    INNER JOIN CRT_CUST_PERIOD p ON p.period_serno=m.period_serno
    WHERE m.cust_id = :cust_id
    AND p.level_id = 'EXAM_ELIGIBLE'
    AND p.start_dt < cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_ELIGIBILITY_CLOSED', p_attribute_cd => 'AT_ELIGIBILITY_CLOSED')
    AND SYSDATE BETWEEN
    cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_EXAM_REG_OPEN', p_attribute_cd => 'AT_EXAM_REG_OPEN')
    AND
    cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_EXAM_REG_CLOSED', p_attribute_cd => 'AT_EXAM_REG_CLOSED')
    AND m.cert_ty='ATHLETIC_TRAINER'
    AND m.level_id='EXAM_ELIGIBLE'
  )
    AND NOT EXISTS (
    SELECT 1
    FROM SBM_SUBMITTAL s
    WHERE s.primary_cust_id = :cust_id
    AND s.collection_id = 'AT_INITIAL_EXAM'
    AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('EXAM_REGISTERED','EXAM_ELIG_PENDING')
  )
  AND NOT EXISTS (
  select 'X' from CRT_CUST_PERIOD p
  where p.cust_id = :cust_id
  and p.level_id IN ('EXPIRED_REINSTATE','EXPIRED_RBE')
  and p.cert_ty in ('ATHLETIC_TRAINER')
  )
) OR EXISTS (
  (
    SELECT 1
    FROM CRT_CUST_MAST m
    INNER JOIN CRT_CUST_PERIOD p ON p.period_serno=m.period_serno
    WHERE m.cust_id = :cust_id
    AND p.level_id = 'EXAM_ELIGIBLE'
    AND p.start_dt < cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_EXAM_REG_CLOSED', p_attribute_cd => 'AT_EXAM_REG_CLOSED')
    AND SYSDATE BETWEEN
    cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_EXAM_REG_OPEN', p_attribute_cd => 'AT_EXAM_REG_OPEN')
    AND
    cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_EXAM_REG_CLOSED', p_attribute_cd => 'AT_EXAM_REG_CLOSED')
    AND m.cert_ty='ATHLETIC_TRAINER'
    AND m.level_id='EXAM_ELIGIBLE'
    )
    AND NOT EXISTS (
    SELECT 1
    FROM SBM_SUBMITTAL s
    WHERE s.primary_cust_id = :cust_id
    AND s.collection_id = 'AT_INITIAL_EXAM'
    AND wkfcfglib.getcurrentstate(s.wkf_serno) in ('EXAM_REGISTERED','EXAM_ELIG_PENDING')
  )
  AND NOT EXISTS (
  select 'X' from CRT_CUST_PERIOD p
  where p.cust_id = :cust_id
  and p.level_id IN ('EXPIRED_REINSTATE','EXPIRED_RBE')
  and p.cert_ty in ('ATHLETIC_TRAINER')
  )
  AND NOT EXISTS (
  SELECT 1
  FROM SBM_SUBMITTAL s
  INNER JOIN SBM_SUBMITTAL_ATTRDTL a ON s.submittal_serno=a.submittal_serno
  WHERE s.primary_cust_id = :cust_id
  AND s.collection_id = 'AT_INITIAL_APP'
  AND a.attribute_ty = 'EXAM_ELIGIBLE_DATE'
  AND a.dvar > cencustlib.get_cust_attrdtl_dvar(p_cust_id => 'BOCATC', p_attribute_ty => 'AT_ELIGIBILITY_CLOSED', p_attribute_cd => 'AT_ELIGIBILITY_CLOSED')
  )
)