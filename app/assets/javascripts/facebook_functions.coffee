jQuery ($) ->
  $(document).on "turbolinks:load", ->
    
    @share_facebook = (link, title, description, image, caption) ->
      FB.ui
        method      : 'feed'
        link        : link
        title       : title
        description : description
        image       : image
        caption     : caption

