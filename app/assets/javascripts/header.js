header = function() {
  $('app-header .menu').click(function(e){
    if($(e.target).is('menu-frame, menu-frame *:not(a)')){
      e.preventDefault();
      return;
    }
    if ($(this).attr('data-menu-expanded') == 1) {
      $(this).attr('data-menu-expanded', 0);
    } else {
      $('[data-menu-expanded="1"]').attr('data-menu-expanded', 0);
      $(this).attr('data-menu-expanded', 1);
    }
  });
}