$(document).ready(function() {
  return $("#change").click(function() {
    var id;
    id = $('#change').data("id");
    return $.ajax({
      url: "/" + id + "/change_status",
      error: function(jqXHR, textStatus, errorThrown) {
        return alert(errorThrown);
      },
      success: function(result) {
        $('#status').html(result['order_status']);
        if (result['visible'] !== true) {
          $("#change").remove();
        }
        return $("#change").text("Change to '" + result['next_order_status'] + "'");
      }
    });
  });
});
