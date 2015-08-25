$(function () {
  var created_tooltips = [];
  var cardname_selector = ".show-card-tooltip";

  function getCardId (elem) {
    return ($(elem).parent(".card-in-deck").data("card-id")
         || $(elem).parents(".card").data("card-id"));
  }

  $(document).on("mouseover", cardname_selector, function (event) {
    var elem = this;
    if (created_tooltips.indexOf(elem) !== -1) return;
    created_tooltips.push(elem);

    var card_id = getCardId(elem);
    $.get("/cards/" + card_id + "/tooltip", {id: card_id}, function (content) {
      createTooltip(elem, content);
    }, "html");
  });

  function createTooltip (elem, content) {
    Tipped.create(elem,
      function (element) {
        return {
          content: content
        };
      },
      {
        showDelay: 500,
        position: "topleft"
      }
    );
    $(elem).mouseover();
  }
});
