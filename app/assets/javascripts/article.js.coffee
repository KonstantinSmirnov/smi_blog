# ARTICLES
# add <img> class .img-fluid (bootstrap4) to make them response

$(document).on 'turbolinks:load', ->
  $('.blog-article img').addClass('img-fluid');
