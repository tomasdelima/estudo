# $(document).ready ->
#   $(".mp").click (event) ->
#     url =
#       "plus": "/plus_quantity"
#       "minus": "/minus_quantity"

#     id = $(event.currentTarget).data('id')
#     price = $(event.currentTarget).data('price')
#     operation = $(event.currentTarget).data('operation')
#     $.ajax
#       url: url[operation]
#       data: {id: id}
#       success: (result) ->
#         $("#div"+id).html result
#         $("#subtotal-"+id).html Math.round(price * result).toFixed(2)
#         s = 0
#         i = 1
#         while i < $(".mp").length/2 + 1
#           s = s + parseFloat($("#subtotal-"+i).html())
#           i++
#         $("#total").html s.toFixed(2)
#         $("#sum").html( parseFloat($("#sum").html()) + {'minus': -1, 'plus': 1}[operation])
