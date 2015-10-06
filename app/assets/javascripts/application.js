//= require jquery
//= require jquery_ujs
//= require jquery-ui/sortable
//= require jquery-ui/selectable
//= require best_in_place
// require turbolinks
//= require touchpunch
//= require editable
//= require_tree .

var app = function() {
  console.log("initialize");

  $("accounts [data-editable]").editable();
  $("h1 [data-editable]").editable();
  $("account_templates [data-editable]").editable();
  $(":not(records) .best_in_place").best_in_place();
  $("records").records();

  accounts_sortable();
  modal.initialize();
  observe();
  header();
  tasks();

  $('#test').typing({
      start: function (event, $elem) {
          $elem.css('background', '#fa0');
      },
      stop: function (event, $elem) {
          $elem.css('background', '#fff');
      },
      delay: 600
  });
}

$(document).ready(app);
