jQuery ($) ->
  $(document).on "turbolinks:load", ->
    
    @share_facebook = (href) ->
      FB.ui
        method  : 'feed'
        link    : href
        caption : 'An example caption'
