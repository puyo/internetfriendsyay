import $ from "jquery"

const form = $('#new_user')
$('select', form).change(function(event) {
  form.submit()
});
