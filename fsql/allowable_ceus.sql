SELECT SUM (centxlib.allowable_points (tx.tx_serno,
                                       'N',
                                       cd.context_cd,
                                       cd.qualifier_cd))
  FROM cen_cust_tx tx, cen_cust_tx_context cd
 WHERE     tx.tx_serno = cd.tx_serno
       AND tx.category_cd = 'CAT_A'
       AND cd.context_cd = 'CRT'
       AND cd.qualifier_cd =
           crtapplib.get_preferred_period ( :p_cust_id,
                                           'ATHLETIC_TRAINER',
                                           'ATHLETIC_TRAINER')

SELECT SUM (centxlib.allowable_points (tx.tx_serno,
                                       'N',
                                       cd.context_cd,
                                       cd.qualifier_cd))
  FROM cen_cust_tx tx, cen_cust_tx_context cd
 WHERE     tx.tx_serno = cd.tx_serno
       AND tx.category_cd = 'CAT_B'
       AND cd.context_cd = 'CRT'
       AND cd.qualifier_cd =
           crtapplib.get_preferred_period ( :p_cust_id,
                                           'ATHLETIC_TRAINER',
                                           'ATHLETIC_TRAINER')

SELECT SUM (centxlib.allowable_points (tx.tx_serno,
                                       'N',
                                       cd.context_cd,
                                       cd.qualifier_cd))
  FROM cen_cust_tx tx, cen_cust_tx_context cd
 WHERE     tx.tx_serno = cd.tx_serno
       AND tx.category_cd = 'CAT_C'
       AND cd.context_cd = 'CRT'
       AND cd.qualifier_cd =
           crtapplib.get_preferred_period ( :p_cust_id,
                                           'ATHLETIC_TRAINER',
                                           'ATHLETIC_TRAINER')

SELECT SUM (centxlib.allowable_points (tx.tx_serno,
                                       'N',
                                       cd.context_cd,
                                       cd.qualifier_cd))
  FROM cen_cust_tx tx, cen_cust_tx_context cd
 WHERE     tx.tx_serno = cd.tx_serno
       AND tx.category_cd = 'CAT_D'
       AND cd.context_cd = 'CRT'
       AND cd.qualifier_cd =
           crtapplib.get_preferred_period ( :p_cust_id,
                                           'ATHLETIC_TRAINER',
                                           'ATHLETIC_TRAINER')


SELECT SUM (centxlib.allowable_points (tx.tx_serno,
                                       'N',
                                       cd.context_cd,
                                       cd.qualifier_cd))
  FROM cen_cust_tx tx, cen_cust_tx_context cd
 WHERE     tx.tx_serno = cd.tx_serno
       AND tx.category_cd = 'EBP'
       AND cd.context_cd = 'CRT'
       AND cd.qualifier_cd =
           crtapplib.get_preferred_period ( :p_cust_id,
                                           'ATHLETIC_TRAINER',
                                           'ATHLETIC_TRAINER')