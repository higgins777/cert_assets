select '<hr><a href="ssaapexmnucall?p_app_id=BETASSA&p_page_id=53015&p_itemnames=P53015_PROVIDER_ID&p_itemvalues=' || bocdashboardlib.get_provider(:cust_id) || '" title="View All Programs">View All Programs</a>
  <a href="sbmssamysubmittals.wizstep3?p_collection_id=PROGRAM&p_subcollection_cd=PROGRAM&p_cust_id=' || :cust_id || '&p_parent_cust_id=' || bocdashboardlib.get_provider(:cust_id) || '" title="Add New Program">Add New Program</a>'
from dual