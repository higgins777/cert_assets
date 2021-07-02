select sum (tx.credit_pts_requested)
from cen_cust_tx tx, 
    cen_cust_tx_context cd,
    crt_cust_period crt
where tx.tx_serno = cd.tx_serno
    and tx.category_cd = 'CAT_A'
    and crt.cust_id = tx.cust_id
    and cd.context_cd = 'CRT'
    and cd.qualifier_cd = crtapplib.get_preferred_period ( :p_cust_id,
                                           'ATHLETIC_TRAINER',
                                           'ATHLETIC_TRAINER')

select sum (tx.credit_pts_requested)
from cen_cust_tx tx, 
    cen_cust_tx_context cd,
    crt_cust_period crt
where tx.tx_serno = cd.tx_serno
    and tx.category_cd = 'CAT_B'
    and crt.cust_id = tx.cust_id
    and cd.context_cd = 'CRT'
    and cd.qualifier_cd = crtapplib.get_preferred_period ( :p_cust_id,
                                           'ATHLETIC_TRAINER',
                                           'ATHLETIC_TRAINER')

select sum (tx.credit_pts_requested)
from cen_cust_tx tx, 
    cen_cust_tx_context cd,
    crt_cust_period crt
where tx.tx_serno = cd.tx_serno
    and tx.category_cd = 'CAT_C'
    and crt.cust_id = tx.cust_id
    and cd.context_cd = 'CRT'
    and cd.qualifier_cd = crtapplib.get_preferred_period ( :p_cust_id,
                                           'ATHLETIC_TRAINER',
                                           'ATHLETIC_TRAINER')

select sum (tx.credit_pts_requested)
from cen_cust_tx tx, 
    cen_cust_tx_context cd,
    crt_cust_period crt
where tx.tx_serno = cd.tx_serno
    and tx.category_cd = 'CAT_D'
    and crt.cust_id = tx.cust_id
    and cd.context_cd = 'CRT'
    and cd.qualifier_cd = crtapplib.get_preferred_period ( :p_cust_id,
                                           'ATHLETIC_TRAINER',
                                           'ATHLETIC_TRAINER')

select sum (tx.credit_pts_requested)
from cen_cust_tx tx, 
    cen_cust_tx_context cd,
    crt_cust_period crt
where tx.tx_serno = cd.tx_serno
    and tx.category_cd = 'EBP'
    and crt.cust_id = tx.cust_id
    and cd.context_cd = 'CRT'
    and cd.qualifier_cd = crtapplib.get_preferred_period ( :p_cust_id,
                                           'ATHLETIC_TRAINER',
                                           'ATHLETIC_TRAINER')