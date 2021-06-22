    // commenting out to fix multiselect issues with bootstrap in SSA -AM (ACGI)
    $("#BOCMenuNav").attr( {'type': 'button', 'data-bs-container' : 'body', 'data-bs-toggle' : 'popover', 'data-bs-placement' : 'bottom'} )

    // Initialize Popover
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
      return new bootstrap.Popover(popoverTriggerEl, {html: true})
    })

    // Create container with two 3 rows
    menu_items = $("#BOCMenuNavLinks").children().children().children()
    menu_sets = new Array(Math.ceil(menu_items.length / 6)).fill().map(_ => menu_items.splice(0, 6));

    var col0, col1, col2; //apsonis (ACGI) variables were not instantiated

    if (menu_sets.length > 0) { //apsonis (ACGI) added this since pages were not loading when array is undefined
        col0 = menu_sets[0].map(function(v){return v.outerHTML}).join('');
        col1 = menu_sets[1].map(function(v){return v.outerHTML}).join('');
        col2 = menu_sets[2].map(function(v){return v.outerHTML}).join('');
    }

    $("#BOCMenuNavLinks").remove()

    content_structure2 = '<div class="container"><div id="boc-popmenu-row" class="row"><div id="boc-popmenu1" class="col-md-4 col-sm-6">' + col0 + '</div><div id="boc-popmenu2" class="col-md-4 col-sm-6">' + col1 + '</div><div id="boc-popmenu3" class="col-md-4 col-sm-6">' + col2 + '</div></div></div>'

    $("#BOCMenuNav").attr('data-bs-content', content_structure2)