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
        link: 'http://smiplay.com/articles/57dbe102d042ac7d7b73b7ab'
        picture: image
        caption: 'This is the caption'
        description: 'Description field'
