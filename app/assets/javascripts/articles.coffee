jQuery ($) ->
  $(document).on "turbolinks:load ajaxComplete", ->
    $(".blog-article img").addClass("img-fluid")
    $("table").addClass("m-x-auto")
    $("img").addClass("m-x-auto")

    $("#add_comment").prop "disabled", true
    $("#message_counter").html("enter at least 10 characters")
    $("#new_comment_text").on "input", ->
      if $(@).val().length > 0
        if $(@).val().length < 10
          $("#message_counter").css("color":"red")
          $("#message_counter").html(10 - $(@).val().length).append(" more to go")
        else
          $("#message_counter").css("color":"black")
          $("#message_counter").html(140 - $(@).val().length).append(" characters left")
        $("#add_comment").prop "disabled", false
      else
        $("#add_comment").prop "disabled", true
        $("#message_counter").css("color":"black")
        $("#message_counter").html("enter at least 10 characters")
    $(".delete_article_tag").on "click", (event) ->
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('.form-group').hide()
      event.preventDefault()
