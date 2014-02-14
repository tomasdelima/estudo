# $(document).ready ->
#   $("#AddTag").click (event) ->
#     name = $("#TagName").val()
#     product_id = $("h1").attr('id')

#     $.ajax
#       url:  "/new_tag"
#       type: "POST"
#       data:
#         name: name
#         product_id: product_id

#       success: (data) ->
#         url = "<a href=\"#{data.url}\">#{name}</a>";
#         $("#Tags").html "#{$("#Tags").html()} #{url}" if data.status is 'tagged'
