declare 
cursor c_member_check is
  select attribute_cd
  from cen_cust_attrdtl
  where cust_id = :cust_id
  and attribute_ty = 'NATA_MEMBER';
cursor c_collection_type is
  select collection_id
  from sbm_submittal
  where submittal_serno = :submittal_serno;
cursor c_school_code_cn01 is 
  SELECT employer_id
  FROM cen_cust_emp
  WHERE employee_id = :cust_id
  AND function_cd='STUDENT'
  AND employer_id='CN01';
cursor c_school_code_ir01 is 
  SELECT employer_id
  FROM cen_cust_emp
  WHERE employee_id = :cust_id
  AND function_cd='STUDENT'
  AND employer_id='IR01';

v_member_check cen_cust_attrdtl.attribute_cd%type;
v_collection_type sbm_submittal.collection_id%type;
v_school_code_cn01 cen_cust_emp.employer_id%type;
v_school_code_ir01 cen_cust_emp.employer_id%type;

begin 
open c_member_check;
fetch c_member_check into v_member_check;
close c_member_check;
open c_collection_type;
fetch c_collection_type into v_collection_type;
close c_collection_type;

if nvl(v_collection_type, 'N') = 'AT_INITIAL_APP'
  and nvl(v_member_check,'NO') = 'YES'
  then wkfcfglib.setqualifiervalue ( p_wkf_serno => :wkf_serno,
  p_qualifier_id => 'PRICE_CD',
  p_qualifier_value => 'ICD_APPLICANT');
  commit;
elsif nvl(v_school_code_cn01, 'N') = 'CN01'
  then wkfcfglib.setqualifiervalue ( p_wkf_serno => :wkf_serno,
  p_qualifier_id => 'PRICE_CD',
  p_qualifier_value => 'ICD_APPLICANT');
  commit;
elsif nvl(v_school_code_cn01, 'N') = 'IR01'
  then wkfcfglib.setqualifiervalue ( p_wkf_serno => :wkf_serno,
  p_qualifier_id => 'PRICE_CD',
  p_qualifier_value => 'ICD_APPLICANT');
  commit;
else wkfcfglib.setqualifiervalue
  ( p_wkf_serno => :wkf_serno, p_qualifier_id => 'PRICE_CD', p_qualifier_value => 'NATA_NOM');
  commit;
  end if;
end;