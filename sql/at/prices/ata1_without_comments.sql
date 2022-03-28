declare cursor c_member_check is
select
  attribute_cd
from
  cen_cust_attrdtl
where
  cust_id = :cust_id
  and attribute_ty = 'NATA_MEMBER';

cursor c_collection_type is
select
  collection_id
from
  sbm_submittal
where
  submittal_serno = :submittal_serno;

cursor c_ose_level_id is
select
  level_id
from
  crt_cust_mast
where
  cust_id = :cust_id
  AND cert_ty = 'ORTHOPEDIC_SPECIALIST'
  AND level_id = 'CERTIFIED';


cursor c_ose_cert_dt is
select
  CERTIFIED_SINCE_DT
from
  crt_cust_mast
where
  cust_id = :cust_id
  AND cert_ty = 'ORTHOPEDIC_SPECIALIST'
  AND level_id = 'CERTIFIED';

v_mem cen_cust_attrdtl.attribute_cd % type;
v_coll_ty sbm_submittal.collection_id % type;
v_os_lvl crt_cust_mast.level_id % type;
v_os_crt_dt crt_cust_mast.certified_since_dt % type;

begin open c_member_check;
fetch c_member_check into v_mem;
close c_member_check;

open c_collection_type;
fetch c_collection_type into v_coll_ty;
close c_collection_type;

open c_ose_level_id;
fetch c_ose_level_id into v_os_lvl;
close c_ose_level_id;

open c_ose_cert_dt;
fetch c_ose_cert_dt into v_os_crt_dt;
close c_ose_cert_dt;

if nvl(v_coll_ty, 'N') = 'AT_ANNUAL_ATTEST_1'
and nvl(v_mem, 'NO') = 'YES'
and nvl(v_os_lvl, 'N') = 'CERTIFIED'
and nvl(v_os_crt_dt, '12/12/2999') < '1/1/2022'
AND trunc(SYSDATE) > '12/31/2021' then wkfcfglib.setqualifiervalue (
  p_wkf_serno => :wkf_serno,
  p_qualifier_id => 'PRICE_CD',
  p_qualifier_value => 'NATA_MEMBER_OS_LATE'
);
commit;

elsif nvl(v_coll_ty, 'N') = 'AT_ANNUAL_ATTEST_1'
and nvl(v_mem, 'NO') = 'YES'
and (nvl(v_os_lvl, 'N') = 'N' OR nvl(v_os_crt_dt, '1/1/1900') >= '1/1/2022')
AND trunc(SYSDATE) > '12/31/2021' then wkfcfglib.setqualifiervalue (
  p_wkf_serno => :wkf_serno,
  p_qualifier_id => 'PRICE_CD',
  p_qualifier_value => 'NATA_MEMBER_LATE'
);
commit;

elsif nvl(v_coll_ty, 'N') = 'AT_ANNUAL_ATTEST_1'
and nvl(v_mem, 'NO') in ('NO', 'INVALID')
and nvl(v_os_lvl, 'N') = 'CERTIFIED'
and nvl(v_os_crt_dt, '12/12/2999') < '1/1/2022'
AND trunc(SYSDATE) > '12/31/2021' then wkfcfglib.setqualifiervalue (
  p_wkf_serno => :wkf_serno,
  p_qualifier_id => 'PRICE_CD',
  p_qualifier_value => 'NATA_NOM_OS_LATE'
);
commit;

elsif nvl(v_coll_ty, 'N') = 'AT_ANNUAL_ATTEST_1'
and nvl(v_mem, 'NO') in ('NO', 'INVALID')
and (nvl(v_os_lvl, 'N') = 'N' OR nvl(v_os_crt_dt, '1/1/1900') >= '1/1/2022')
AND trunc(SYSDATE) > '12/31/2021' then wkfcfglib.setqualifiervalue (
  p_wkf_serno => :wkf_serno,
  p_qualifier_id => 'PRICE_CD',
  p_qualifier_value => 'NATA_NOM_LATE'
);
commit;

elsif nvl(v_coll_ty, 'N') = 'AT_ANNUAL_ATTEST_1'
and nvl(v_mem, 'NO') = 'YES'
and (nvl(v_os_lvl, 'N') = 'N' OR nvl(v_os_crt_dt, '1/1/1900') >= '1/1/2022')
then wkfcfglib.setqualifiervalue (
  p_wkf_serno => :wkf_serno,
  p_qualifier_id => 'PRICE_CD',
  p_qualifier_value => 'NATA_MEMBER'
);
commit;

elsif nvl(v_coll_ty, 'N') = 'AT_ANNUAL_ATTEST_1'
and nvl(v_mem, 'NO') = 'YES'
and nvl(v_os_lvl, 'N') = 'CERTIFIED' 
and nvl(v_os_crt_dt, '12/12/2999') < '1/1/2022'
then wkfcfglib.setqualifiervalue (
  p_wkf_serno => :wkf_serno,
  p_qualifier_id => 'PRICE_CD',
  p_qualifier_value => 'NATA_MEMBER_OS'
);
commit;

elsif nvl(v_coll_ty, 'N') = 'AT_ANNUAL_ATTEST_1'
and nvl(v_mem, 'NO') in ('NO', 'INVALID')
and (nvl(v_os_lvl, 'N') = 'N' OR nvl(v_os_crt_dt, '1/1/1900') >= '1/1/2022')
then wkfcfglib.setqualifiervalue (
  p_wkf_serno => :wkf_serno,
  p_qualifier_id => 'PRICE_CD',
  p_qualifier_value => 'NATA_NOM'
);
commit;

elsif nvl(v_coll_ty, 'N') = 'AT_ANNUAL_ATTEST_1'
and nvl(v_mem, 'NO') in ('NO', 'INVALID')
and nvl(v_os_lvl, 'N') = 'CERTIFIED' 
and nvl(v_os_crt_dt, '12/12/2999') < '1/1/2022'
then wkfcfglib.setqualifiervalue (
  p_wkf_serno => :wkf_serno,
  p_qualifier_id => 'PRICE_CD',
  p_qualifier_value => 'NATA_NOM_OS'
);
commit;

end if;

end;
