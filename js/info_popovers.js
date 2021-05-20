function popover_content(id, title, content) {
  return '<a tabindex="0" id="' +id+'" style="margin-left: 5px; font-size: 2.2rem; cursor: hover" role="button" data-bs-toggle="popover" data-bs-trigger="focus" title="'+title+'" data-bs-content=" ' + content + ' "><i class="bi bi-info-circle"></i></a>'
}

function add_dashboard_popovers() {
  var popover_id = "my-profile-info"
  var myProfile = $("#aaSTDDashboardStoredDoc_heading")
  myProfile.append(popover_content(popover_id, "My Profile", "Info Stuff"))
  new bootstrap.Popover(document.getElementById(popover_id), {html:true})

  var todo = $("#aaSTDCustomRegion_heading")
  popover_id = "todo-info"
  todo.append(popover_content(popover_id, "My To Do List	", "Info Stuff"))
  new bootstrap.Popover(document.getElementById(popover_id), {html:true})

  var upcoming = $("#aaSTDCustomRegionThree_heading")
  popover_id = 'my-upcoming-tasks-info'
  upcoming.append(popover_content(popover_id, "My Upcoming Tasks	", "Info Stuff"))
  new bootstrap.Popover(document.getElementById(popover_id), {html:true})

  var messages = $("#aaSTDDashboardDynamicOverview2_heading")
  popover_id = 'my-messages-info'
  messages.append(popover_content(popover_id, "My Messages", "Info Stuff"))
  new bootstrap.Popover(document.getElementById(popover_id), {html:true})

  var announcements = $("#aaSTDDashboardDynamicOverview3_heading")
  popover_id = 'announcements-info'
  announcements.append(popover_content(popover_id, "Announcements", "Info Stuff"))
  new bootstrap.Popover(document.getElementById(popover_id), {html:true})
}

$(document).ajaxComplete(function() {
  if ($("#todo-info").length == 0) {
      add_dashboard_popovers()
  }
});