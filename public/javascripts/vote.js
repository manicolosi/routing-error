function get_direction(element) {
}

$(function() {
  $(".vote-button").click( function() {
  });

  $(".vote-button").hover(
    function() {
      if($(this).hasClass("vote-up")) {
        if ($(this).hasClass("voted")) {
          $(this).attr("src", "/images/vote-up.png");
        } else {
          $(this).attr("src", "/images/voted-up.png");
        }
      } else {
        if ($(this).hasClass("voted")) {
          $(this).attr("src", "/images/vote-down.png");
        } else {
          $(this).attr("src", "/images/voted-down.png");
        }
      }
    },
    function() {
      if($(this).hasClass("vote-up")) {
        if ($(this).hasClass("voted")) {
          $(this).attr("src", "/images/voted-up.png");
        } else {
          $(this).attr("src", "/images/vote-up.png");
        }
      } else {
        if ($(this).hasClass("voted")) {
          $(this).attr("src", "/images/voted-down.png");
        } else {
          $(this).attr("src", "/images/vote-down.png");
        }
      }
    }
  );
});
