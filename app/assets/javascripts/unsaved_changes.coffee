jQuery ($) ->
  hasChanges = false
  $(document).on "turbolinks:load", ->
    hasChanges = false
    $("input").on "change", ->
      hasChanges = true
  $(document).on 'turbolinks:before-visit', ->
    if (hasChanges)
      confirm 'You have unsaved changes in a form. Are you sure to leave this page?'
