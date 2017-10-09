window.queezebuilder = window.queezebuilder or {}
((shared, $) ->

  shared.init_flash = (message) ->
    if message.length == 0
      $("#flash").hide()
    else
      $("#flash").fadeIn("slow")
      setTimeout (->
        $("#flash").fadeOut("slow")
        return
      ), 4000

  endless_scroll = ->
    url = $(".pagination .next a").attr("href")
    if url && $(window).scrollTop() > $(document).height() - $(window).height() - 150
      $(".page-loader").show()
      $.getScript url
      $(window).off "scroll", endless_scroll

  shared.init_endless_scroll = ->
    $(".pagination").hide()
    $(".page-loader").hide()
    $(window).off "scroll"
    $(window).on "scroll", endless_scroll

) window.queezebuilder.shared = window.queezebuilder.shared or {}, jQuery
