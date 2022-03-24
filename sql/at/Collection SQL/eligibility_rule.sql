-- The second secondary condition can be deleted
-- 
select 'Y'
from dual
where exists (
    select c.level_id
    from crt_cust_mast c,
      crt_cust_period p,
      cen_cust_attrdtl a
    where c.cust_id = :cust_id
      and c.cert_ty = 'ATHLETIC_TRAINER'
      and c.level_id = 'EXAM_ELIGIBLE'
      and c.period_serno = p.period_serno
      and a.cust_id = 'BOCATC'
      and a.attribute_ty = 'AT_ELIGIBILITY_CLOSED'
      and trunc(p.start_dt) <= trunc(a.dvar)
  )
  or exists (
    select c.level_id
    from crt_cust_mast c,
      crt_cust_period p,
      cen_cust_attrdtl a
    where c.cust_id = :cust_id
      and c.cert_ty = 'ATHLETIC_TRAINER'
      and c.level_id = 'EXAM_ELIGIBLE'
      and c.period_serno = p.period_serno
      and a.cust_id = 'BOCATC'
      and a.attribute_ty = 'AT_ELIGIBILITY_CLOSED'
      and trunc(p.start_dt) >= trunc(a.dvar)
  )