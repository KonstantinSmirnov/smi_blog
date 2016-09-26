jQuery ($) ->
  hasChanges = false
  $(document).on "turbolinks:load", ->
    hasChanges = false
    #$(".submit_button").attr("disabled", true)
    $("input, select, textarea").on "change", ->
      hasChanges = true
      #$(".submit_button").attr("disabled", false)
  $(document).on 'turbolinks:before-visit', ->
    if (hasChanges)
      confirm 'You have unsaved changes in a form. Are you sure to leave this page?'
