function drawTripod(ctx, centerX, centerY, bgnR, endR) {
  var cos30 = Math.cos(33 * Math.PI / 180.0);
  var sin30 = Math.sin(33 * Math.PI / 180.0);

  ctx.beginPath();
  ctx.moveTo(centerX, centerY - bgnR);
  ctx.lineTo(centerX, centerY - endR);

  ctx.moveTo(centerX - bgnR * cos30, centerY + bgnR * sin30);
  ctx.lineTo(centerX - endR * cos30, centerY + endR * sin30);

  ctx.moveTo(centerX + bgnR * cos30, centerY + bgnR * sin30);
  ctx.lineTo(centerX + endR * cos30, centerY + endR * sin30);
  ctx.stroke();
}

function drawHomeBackground() {
  var canvas = document.getElementById("home-menu-canvas");
  var ctx = canvas.getContext("2d");

  canvas.width = 500;
  canvas.height = 500;

  ctx.globalAlpha = 0.4;
  ctx.strokeStyle = "#000077";
  ctx.lineCap = "round";

  ctx.lineWidth = 20;
  drawTripod(ctx, 247, 303, 75, 160);
}

var timer;
var lastImageIndex = 0;

$('#search').keyup(function () {
});

function drawRandomUserShowing() {
  population = $( ".image-sample" );
  $( ".random-image" )
    .fadeOut(function() {
      $( this ).remove();
    });

  // No Longer On User Home
  if ($( ".on-user-home" ).length == 0) {
    clearTimeout(timer);
    return;
  }

  var n = population.length;
  if (n == 0) {
    return;
  }

  lastImageIndex = (lastImageIndex + 1) % n;
  var sample = population[lastImageIndex];
  var image = $( sample ).data("image");
  var description = $( sample ).data("description");

  var d = document.createElement('div');
  $(d).addClass("random-image");

  var imageDiv = document.createElement('div');
  $(imageDiv).addClass("random-image-picture")
    .html('<img src="' + image + '"/>');

  var captionDiv = document.createElement('div');
  $(captionDiv).addClass("random-image-caption")
    .html(description);
  
  d.appendChild(imageDiv);
  d.appendChild(captionDiv);
  $(d).appendTo($( "#user-event-showings" ))
    .hide()
    .fadeIn();
  
    clearTimeout(timer);
    timer = setTimeout( function() {
    drawRandomUserShowing();
    }, 5000);
}

function setUpScrapeHandler() {
  $( ".scrape" ).click( function() {
    if ($( ".big-notice" ).length == 0) {
      var d = document.createElement('div');
      $(d).addClass("big-notice")
        .html("<p>Please Wait...</p>")
        .appendTo(document.body)
        .show();
      
    }
  });
}

window.onbeforeunload = function (e) {
  clearTimeout(timer);
};
