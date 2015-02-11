// When clicking the mustached overlord image
$(function() {
  $("#overlord").on('click', function() {
    window.location = '/boot_device';
  });
});

$(function() {
  $("#cake").on('click', function() {
    $.ajax({
      url: "/destroy_bomb",
      method: "POST"
    }).done(function (response) {
      window.location = '/';
    });
  });
});

// Add function to setup FlipClock

$(document).ready(function() {
  var clock;

  clock = $("#pendulum").FlipClock({
        clockFace: "MinuteCounter",
        autoStart: false,
        callbacks: {
          stop: function() {
            $.ajax({
              url: "/detonate_bomb",
              method: "POST"
            }).done(function (response) {
              window.location = "/detonated_bomb";
            });
          }
        }
    });

    clock.setTime(30);
    clock.setCountdown(true);
    clock.start();
});
