function accounts_sortable() {
  $("account-templates").sortable({
    handle: "order",
    delay: 150,
    update: function (event, ui) {
      var data = $("account-templates").sortable('serialize');

      // POST to server using $.post or $.ajax
      $.ajax({
          data: data,
          type: 'POST',
          url: '/accounts/sort'
      });
    }
  });

  $("accounts").sortable({
    handle: "header",
    cancel: ".opening_balance",
    delay: 150,
    update: function (event, ui) {
      var data = $("accounts").sortable('serialize');

      // POST to server using $.post or $.ajax
      $.ajax({
          data: data,
          type: 'POST',
          url: '/accounts/sort'
      });
    }
  });
}
