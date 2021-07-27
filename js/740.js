$(document).ajaxComplete(function () {
  $("[id^=COL10_]").text("Documentation");

  if ($( ".t-Region-title:contains('ECC Documentation')" ).length > 0) {
    $("[id^=COL17_]").text("Issue Date");
    $("[id^=COL18_]").text("Expiration Date");
  } else {
    $("[id^=COL18_]").text("Completion Date");
    $("[id^=COL19_]").text("CEUs");
  }

  var page_link = $(".aaActive").first()
  if (page_link.length == 1) {
    var page_title = $(".aaActive").first().children().text()
    $("#aaCENTransactionReportsRegion_heading").text(page_title)
  }
});
