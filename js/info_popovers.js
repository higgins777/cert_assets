function popover_content(content) {
  return '<a tabindex="0" class="btn btn-lg btn-danger" role="button" data-bs-toggle="popover" data-bs-trigger="focus" title="Dismissible popover" data-bs-content=" ' + content + ' ">Dismissible popover</a>'
}

$(document).ready(function() {

  var myProfile = $("#aaSTDDashboardStoredDoc_heading")
  myProfile.append(popover_content("Info about My Profile"))
  new bootstrap.Popover(myProfile.get(0), {html:true})

  var todo = $("#aaSTDCustomRegion_heading")
  todo.append(popover_content("Info about To Do"))
  new bootstrap.Popover(todo.get(0), {html: true})

  var upcoming = $("#aaSTDCustomRegionThree_heading")
  upcoming.append(popover_content("Info about Upcoming Tasks"))
  new bootstrap.Popover(upcoming.get(0), {html: true})

  var messages = $("#aaSTDDashboardDynamicOverview2_heading")
  messages.append(popover_content("Info about My Messages"))
  new bootstrap.Popover(messages.get(0), {html: true})

  var announcements = $("#aaSTDDashboardDynamicOverview3_heading")
  announcements.append(popover_content("Info about Announcements"))
  new bootstrap.Popover(announcements.get(0), {html: true})

})