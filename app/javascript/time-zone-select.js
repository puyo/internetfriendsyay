import $ from "jquery";

$(function() {
  const form = $('#new_user')
  $('select', form).change(function(event) {
    form.submit();
  });
})
