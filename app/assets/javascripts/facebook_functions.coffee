jQuery ($) ->
  $(document).on "turbolinks:load", ->
    
    @share_facebook = (href, image_link) ->
      FB.ui
        method  : 'feed'
        link    : href
        caption : 'SMIPLAY.COM'
        image   : image_link
