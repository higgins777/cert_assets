declare 

cursor c_legacy is
select 
  attribute_cd
from 
  cen_cust_attrdtl
where
  attribute_ty = 'AT_EXAM_LEGACY_RESULTS'
  AND cust_id = :cust_id;

cursor c_collection is
select
  collection_id
from
  sbm_submittal
where
  submittal_serno = :submittal_serno;

cursor c_exam_result is
select
  result_cd
from
  (
    select
      *
    from
      cen_cust_tx
    where
      category_cd = 'EXAM_SCANTRON'
      and level1 = 'BOC_AT'
      and cust_id = :cust_id
    order by
      create_dt desc
  )
where
  rownum = 1;

cursor c_exam_fail_exists is
select
  'Y'
from
  dual
where
  exists (
    select
      *
    from
      cen_cust_tx
    where
      category_cd = 'EXAM_SCANTRON'
      and cust_id = :cust_id
      and level1 = 'BOC_AT'
      and result_cd in ('F', 'FAIL')
  );

cursor c_athletic_trainer is
select
  primary_cust_id
from
  sbm_submittal
where
  submittal_serno = :submittal_serno;

v_collection sbm_submittal.collection_id % type;
v_exam_result cen_cust_tx.result_cd % type;
v_exam_fail_exists varchar(1);
v_athletic_trainer sbm_submittal.primary_cust_id % type;
v_alert_serno INTEGER;
v_legacy cen_cust_attrdtl.attribute_cd % type;

begin
open c_legacy;
fetch c_legacy into v_legacy;
close c_legacy;

open c_collection;
fetch c_collection into v_collection;
close c_collection;

open c_exam_result;
fetch c_exam_result into v_exam_result;
close c_exam_result;
open c_exam_fail_exists;
fetch c_exam_fail_exists into v_exam_fail_exists;
close c_exam_fail_exists;
open c_athletic_trainer;
fetch c_athletic_trainer into v_athletic_trainer;
close c_athletic_trainer;

if nvl(v_legacy, 'N') = 'YES'
then sbmattrlib.insupd_sbm_attrdtl(
  P_SUBMITTAL_SERNO => :submittal_serno,
  P_ATTRIBUTE_TY => 'AT_EXAM_ATTEMPT',
  P_NEW_ATTRCODE => 'RETAKE'
);
elsif nvl(v_collection, 'N') = 'AT_INITIAL_EXAM'
and nvl(v_exam_result, 'NO_SHOW') = 'NO_SHOW'
and nvl(v_exam_fail_exists, 'N') = 'N' then sbmattrlib.insupd_sbm_attrdtl(
  P_SUBMITTAL_SERNO => :submittal_serno,
  P_ATTRIBUTE_TY => 'AT_EXAM_ATTEMPT',
  P_NEW_ATTRCODE => 'FIRST_ATTEMPT'
);
elsif nvl(v_collection, 'N') = 'AT_INITIAL_EXAM'
and nvl(v_exam_fail_exists, 'N') = 'Y' then sbmattrlib.insupd_sbm_attrdtl(
  p_submittal_serno => :submittal_serno,
  p_attribute_ty => 'AT_EXAM_ATTEMPT',
  p_new_attrcode => 'RETAKE'
);
elsif nvl(v_collection, 'N') = 'AT_REINSTATE_EXAM' then sbmattrlib.insupd_sbm_attrdtl(
  P_SUBMITTAL_SERNO => :submittal_serno,
  P_ATTRIBUTE_TY => 'AT_EXAM_ATTEMPT',
  P_NEW_ATTRCODE => 'RETAKE'
);
end if;
insert into
  sbm_submittal_attrdtl (
    submittal_serno,
    attribute_ty,
    attribute_cd,
    nvar,
    create_dt,
    create_by
  )
values
  (
    :submittal_serno,
    'AT_EXAM_AUTH_COUNT',
    'AT_EXAM_AUTH_COUNT',
    '1',
    (sysdate),
    'AT_EXAM_ATTEMPT_TYPE'
  );
commit;
EXCEPTION
WHEN OTHERS THEN v_alert_serno := stdalertlib.save_alert(
  'DEBUGGING',
  'WKF ACTION AT_INIT_SCANTRON_COPY_SBM_CEN',
  sqlerrm || chr(10) || dbms_utility.format_error_stack || chr(10) || dbms_utility.format_error_backtrace
);
end;