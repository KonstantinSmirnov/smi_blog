jQuery ($) ->
  $(document).on "turbolinks:load", ->

    @share_linkedin = (url, title, summary, source) ->
      linkedin_url = 'https://www.linkedin.com/shareArticle?mini=true'
      window.open linkedin_url + url + title + summary + source, 'Share at LinkedIn', "height=400,width=550"
