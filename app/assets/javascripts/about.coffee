jQuery ($) ->
  $(document).on "turbolinks:load", ->
    code1 = () ->
      $(".element1 .type").typed(
        strings: ["hello"],
        typeSpeed: 10,
        backDelay: 500,
        loop: false,
        loopCount: 0,
        )
    code2 = () ->
      $(".element2 .type").typed(
        strings: ["How are you?"],
        typeSpeed: 10,
        backDelay: 500,
        loop: false,
        loopCount: 0,
        )
    code3 = () ->
      $(".element3 .type").typed(
        strings: ["Welcome here!"],
        typeSpeed: 10,
        backDelay: 500,
        loop: false,
        loopCount: 0,
        )
    show_element_2 = ->
      $(".element2").show()
    show_element_3 = ->
      $(".element3").show()

    setTimeout(code1, 1000)
    setTimeout(show_element_2, 2000)
    setTimeout(code2, 3000)
    setTimeout(show_element_3, 4000)
    setTimeout(code3, 5000)
