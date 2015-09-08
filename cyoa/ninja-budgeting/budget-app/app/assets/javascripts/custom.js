function validateAddMoneyForm() {
  var totalAmount = $('#add-money-total-amount-input').val()
  var otherAmounts = 0.00;
  $("#add-money-fund-options input[type=number]").each(function() {
    if (this.value != "") {
      otherAmounts = parseFloat(otherAmounts) + parseFloat(this.value);
    }
  });
  if (parseFloat(totalAmount).toFixed(2) == 0.00) {
    alert("The total amount must be greater than 0.");
    return false;
  }
  if (parseFloat(otherAmounts).toFixed(2) == 0.00) {
    alert("You must put the money in at least one fund!");
    return false;
  }
  if (parseFloat(totalAmount).toFixed(2) == parseFloat(otherAmounts).toFixed(2)) {
    return true;
  } else {
    alert("The sum of the fund amounts must equal the total amount.");
    return false;
  }
  return false;
}

$(document).on("click", "#new-fund-reserve-button", function() {
  var fundID = $(this).data('id');
  var amount = $(this).data('amount');
  $('[name="fund_id"]').val(fundID);
  $('[name="amount"]').attr("placeholder", "Available: " + amount);
});

$(document).on("click", "#new-money-button", function() {
  var fundID = $(this).data('id');
  var fundName = $(this).data('name');
  $('[name="fund_id"]').val(fundID);
  $('#newMoneyModal h4').text("Add Money to " + fundName);
  $('#new-money-form').get(0).setAttribute('action', '/funds/add/' + fundID);
});

$(document).on("click", "#edit-fund-button", function() {
  var fundID = $(this).data('id');
  var name = $(this).data('name');
  var amount = $(this).data('amount');
  $('#edit-fund-form').get(0).setAttribute('action', '/funds/'+fundID);
  $('[name="name"]').val(name);
  $('[name="amount"]').val(amount);
});

$(document).on("click", "#delete-fund-button", function() {
  var fundID = $(this).data('id');
  $('#delete-fund-form').get(0).setAttribute('action', '/funds/'+fundID);
});

$(document).on("click", "#delete-term-button", function() {
  var termID = $(this).data('id');
  $('#delete-term-form').get(0).setAttribute('action', '/terms/'+termID);
});

$(document).on("click", "#edit-category-button", function() {
  var categoryID = $(this).data('id');
  var categoryName = $(this).data('name');
  $('#edit-category-form').get(0).setAttribute('action', '/categories/'+categoryID);
  $('[name="name"]').val(categoryName);
});

$(document).on("click", "#delete-category-button", function() {
  var categoryID = $(this).data('id');
  $('#delete-category-form').get(0).setAttribute('action', '/categories/'+categoryID);
});

$(document).on("click", "#new-category-component-button", function() {
  var fundID = $(this).data('id');
  var fundName = $(this).data('name');
  $('[name="fund_id"]').val(fundID);
  $('#newCategoryComponentModal h4').text('New Subcategory for ' + fundName);
});

$(document).on("click", '.expandable-category-row', function() {
  $(this).nextUntil('tr.expandable-category-row').slideToggle(0);
  var glyph = $(this).find('i.expandable');
  if (glyph.hasClass('glyphicon-triangle-bottom')) {
    glyph.removeClass('glyphicon-triangle-bottom');
    glyph.addClass('glyphicon-triangle-top');
  } else {
    glyph.removeClass('glyphicon-triangle-top');
    glyph.addClass('glyphicon-triangle-bottom');
  }  
});

$(document).on("click", "#add-money-to-term-category-link", function() {
  var categoryName = $(this).data('name');
  $('#add-money-to-term-category-form').get(0).setAttribute('action', '/terms/add-money-to-category/'+categoryName);
  $('#addMoneyTermCategoryModal h4').text('Add Money to ' + categoryName);
});