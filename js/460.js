$(document).ready(function(){
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
