$(document).ready(function(){
  create_menu()
  replaceElementsStr('table', 'Certification Maintenance Fee (Renewal)', ' January   01, 2020', ' December 31, 2021')
  replaceElementsStr('table', 'Certification Maintenance Fee (Renewal)', '01/01/2020', '12/31/2021')
});

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


// Searches for a containerType that has the mustHaveStr, and then replaces all targetStr with newStr
// YOU MUST USE TWO SELECTORS TO FIND THE LOWEST ELEMENT CONTAINING BOTH THE mustHaveStr and targetStr
function replaceElementsStr(containerType, mustHaveStr, targetStr, newStr) {
  ele = $(containerType + ":contains('" + mustHaveStr + "'):contains('" + targetStr + "')").last()
  if (ele.length > 0) {
    $(ele).html(ele.html().replace(targetStr, newStr))
  } 
}