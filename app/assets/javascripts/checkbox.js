var down = false;
var value = false;

var labels = $('.available_at')
  .find('.check_box label')
  .mousedown(function (event) {
    event.preventDefault();
    down = true;
    var $input = $('#' + $(this).attr('for'));
    value = $input.attr('checked') === undefined;
      $input.attr('checked', value).prop('checked', value);
  })
  .mouseover(function (event) {
    event.preventDefault();
    var $input = $('#' + $(this).attr('for'));
    if (down) {
      $input.attr('checked', value).prop('checked', value);
    }
  })
  .change(function (event) { event.preventDefault(); })
  .click(function (event) { event.preventDefault(); })
  .each(function(index, label) {
    var $input = $('#' + $(this).attr('for'));
    value = $input.attr('checked') !== undefined;
    $input.attr('checked', value).prop('checked', value);
  });

$(document).mouseup(function () {
  down = false;
});
