jQuery ($) ->
  $(document).on "turbolinks:load", ->
    
    @share_facebook = (link, title, image, caption) ->
      FB.ui
        method      : 'feed'
        link        : link
        name        : title
#        description : description
        picture     : image
        caption     : caption
