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

v_member_check cen_cust_attrdtl.attribute_cd % type;

v_collection_type sbm_submittal.collection_id % type;

begin open c_member_check;

fetch c_member_check into v_member_check;

close c_member_check;

open c_collection_type;

fetch c_collection_type into v_collection_type;

close c_collection_type;

if nvl(v_collection_type, 'N') = 'AT_INITIAL_APP'
and nvl(v_member_check, 'NO') = 'YES' then wkfcfglib.setqualifiervalue (
  p_wkf_serno = > :wkf_serno,
  p_qualifier_id = > 'PRICE_CD',
  p_qualifier_value = > 'NATA_MEMBER'
);

commit;

else wkfcfglib.setqualifiervalue (
  p_wkf_serno = > :wkf_serno,
  p_qualifier_id = > 'PRICE_CD',
  p_qualifier_value = > 'NATA_NOM'
);

commit;

end if;

end;