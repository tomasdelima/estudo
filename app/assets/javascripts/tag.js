$(document).ready(function() {
  return $("#AddTag").click(function(event) {
    // var name, product_id;
    name = $("#TagName").val();
    product_id = $("h1").attr('id');
    return $.ajax({
      url: "/new_tag",
      type: "POST",
      data: {
        name: name,
        product_id: product_id
      },
      success: function(data) {
        // var url;
        a=data
        if (data.status === 'tagged') {
          return $("#Tags").html(($("#Tags").html()) + '<form action="'+data.url+'" class="button_to" method="get"><div><input class="tags" type="submit" value="'+name+'">');
        }
      }
    });
  });
});
