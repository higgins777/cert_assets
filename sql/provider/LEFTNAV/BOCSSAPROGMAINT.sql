select '<a class="upcoming-program-link" href="ssaapexmnucall?p_app_id=BETASSA&p_page_id=53020&p_itemnames=P53020_PROGRAM_ID&p_itemvalues=' || o.program_id ||'" title="Program Details">' || program_nm || '  ' || o.start_dt || '<i class="material-icons upcoming-program-icon">keyboard_arrow_right</i></a>'
from boc_vw_offering o
where o.provider_id = bocdashboardlib.get_provider(:cust_id)
and trunc(o.start_dt) >= trunc(sysdate)
order by o.start_dt
fetch first 3 rows only