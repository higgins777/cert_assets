select c.level_id
    from crt_cust_mast c,
    where c.cust_id = 'BOC391820'
      and c.cert_ty = 'ATHLETIC_TRAINER'
      and c.level_id = 'EXAM_ELIGIBLE'


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
      and trunc(p.start_dt) < trunc(a.dvar)
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
      and exists (
        select 'X'
        from sbm_submittal s,
          sbm_submittal_attrdtl a,
          cen_cust_attrdtl ca
        where s.primary_cust_id = :cust_id
          and s.submittal_serno = a.submittal_serno
          and a.attribute_ty = 'STAFF_REVIEW_FIRST_DATE'
          and ca.cust_id = 'BOCATC'
          and ca.attribute_ty = 'AT_ELIGIBILITY_CLOSED'
          and s.submittal_serno = (
            select max(submittal_serno)
            from sbm_submittal
            where primary_cust_id = :cust_id
              and collection_id in ('AT_INITIAL_EXAM', 'AT_REINSTATE_APP')
          )
          and trunc(a.dvar) <= ca.dvar
      )
  )