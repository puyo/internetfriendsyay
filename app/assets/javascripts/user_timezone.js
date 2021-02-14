var form = $('#new_user')
$('select', form).change(function(event) {
  form.submit();
});
