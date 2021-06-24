function create_menu() {
  $("#BOCMenuNav").attr( {
    'class' : 'dropdown', 
  });

  $("#BOCActions").attr({ 'class' : 'dropdown' })

  // Create container with two 3 rows
  menu_items = $("#BOCMenuNavLinks").children().children().children()
  menu_sets = new Array(Math.ceil(menu_items.length / 6)).fill().map(_ => menu_items.splice(0, 6));

  var col0, col1, col2; //apsonis (ACGI) variables were not instantiated

  if (menu_sets.length > 0) { //apsonis (ACGI) added this since pages were not loading when array is undefined
    col0 = menu_sets[0].map(function(v){return v.outerHTML}).join('');
    console.log(col0)
    col1 = menu_sets[1].map(function(v){return v.outerHTML}).join('');
    col2 = menu_sets[2].map(function(v){return v.outerHTML}).join('');

    dropdown_button = '<button class="btn btn-secondary dropdown-toggle" type="button" id="boc-dropdown-menu" data-bs-toggle="dropdown" aria-expanded="false"><i class="material-icons" id="BOCMenuNavIcon">menu</i><span id="BOCMenuNavIconLabel">Menu</span></button>';

    dropdown_content = '<ul class="dropdown-menu" aria-labelledby="boc-dropdown-menu"><li><div class="container"><div class="row"><div id="boc-menu-col0" class="boc-menu-col col-md-4 col-sm-6"></div><div id="boc-menu-col1" class="boc-menu-col col-md-4 col-sm-6"></div><div id="boc-menu-col2" class=" boc-menu-col col-md-4 col-sm-6"></div></div></div></li></ul>';


    $("#BOCMenuNav").html(dropdown_button + dropdown_content);
    $("#boc-menu-col0").html(col0);
    $("#boc-menu-col1").html(col1);
    $("#boc-menu-col2").html(col2);
  }
}

$(function () {
  create_menu()
});