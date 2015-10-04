accounts = {
  reload: function(account_id) {
    task_id = $('[data-account_id="'+account_id+'"]').data("task_id");
    $('[data-task_id="'+task_id+'"][data-account_id="'+account_id+'"]').load('/task/'+task_id+'/account/'+account_id);
  },
}
