var modal = {
  initialize: function(){
    $("[data-remote=true]").unbind("click").click(function(){
      if (this.skip == true) {
        this.skip = false;
        console.log("skip");
        return false;
      }
      console.log("go");
      modal.load($(this).attr("href")||$(this).attr("data-href"));
      return false;
    });
        
    $("#modal .modal-header button.close").unbind("click").click(function(e){
      modal.close();
    });
    
    //$("#modal").unbind("click").click(function(e){
    //  if( $(e.target).parents('#modal').length == 0 ) {
    //    modal.close();
    //  }
    //});
  },
  load: function(url){
    $.get(url, function(data, status){
      modal.show(data);
    });
  },
  show: function(content){
    $("#modal .modal-body").html(content);
    $("#modal .modal-title").html(
      $("#modal .modal-body").find("h2")[0] || "Dialog"
    );
    // app();
    $("html").addClass('modal');
  },
  close: function(){
    $("html").removeClass('modal');
  },
  skip: false,
}
