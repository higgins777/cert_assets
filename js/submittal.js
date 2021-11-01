
function addCreatedToSubmittalTable() {
  if ($("#submittal_created_dates").size() > 0) {
    $("th.aaSbmNumber").parent().children().eq(4).after("<th>Created Date</th>")
    var pairs = $("#submittal_created_dates").text().split("::")
    var id_date_map = {}

    for (i = 0; i < pairs.length; i++) {
      var split = pairs[i].split("--")
      id_date_map[split[0]] = split[1]
    }

    $("td.aaSbmNumber").each(function( index ) {
      var date_str = "<td>" + id_date_map[$(this).text()] + "</td>"
      $(this).parent().children().eq(4).after( date_str)
    });
  }
}