$(document).ready(function(){
  $('#user_timezone').change(function(){ $(this).parents('form').submit(); });
  $('#user_submit').hide();
});
