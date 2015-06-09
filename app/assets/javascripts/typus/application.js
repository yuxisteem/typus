//= require typus/jquery-2.1.1.min
//= require jquery_ujs
//= require typus/jquery.application
//= require chosen.jquery.js
//= require typus/custom

$(document).on('click', '.ajax-modal', function() {
  var url = $(this).attr('url');
  var modal_id = $(this).attr('data-controls-modal');
  $("#" + modal_id + " .modal-body").load(url);
});
