# ARTICLES
# add <img> class .img-fluid (bootstrap4) to make them response

$(document).on 'ready turbolinks:load', ->
  $('.blog-article img').addClass('img-fluid');
