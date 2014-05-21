// $(document).ready(function() {
//   return $(".mp").click(function(event) {
//     url = {
//       "plus": "/plus_quantity",
//       "minus": "/minus_quantity"
//     };
//     id = $(event.currentTarget).data('id');
//     price = $(event.currentTarget).data('price');
//     operation = $(event.currentTarget).data('operation');
//     return $.ajax({
//       url: url[operation],
//       data: {
//         id: id
//       },
//       success: function(result) {
//         $("#div" + id).html(result);
//         $("#subtotal-" + id).html((price * result).toFixed(2));
//         total = 0;
//         subtotals = $(".subtotal")
//         for  (index = 0; index < subtotals.length; ++index) {
//           total = (parseFloat(total) + parseFloat(subtotals[index].textContent)).toFixed(2)
//         }
//         $("#total").html(total);
//         return $("#sum").html(parseFloat($("#sum").html()) + {'minus': -1,'plus': 1}[operation]);
//       }
//     });
//   });
// });
