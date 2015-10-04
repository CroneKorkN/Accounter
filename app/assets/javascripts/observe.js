function sortAccounts() {
  $('accounts > account').sortElements(function(a, b){
    return $(a).data("order") > $(b).data("order") ? 1 : -1;
  });
}

function sortRecords() {
  $('records > record').sortElements(function(a, b){
    return $(a).data("order") > $(b).data("order") ? 1 : -1;
  });
}

function patcher(patch) {
  var account_template = Handlebars.compile($("#account-template").html());
  var record_template = Handlebars.compile($("#record-template").html());

  switch(patch.type) {
    case "Account":
      switch (patch.method) {
        case "create":
          $("accounts").append(account_template(patch.data));
          $("[data-account_id="+patch.id+"] [data-editable]").editable();
          sortAccounts();
          console.log(patch.user.name+" created account "+patch.id);
          return;
        case "update":
          $("[data-account_id="+patch.id+"]").replaceWith(account_template(patch.data));
          $("[data-account_id="+patch.id+"] [data-editable]").editable();
          console.log(patch.user.name+" updated account "+patch.id);
          return;
        case "delete":
          $("[data-account_id="+patch.id+"]").remove();
          console.log(patch.user.name+" deleted account "+patch.id);
          return;
      }
    case "Record":
      switch (patch.method) {
        case "create":
          $("records").append(record_template(patch.data));
          $("#record_"+patch.id).record();
          sortRecords();
          console.log(patch.user.name+" created record "+patch.id);
          return;
        case "update":
          $("#record_"+patch.id).replaceWith(record_template(patch.data));
          $("#record_"+patch.id).record();
          console.log(patch.user.name+" updated record "+patch.id);
          return;
        case "delete":
          $("#record_"+patch.id).remove();
          console.log(patch.user.name+" deleted account "+patch.id);
          return;
    }
  }
}

$( document ).ajaxError(function( event, jqxhr, settings, thrownError ) {
  console.log(thrownError);
});

function observe() {
  if (!$("accounts").length && !$("records").length) {return;}
  setTimeout(function(){
    $.ajax({
      type: "GET",
      url: "/observe.json",
      dataType: 'json',
    }).done(function(response) {
      for (patch of response) {
        patcher(patch);
      }
      observe();
    });
  }, 2000);
}
