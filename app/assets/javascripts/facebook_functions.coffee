jQuery ($) ->
  $(document).on "turbolinks:load", ->
    
    @share_facebook = (caption, link, image, title, description) ->
      FB.ui
        method      : 'feed'
        link        : link
        caption     : caption
        image       : image
        title       : title
        description : description
