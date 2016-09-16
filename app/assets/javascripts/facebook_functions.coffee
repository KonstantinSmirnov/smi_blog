jQuery ($) ->
  $(document).on "turbolinks:load", ->
    
    @share_facebook = (link, title, image, caption) ->
      FB.ui
        method      : 'feed'
#        link        : link
#        title       : title
#        image       : image
#       caption     : caption
        name: title
        link: link
        picture: image
        caption: caption
        description: 'Description field'
