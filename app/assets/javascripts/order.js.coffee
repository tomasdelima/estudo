# $(document).ready ->
#   $("#change").click ->
#     id = $('#change').data("id");
#     $.ajax
#       url:     "/#{id}/change_status",
#       error:   (jqXHR, textStatus, errorThrown) -> alert(errorThrown)
#       success: (result) ->
#         $('#status').html result['order_status']
#         $("#change").remove() unless result['visible'] is true
#         $("#change").text "Change to '"+result['next_order_status']+"'"
