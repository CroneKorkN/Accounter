//
// records
//

$.fn.records = function() {
  this.sortable({
    handle: "order",
    delay: 150,
    update: function (event, ui) {
      modal.skip = true;
      var data = $("records").sortable('serialize');

      $.ajax({
          data: data,
          type: 'POST',
          url: '/records/sort'
      });

      // refresh numbers inline
      $("records > record").each(function(i){
        $(this).find("order").html(i+1);
      });
    }
  });

  $("[data-add_record]").click(function(){
    var task_id = $(this).data("task_id");

    $.ajax({
      type: "POST",
      url: "/tasks/"+task_id+"/records/",
      context: this,
      contentType: "application/json; charset=utf-8",
      dataType: 'html',
      data: '{"record": {"task_id": "'+task_id+'"}}',
    });
  });

  $("[data-unselect]").click(function() {
    $(".ui-selected").removeClass("ui-selected");
  });

  this.find("record").record();
};

//
// record
//

$.fn.record = function() {
  this.click(function() {
    $(this).siblings()
           .removeClass("ui-selected");
    $(this).addClass("ui-selected");
  });

  this.find("[data-remove_record]").click(function(){
    var record_id = $(this).data("record_id");
    $(this).parent()
           .parent()
           .remove();

    $.ajax({
      type: "DELETE",
      contentType: "application/json; charset=utf-8",
      dataType: 'json',
      url: "/records/"+record_id,
    });
  });

  this.find("[data-record_add_entry]").click(function(){
    var record_id = $(this).data("record_id");
    var debit_not_credit = $(this).data("debit_not_credit");

    $.ajax({
      type: "POST",
      url: "/records/"+record_id+"/entries",
      context: this,
      contentType: "application/json; charset=utf-8",
      dataType: 'html',
      data: '{"entry":{"record_id":"'+record_id+'","debit_not_credit":"'+debit_not_credit+'"}}',
    }).done(function(response) {
      $(this).parent()
             .parent()
             .append(response)
             .children()
             .last()
             .entry();
    });
  });

  this.find("entry")
      .entry();
}

//
// record entry
//

$.fn.entry = function() {
  this.find("[data-entry_remove]").click(function(){
    var entry_id = $(this).data("entry_id");
    $(this).parent()
           .parent()
           .remove();

    $.ajax({
      type: "DELETE",
      contentType: "application/json; charset=utf-8",
      dataType: 'json',
      url: "/entries/"+entry_id,
    });
  });

  this.find(".best_in_place").best_in_place();
  this.find("[data-editable]").editable();
}
