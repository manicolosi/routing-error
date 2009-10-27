$(function() {
  $(".vote-button").click( function() {
    direction = "up";
    if($(this).hasClass("vote-down")) {
      direction = "down";
    }
    var parent = $(this).parent().parent();
    var voteable_id = /vote-(\d+)/(parent.attr("id"))[1]

    var voteable_type = "question";
    if(parent.parent().hasClass("answer")) {
      voteable_type = "answer";
    }

    if ($(this).hasClass("voted")) {
      console.log("already voted for");
    } else {
      $.post("/votes", {
          direction: direction,
          voteable_id: voteable_id,
          voteable_type: voteable_type
        },
        function() {
        }
      );
    }
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
