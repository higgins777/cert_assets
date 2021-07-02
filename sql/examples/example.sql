select '<li>' || i.product_descr || '   ' ||
       decode(i.product_area, 
       'EC',htf.anchor( 'ecssashop.show_product_detail?' ||
                   'p_mode=detail&p_product_serno=' ||
                   i.product_cd || 
                   '&p_cust_id=' || :cust_id,
                   'Purchase'),
              null)
from mkt_cust_interest c, mkt_cfg_product_i0nterest i
where c.cust_id = :cust_id
and c.interest_cd = i.interest_cd
and (i.product_dt > sysdate or i.product_area <> 'EVT')
and not exists (select 'x' from mkt_cust_activity a
                 where a.cust_id = c.cust_id
                 and   a.area_cd = i.product_area
                 and   a.product_cd = i.product_cd
               )
and rownum <= 10