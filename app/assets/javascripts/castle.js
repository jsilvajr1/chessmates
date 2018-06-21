$(function() {

  $(".draggable").draggable({
    containment: '.chessboard',
    cursor: 'move',
    drag: function(event,ui){
      debugger;
    }
  });

  $(".droppable").droppable({
    drop: function(event,ui){
      var x = $(this).data("x");
      var y = $(this).data("y");
      var pieceId = ui.draggable.data("piece");
      var url = ui.draggable[0].baseURI + "/pieces/" + pieceId;
      var token = $('meta[name="csrf-token"]').attr('content');
      var piece_target = event.target;

      ui.draggable.position( {
        my: "center",
        at: "center",
        of: piece_target
      });

      $.ajax({
        url: url,
        async: false, // considered bad practice, but couldn't figure out any other way :(
        type: 'PUT',
        headers: { 'X-CSRF-Token': token },
        data: { piece: { id: pieceId, location_x: x, location_y: y } },
        error: function(jqXHR, textStatus, errorMsg){
          var errorData = JSON.parse(jqXHR.responseText);
          $("#piece_" + errorData.id).addClass("revertPiece");
        }
      });
    }
  });
});

