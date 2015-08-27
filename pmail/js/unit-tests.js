QUnit.module("Table");
QUnit.test("maybeTrue returns true or false", function (assert) {
  var results = _.times(100, maybeTrue)
  assert.ok(_.includes(results, true), "Successfully returned at least one true.");
  assert.ok(_.includes(results, false), "Successfully returned at least one false.");
});

QUnit.test("maybeUnread returns 'class=\"unread\"', or an empty string", function (assert) {
  var results = _.times(100, maybeUnread);
  assert.ok(_.includes(results, 'class="unread"'), "Successfully returned at least one 'class=\"unread\"'.");
  assert.ok(_.includes(results, ''), "Successfully returned at least one empty string.");
});

QUnit.test("maybeStarred returns html for an image with class being either 'starred' or 'star'", function (assert) {
  var results = _.times(100, maybeStarred);
  var all_results_are_images = _.every(results, function (result) {
    return _.includes(result, '<img ') && _.includes(result, '/>');
  });
  var contains_starred_class = _.find(results, function (result) {
    return _.includes(result, 'class="starred"');
  });
  var contains_star_class = _.find(results, function (result) {
    return _.includes(result, 'class="star"');
  });
  assert.ok(all_results_are_images, "Successfully returned image tags.");
  assert.ok(contains_starred_class, "Successfully returned at least one 'class=\"starred\"'.");
  assert.ok(contains_star_class, "Successfully returned at least one 'class=\"star\"'.");
});

QUnit.test("createTable returns html for a table with n_rows", function (assert) {
  var n_rows = 25;
  var table_html = createTable(n_rows);
  var returns_table = _.includes(table_html, "<table>") && _.includes(table_html, "</table>");
  assert.ok(returns_table, "Successfully returned a table.")
  assert.equal(table_html.match(/<tr /g || []).length, n_rows, "Successfully returned correct number of rows");
});

QUnit.module("Gmail actions");
QUnit.test("unstar removes 'starred' class and adds 'star' class", function (assert) {
  var test_elem = document.createElement("DIV");
  test_elem.className = "starred";
  unstar(test_elem);
  assert.notOk($(test_elem).hasClass("starred"), "Successfully removed 'starred' class.");
  assert.ok($(test_elem).hasClass("star"), "Successfully added 'star' class.");
});

QUnit.test("unstar does nothing if the element already has the appropriate classes", function (assert) {
  var test_elem = document.createElement("DIV");
  test_elem.className = "star";
  unstar(test_elem);
  assert.notOk($(test_elem).hasClass("starred"), "Successfully avoided adding 'starred' class.");
  assert.ok($(test_elem).hasClass("star"), "Successfully kept 'star' class.");
});

QUnit.test("star removes 'star' class and adds 'starred' class", function (assert) {
  var test_elem = document.createElement("DIV");
  test_elem.className = "star";
  star(test_elem);
  assert.notOk($(test_elem).hasClass("star"), "Successfully removed 'star' class.");
  assert.ok($(test_elem).hasClass("starred"), "Successfully added 'starred' class.");
});

QUnit.test("star does nothing if the element already has the appropriate classes", function (assert) {
  var test_elem = document.createElement("DIV");
  test_elem.className = "starred";
  star(test_elem);
  assert.notOk($(test_elem).hasClass("star"), "Successfully avoided adding 'star' class.");
  assert.ok($(test_elem).hasClass("starred"), "Successfully kept 'starred' class.");
});

QUnit.test("toggleStarred calls unstar if the element is starred", function (assert) {
  var test_elem = document.createElement("DIV");
  test_elem.className = "starred";
  toggleStarred(test_elem);
  assert.notOk($(test_elem).hasClass("starred"), "Successfully avoided calling star().");
  assert.ok($(test_elem).hasClass("star"), "Successfully called unstar().");
});

QUnit.test("toggleStarred calls star if the element is not starred", function (assert) {
  var test_elem = document.createElement("DIV");
  test_elem.className = "star";
  toggleStarred(test_elem);
  assert.notOk($(test_elem).hasClass("star"), "Successfully avoided calling unstar().");
  assert.ok($(test_elem).hasClass("starred"), "Successfully called star().");
});

QUnit.test("getNextSelectedEmailIndex returns 1 if no email is currently selected", function (assert) {
  $('tr').removeClass('selected');
  assert.equal(getNextSelectedEmailIndex(), 1, "Successfully returned 1 when no email was selected.");
});

QUnit.test("getNextSelectedEmailIndex returns current email index - 1 if go_up is true", function (assert) {
  var go_up = true;
  var current_index = 3;
  $('tr').removeClass('selected');
  $($('tr')[current_index - 1]).addClass('selected');
  assert.equal(getNextSelectedEmailIndex(go_up), current_index - 1, "Successfully returned current email index - 1 when go_up was true.");
  $('tr').removeClass('selected');
});

QUnit.test("getNextSelectedEmailIndex returns current email index + 1 if go_up is false", function (assert) {
  var go_up = false;
  var current_index = 3;
  $('tr').removeClass('selected');
  $($('tr')[current_index - 1]).addClass('selected');
  assert.equal(getNextSelectedEmailIndex(go_up), current_index + 1, "Successfully returned current email index + 1 when go_up was false.");
  $('tr').removeClass('selected');
});

QUnit.test("selectEmail selects the first email if no email is currently selected", function (assert) {
  selectEmail();
  var selected_email = _.find($('tr'), function (row) { return $(row).hasClass('selected') });
  var selected_email_index = $('tr').index(selected_email);
  assert.equal(selected_email_index, 0, "Successfully selected first email.");
  $('tr').removeClass('selected');
});

QUnit.test("selectEmail selects the email above the currently selected email if go_up is true", function (assert) {
  var go_up = true;
  var current_index = 2;
  $('tr').removeClass('selected');
  $($('tr')[current_index]).addClass('selected');
  selectEmail(go_up);
  var selected_email = _.find($('tr'), function (row) { return $(row).hasClass('selected') });
  var selected_email_index = $('tr').index(selected_email);
  assert.equal(selected_email_index, current_index - 1, "Successfully selected email above currently selected email.");
  $('tr').removeClass('selected');
});

QUnit.test("selectEmail selects the email below the currently selected email if go_up is false", function (assert) {
  var go_up = false;
  var current_index = 2;
  $('tr').removeClass('selected');
  $($('tr')[current_index]).addClass('selected');
  selectEmail(go_up);
  var selected_email = _.find($('tr'), function (row) { return $(row).hasClass('selected') });
  var selected_email_index = $('tr').index(selected_email);
  assert.equal(selected_email_index, current_index + 1, "Successfully selected email below currently selected email.");
  $('tr').removeClass('selected');
});
