/* Questions for Allen - Can they even see this if they are not an ATC? Do I need to confirm that with a cursor? */

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
  select level_id
from
  crt_cust_mast
where
  cust_id = :cust_id
  AND cert_ty='ORTHOPEDIC_SPECIALIST'
  AND level_id='CERTIFIED'


/* v_member_check = YES */
/* v_collection_type = 'AT_MAINTAIN_APP' */
v_member_check cen_cust_attrdtl.attribute_cd % type;
v_collection_type sbm_submittal.collection_id % type;
v_ose_level_id crt_cust_mast.level_id % type;

begin open c_member_check;
  fetch c_member_check into v_member_check;
close c_member_check;

open c_collection_type;
  fetch c_collection_type into v_collection_type;
close c_collection_type;

open c_ose_level_id;
  fetch c_ose_level_id into v_ose_level_id;
close c_ose_level_id;

/* All Cases require v_collection_type=AT_MAINTAIN_APP && a Certified or maybe Expired* ATC

/* Case 1
Condition: collection=AT_MAINTAIN_APP && member=YES
Result: NATA_MEMBER ($39)
*/
if nvl(v_collection_type, 'N') = 'AT_MAINTAIN_APP'
and nvl(v_member_check, 'NO') = 'YES' 
and nvl(v_ose_level_id, 'N') = 'N' then wkfcfglib.setqualifiervalue (
  p_wkf_serno = > :wkf_serno,
  p_qualifier_id = > 'PRICE_CD',
  p_qualifier_value = > 'NATA_MEMBER'
);
commit;

/* Case 2
Condition: collection=AT_MAINTAIN_APP && member=YES && TODAY > 12/31/2023
Result: NATA_MEMBER ($59)
*/
else if nvl(v_collection_type, 'N') = 'AT_MAINTAIN_APP'
and nvl(v_member_check, 'NO') = 'YES' 
and nvl(v_ose_level_id, 'N') = 'N'
AND SYSDATE() > '12/31/2023' then wkfcfglib.setqualifiervalue (
  p_wkf_serno = > :wkf_serno,
  p_qualifier_id = > 'PRICE_CD',
  p_qualifier_value = > 'NATA_MEMBER_LATE'
);
commit;

/* Case 3
Condition: collection=AT_MAINTAIN_APP && member=YES && ose_level_id='CERTIFIED
Result: NATA_MEMBER ($69)
*/
else if nvl(v_collection_type, 'N') = 'AT_MAINTAIN_APP'
and nvl(v_member_check, 'NO') = 'YES'
and nvl(v_ose_level_id, 'N') = 'CERTIFIED' then wkfcfglib.setqualifiervalue (
  p_wkf_serno = > :wkf_serno,
  p_qualifier_id = > 'PRICE_CD',
  p_qualifier_value = > 'NATA_MEMBER_OS'
);
commit;

/* Case 4
Condition: collection=AT_MAINTAIN_APP && member=YES && ose_level_id='CERTIFIED && TODAY > 12/31/2023
Result: NATA_MEMBER ($89)
*/
else if nvl(v_collection_type, 'N') = 'AT_MAINTAIN_APP'
and nvl(v_member_check, 'NO') = 'YES'
and nvl(v_ose_level_id, 'N') = 'CERTIFIED' 
AND SYSDATE() > '12/31/2023' then wkfcfglib.setqualifiervalue (
  p_wkf_serno = > :wkf_serno,
  p_qualifier_id = > 'PRICE_CD',
  p_qualifier_value = > 'NATA_MEMBER_OS_LATE'
);
commit;

/* Case 5
Condition: collection=AT_MAINTAIN_APP && member=NO
Result: NATA_MEMBER ($55)
*/
if nvl(v_collection_type, 'N') = 'AT_MAINTAIN_APP'
and nvl(v_member_check, 'NO') = 'NO' 
and nvl(v_ose_level_id, 'N') = 'N' then wkfcfglib.setqualifiervalue (
  p_wkf_serno = > :wkf_serno,
  p_qualifier_id = > 'PRICE_CD',
  p_qualifier_value = > 'NATA_NOM'
);
commit;

/* Case 6
Condition: collection=AT_MAINTAIN_APP && member=NO && TODAY > 12/31/2023
Result: NATA_MEMBER ($75)
*/
else if nvl(v_collection_type, 'N') = 'AT_MAINTAIN_APP'
and nvl(v_member_check, 'NO') = 'NO' 
and nvl(v_ose_level_id, 'N') = 'N' 
AND SYSDATE() > '12/31/2023' then wkfcfglib.setqualifiervalue (
  p_wkf_serno = > :wkf_serno,
  p_qualifier_id = > 'PRICE_CD',
  p_qualifier_value = > 'NATA_NOM_LATE'
);
commit;

/* Case 7
Condition: collection=AT_MAINTAIN_APP && member=NO && ose_level_id='CERTIFIED
Result: NATA_MEMBER ($86)
*/
else if nvl(v_collection_type, 'N') = 'AT_MAINTAIN_APP'
and nvl(v_member_check, 'NO') = 'NO'
and nvl(v_ose_level_id, 'N') = 'CERTIFIED' then wkfcfglib.setqualifiervalue (
  p_wkf_serno = > :wkf_serno,
  p_qualifier_id = > 'PRICE_CD',
  p_qualifier_value = > 'NATA_NOM_OS'
);
commit;

/* Case 8
Condition: collection=AT_MAINTAIN_APP && member=NO && ose_level_id='CERTIFIED && TODAY > 12/31/2023
Result: NATA_MEMBER ($89)
*/
else if nvl(v_collection_type, 'N') = 'AT_MAINTAIN_APP'
and nvl(v_member_check, 'NO') = 'NO'
and nvl(v_ose_level_id, 'N') = 'CERTIFIED' 
AND SYSDATE() > '12/31/2023' then wkfcfglib.setqualifiervalue (
  p_wkf_serno = > :wkf_serno,
  p_qualifier_id = > 'PRICE_CD',
  p_qualifier_value = > 'NATA_NOM_OS_LATE'
);
commit;

-- else wkfcfglib.setqualifiervalue (
--   p_wkf_serno = > :wkf_serno,
--   p_qualifier_id = > 'PRICE_CD',
--   p_qualifier_value = > 'NATA_NOM'
-- );

-- commit;

end if;

end;