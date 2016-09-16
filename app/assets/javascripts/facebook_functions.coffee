jQuery ($) ->
  $(document).on "turbolinks:load", ->
    
    @share_facebook = (link) ->
      FB.ui
        method      : 'feed'
        link        : link
