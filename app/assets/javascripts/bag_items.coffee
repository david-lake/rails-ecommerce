# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@quantity =
  incrementValue: (e) ->
    fieldName = $(e.target).data('field');
    parent = $(e.target).closest('div');
    input = "input[name='" + fieldName + "']"
    currentVal = parseInt(parent.find(input).val(), 10);
    if !isNaN(currentVal)
      parent.find(input).val(currentVal + 1);
    else
      parent.find(input).val(1);
  decrementValue: (e) ->
    fieldName = $(e.target).data('field');
    parent = $(e.target).closest('div');
    input = "input[name='" + fieldName + "']"
    currentVal = parseInt(parent.find(input).val(), 10);
    if !isNaN(currentVal) && currentVal > 1
      parent.find(input).val(currentVal - 1);
    else
      parent.find(input).val(1);
