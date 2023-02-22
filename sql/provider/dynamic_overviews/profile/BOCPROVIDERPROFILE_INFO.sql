select
  col_data
from
  (
    select
      '<div id="BOCProviderProfileFullName" class="BOCProviderProfileContent">' || cencust.get_display_nm(bocdashboardlib.get_provider(:cust_id)) || '</div>' col_data,
      1 sort_order
    from
      dual
    union
    select
      '<div id="BOCProviderProfileCertNum" class="BOCProviderProfileContent">' || '<label for="BOCProviderProfileCertNumText" id="BOCProviderProfileCertNumLabel">Provider Number: </label>' || '<span id="BOCProviderProfileCertNumText">' ||(
        select
          certificate_no
        from
          crt_cust_mast
        where
          cust_id = bocdashboardlib.get_provider(:cust_id)
          and cert_ty = 'APPROVED_PROVIDER'
          and spec_ty = 'APPROVED_PROVIDER'
          and rownum < 2
      ) || '</span>' || '</div>' col_data,
      2 sort_order
    from
      dual
    union
    select
      '<div id="BOCProviderProfileStatus" class="BOCProviderProfileContent">' || '<label for="BOCProviderProfileStatusText" id="BOCProviderProfileStatusLabel">Status: </label>' || '<span id="BOCProviderProfileStatusText">' ||(
        select
          concat(
            crtapplib.get_level_descr(
              p_cert_ty = > cert_ty,
              p_spec_ty = > spec_ty,
              p_level_id = > level_id
            ),
            '- Probation'
          )
        from
          crt_cust_mast
        where
          cust_id = bocdashboardlib.get_provider(:cust_id)
          and cert_ty = 'APPROVED_PROVIDER'
          and spec_ty = 'APPROVED_PROVIDER'
          and rownum < 2
      ) || '</span>' || '</div>' col_data,
      3 sort_order
    from
      dual
    where
      exists (
        select
          'X'
        from
          crt_cust_mast
        where
          cust_id = bocdashboardlib.get_provider(:cust_id)
          and cert_ty = 'APPROVED_PROVIDER'
          and spec_ty = 'APPROVED_PROVIDER'
          and level_id in ('ACTIVE', 'ANNUAL_REPORT')
          and cert_status = 'PROBATION'
      )
    union
    select
      '<div id="BOCProviderProfileStatus" class="BOCProviderProfileContent">' || '<label for="BOCProviderProfileStatusText" id="BOCProviderProfileStatusLabel">Status: </label>' || '<span id="BOCProviderProfileStatusText">' ||(
        select
          crtapplib.get_level_descr(
            p_cert_ty = > cert_ty,
            p_spec_ty = > spec_ty,
            p_level_id = > level_id
          )
        from
          crt_cust_mast
        where
          cust_id = bocdashboardlib.get_provider(:cust_id)
          and cert_ty = 'APPROVED_PROVIDER'
          and spec_ty = 'APPROVED_PROVIDER'
          and rownum < 2
      ) || '</span>' || '</div>' col_data,
      3 sort_order
    from
      dual
    where
      not exists (
        select
          'X'
        from
          crt_cust_mast
        where
          cust_id = bocdashboardlib.get_provider(:cust_id)
          and cert_ty = 'APPROVED_PROVIDER'
          and spec_ty = 'APPROVED_PROVIDER'
          and level_id in ('ACTIVE', 'ANNUAL_REPORT')
          and cert_status = 'PROBATION'
      )
    union
    select
      '<div id="BOCProviderProfileStatus" class="BOCProviderProfileContent">' || '<label for="BOCProviderProfileStatusText" id="BOCProviderProfileStatusLabel">Active Since: </label>' || '<span id="BOCProviderProfileStatusText">' || to_char(certified_since_dt, 'MM/DD/YYYY') || '</span>' || '</div>' col_data,
      4 sort_order
    from
      crt_cust_mast
    where
      cust_id = bocdashboardlib.get_provider(:cust_id)
      and cert_ty = 'APPROVED_PROVIDER'
      and spec_ty = 'APPROVED_PROVIDER'
      and level_id in ('ACTIVE', 'ANNUAL_REPORT')
      and rownum < 2
  )



  <br><br><strong>2023 Cert Maintenance Fee:<br><font color="#FF8772">DUE</font></strong>