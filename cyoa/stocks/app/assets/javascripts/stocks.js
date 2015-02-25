function goToStock(stockSym) {
  window.location.href = "/stocks/" + stockSym;
};

function toggleWatchlist(stockSym) {
  $.post("/watchlist/" + stockSym);
  var id = stockSym + "-icon";
  $('#' + id).toggleClass('fa-star fa-star-o');
};

function addStockToWatchlistIndex(stockSym) {
  $.post("/watchlist/" + stockSym);
  var id = stockSym + "-icon";
  $('#' + id).toggleClass('fa-star fa-star-o');
};

function toggleWatchlistText() {
  var element = document.getElementById("watchlist");
  if (element.textContent == "Add To Watchlist")
    element.textContent = "Remove From Watchlist";
  else
    element.textContent = "Add To Watchlist";
};

var ready = function() {
  $('#filter').keyup(function () {

      var rex = new RegExp($(this).val(), 'i');
      $('.searchable tr').hide();
      $('.searchable tr').filter(function () {
          return rex.test($(this).text());
      }).show();

  })
};

$(document).ready(ready);
$(document).on('page:load', ready);