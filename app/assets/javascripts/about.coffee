jQuery ($) ->
  $(document).on "turbolinks:load", ->
    code1 = () ->
      $(".element0 .type").typed(
        strings: ["These are the default values...",
                  "You know what you should do?",
                  "Use your own!",
                  "Have a great day!"],
        typeSpeed: 10,
        backDelay: 500,
        loop: false,
        loopCount: 0,
        )
    setTimeout(code1, 1000)