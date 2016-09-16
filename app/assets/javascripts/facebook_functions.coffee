jQuery ($) ->
  $(document).on "turbolinks:load", ->
    
    @share_facebook = (link, title, image, caption) ->
      FB.ui
        method      : 'feed'
#        link        : link
#        title       : title
#        image       : image
#       caption     : caption
        name: 'This is the name field'
        link: 'http://smiplay.com/articles/57dbe102d042ac7d7b73b7ab'
        picture: 'http://smiplay.com/system/images/images/original/5.png?1474027785'
        caption: 'This is the caption'
        description: 'Description field'
