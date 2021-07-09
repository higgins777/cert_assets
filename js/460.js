$(document).ready(function(){
  redirect_primary_aps();
  $('.tooltipped').tooltip();
  $('select').formSelect();
  add_dashboard_class();
});

function add_dashboard_class() {
  var dashboard_id = $("#DASHBOARD-ID").text()
  if (dashboard_id == 'AT-DASHBOARD') {
    $("#section-header").addClass("at-dashboard-container")
  } else {
    $("#section-header").addClass("ap-dashboard-container")
  }
}

function redirect_primary_aps() {
  var redirect_element = $("#redirect-to-ap")
  if (redirect_element.length > 0) {
    destination = "https://cert.bocatc.org/bocdevssa/ssaapexmnucall?p_app_id=STDSSA&p_page_id=1000&p_clearcache=1000&p_itemnames=P1000_DASHBOARD_CD&p_itemvalues=BOCAPDASH&p_cust_id=" + redirect_element.text()
    window.location.replace(destination);
  }
}
