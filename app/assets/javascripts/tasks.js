tasks = function() {
  $('[data-add-task]').click(function(){
    console.log('klick');
    $.ajax({
      type: "POST",
      url: "/tasks",
      context: this,
    }).done(function(response) {
      console.log(response);
      console.log(this);
      $(this).parent().before("<li>"+response+"</li>")
    });
  });
  
  $("[data-delete-task]").click(function(){
    if (!window.confirm("Wirklich löschen?")) {return;}
    var task_id = $(this).data("task-id");
    $(this).parent().remove();
    $.ajax({
      type: "DELETE",
      contentType: "application/json; charset=utf-8",
      dataType: 'json',
      url: "/tasks/" + task_id,
    });
  });
}