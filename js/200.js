$(document).ready(function(){
  create_menu()
  update_login_placeholder()
  addCreatedToSubmittalTable()
  expand_school_codes();
  
  replaceElementsStr('table', 'Certification Maintenance Fee (Renewal)', ' January   01, 2020', ' December 31, 2021')
  replaceElementsStr('table', 'Certification Maintenance Fee (Renewal)', ' January   01, 2021', ' December 31, 2021')
  
  replaceElementsStr('table', 'Certification Maintenance Fee (Renewal)', '01/01/2020', '12/31/2021')
  replaceElementsStr('table', 'Certification Maintenance Fee (Renewal)', '01/01/2021', '12/31/2021')
  
  replaceElementsStr('td', 'BOCATC - Certified', '12/31/2021-12/31/2020', '1/1/2020-12/31/2020')
  replaceElementsStr('td', 'BOCATC - Certified', '12/31/2021-12/31/2021', '1/1/2021-12/31/2021')
  // changeCeFormDates();
});


$(document).ajaxComplete(function () {
  apAnnualReportHideText()
  // expand_school_codes();
});

function apAnnualReportHideText() {
  
  if ($("#ap-initial-app-awaiting-pymnt").size() > 0) {
    $("#ap-annual-report-paid").addClass('hide-it')
  }
}

// Takes a serialized string of "id1--date1::id2--date2::..." into a map.
// Iterate over HTML table and insert the date into each IDs corresponding row.
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

// add Start is equal or greater than 12/31/2021
// BOC389915 - would like to show 6/8/2021 instead of 1/1/2022 if possible
function changeCeFormDates() {
  // isPending = $("#aaSbmHeaderSubmittalStatus").text() == '\nStatus: Pending\n\n'
  // isFiftyDue = $("#P2529_DUE_DISPLAY").text() == 'Total CEUs Due: 50'
  // reportingPeriod = $("#P2529_PERIOD_DISPLAY")
  // dateEndsCorrectly = reportingPeriod.text().includes("12/31/2023")
  // startDate = reportingPeriod.text().split(" - ")[0]
  // startDateCorrectly = (startDate.includes("2022") || startDate.includes("2023") || startDate.includes("12/31/2021"))

  // if (isPending && isFiftyDue && dateEndsCorrectly && startDateCorrectly) {
  //   reportingPeriod.html("Reporting Period: 1/1/2022 - 12/31/2023");
  // }
}

function expand_school_codes() {
  $("[headers^=C6906227190725890]").each(function() {
    var t1 = $(this).text().replace("-B", "-B (Bachelor's)");
    t1 = t1.replace("-M", "-M (Master's)");
    $(this).text(t1);
  })

  $("[headers^=C7266359656361870]").each(function() {
    var t1 = $(this).text().replace("-B", "-B (Bachelor's)");
    t1 = t1.replace("-M", "-M (Master's)");
    $(this).text(t1);
  })
}

function update_login_placeholder() {
  var input = $("#P101_USERNAME")
  if (input.length > 0) {
    input.attr("placeholder", "Username (typically your email)");
  }
}

// Searches for a containerType that has the mustHaveStr AND the targetStr, and then replaces all targetStr occurrences with newStr
// Two selectors must be used as the target the lowest level shared container. Selecting based off one criteria could yield two separate tables, instead of their shared parent.
// Strings should always be copied from the element inspector, as the rendered string does not match the DOM's (see January   01 with 3 spaces)
function replaceElementsStr(containerType, mustHaveStr, targetStr, newStr) {
  ele = $(containerType + ":contains('" + mustHaveStr + "'):contains('" + targetStr + "')").last()
  if (ele.length > 0) {
    $(ele).html(ele.html().replace(targetStr, newStr))
  } 
}

function create_menu() {
  var menu_nav = $("#BOCMenuNavLinks")

  // Select all the menu elements (<li>) and split them in half
  var menu_items = $("#BOCMenuNavLinks li")
  var top_ul = $("#BOCMenuNavLinks ul").first()
  
  const half = Math.ceil(menu_items.length / 2);
  const firstHalf = menu_items.slice(0, half)
  const secondHalf = menu_items.slice(-half)

  if (firstHalf.length > 0) {
    top_ul.html("<div id='boc-menu-col0' class='boc-menu-col'></div><div id='boc-menu-col1' class='boc-menu-col'></div>")
    $("#boc-menu-col0").html(firstHalf);
    $("#boc-menu-col1").html(secondHalf);
  }

}

