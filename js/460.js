$(document).ready(function(){
  $('.tooltipped').tooltip();
  $('select').formSelect();
  add_dashboard_class();
});

function add_dashboard_class() {
  var uri = window.location.href;
  if (uri.includes('BOCATDASH')) {
    $("#section-header").addClass("at-dashboard-container")
  } else if (uri.includes('BOCAPDASH')) {
    $("#section-header").addClass("ap-dashboard-container")
  }
}
