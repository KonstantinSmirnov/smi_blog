jQuery ($) ->
  hasChanges = false
  $(document).on "turbolinks:load", ->
    hasChanges = false
    $("input, select, textarea").on "change", ->
      hasChanges = true
    $("#add_comment").on "click", ->
      hasChanges = false
      console.log("Form has changes: " + hasChanges)
  $(document).on 'turbolinks:before-visit', ->
    if (hasChanges)
      confirm 'You have unsaved changes in a form. Are you sure to leave this page?'
