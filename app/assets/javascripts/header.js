header = function() {
  $('app-header .menu').click(function(){
    if ($(this).attr('data-menu-expanded') == 1) {
      $(this).attr('data-menu-expanded', 0);
    } else {
      $(this).attr('data-menu-expanded', 1);
    }
  });
}