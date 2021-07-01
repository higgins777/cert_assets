$(document).ready(function(){
  $('.tooltipped').tooltip();
  $('select').formSelect();
  create_menu()
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