select 'Y'
from dual
where exists (
    select s.create_dt,
      s.submittal_serno,
      wkfcfglib.getcurrentstate(s.wkf_serno) as state
    from sbm_submittal s,
      cen_cust_emp e
    where e.employee_id = :cust_id
      and s.parent_cust_id = e.employer_id
      and wkfcfglib.getcurrentstate(s.wkf_serno) in ('REJECTED', 'APPROVED_PROBATION')
      and s.collection_id = 'ANNUAL_REPORT'
      and exists (
        select 1
        from sbm_submittal s,
          cen_cust_emp e,
          crt_cust_mast m,
          crt_cust_period p
        where s.primary_cust_id = :cust_id
          and s.primary_cust_id = e.employee_id
          and s.parent_cust_id = e.employer_id
          and trunc(sysdate) <= trunc(nvl((e.end_dt), sysdate))
          and e.employer_id = m.cust_id
          and m.period_serno = p.period_serno
          and m.cert_ty = 'APPROVED_PROVIDER'
          and m.spec_ty = 'APPROVED_PROVIDER'
          and m.level_id = 'EXPIRED'
          and trunc(p.start_dt + 90) >= trunc(sysdate)
      )
  )
  or exists (
    select 1
    from sbm_submittal s,
      cen_cust_emp e,
      crt_cust_mast m,
      crt_cust_period p
    where s.primary_cust_id = :cust_id
      and s.primary_cust_id = e.employee_id
      and s.parent_cust_id = e.employer_id
      and trunc(sysdate) <= trunc(nvl((e.end_dt), sysdate))
      and e.employer_id = m.cust_id
      and m.period_serno = p.period_serno
      and m.cert_ty = 'APPROVED_PROVIDER'
      and m.spec_ty = 'APPROVED_PROVIDER'
      and m.level_id = 'ACTIVE'
      and m.cert_status = 'PROBATION'
      and trunc(p.start_dt + 90) >= trunc(sysdate)
  )