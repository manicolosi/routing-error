jQuery.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader("Accept", "text/javascript")
  }
});

$(document).ready(function() {
  $(".vote_form").ajaxForm({ dataType: "script" });
});
