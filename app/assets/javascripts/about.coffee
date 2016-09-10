jQuery ($) ->
  $(document).on "turbolinks:load", ->
    code1 = () ->
      $(".element1 .type").typed(
        strings: ["Hello!",
                  "Let me open this page.",
                  "open -a Smiplay projects/blog/about/show.html.erb"
                  ],
        typeSpeed: 5,
        backDelay: 500,
        loop: false,
        loopCount: 0,
        )

    show_element_2 = ->
      $(".element2").show()
    remove_blog_about_code = ->
      $(".blog-about-code").slideUp()
    show_section_about = ->
      $(".section-about").fadeIn()

    setTimeout(code1, 1000)
    setTimeout(remove_blog_about_code, 8000)
    setTimeout(show_section_about, 9000)
