select '<div class="progress" style="height: 20px">
  <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
</div>'||SUM (centxlib.allowable_points (tx.tx_serno, 'N', cd.context_cd, cd.qualifier_cd))
  FROM cen_cust_tx tx, cen_cust_tx_context cd
  WHERE tx.tx_serno = cd.tx_serno
  AND tx.category_cd = 'CAT_C'
  AND cd.context_cd = 'CRT'
  AND cd.qualifier_cd = crtapplib.get_preferred_period (:cust_id,'ATHLETIC_TRAINER','ATHLETIC_TRAINER')


select '<div class="progress" style="height: 20px">
  <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
</div>'||sum (tx.credit_pts_requested)
from cen_cust_tx tx, 
    cen_cust_tx_context cd,
    crt_cust_period crt
where tx.tx_serno = cd.tx_serno
    and tx.category_cd = 'CAT_C'
    and crt.cust_id = tx.cust_id
    and cd.context_cd = 'CRT'
    and cd.qualifier_cd = crtapplib.get_preferred_period (:cust_id,
                                           'ATHLETIC_TRAINER',
                                           'ATHLETIC_TRAINER')