$(document).ready(function() {
    $("#boot-bomb").click(function() {
        var a_code = $('input[name=a_code]').val();
        var d_code = $('input[name=d_code]').val();
        var code = "activation=" + a_code + "&deactivation=" + d_code;
        $.ajax({
            type: "POST",
            url: '/boot',
            data: code,
        }).success(function(data) {
            $.get('/boot', function(boot) {
                if (boot == "true") {
                    $(".status-booted").show('slide');
                }
            });
            $(".status-notbooted").hide('slide');
            $("#input-deactivate").hide('slide', function() {
                $("#input-activate").hide('slide', function() {
                    $(".bomb-activated").show('slide');
                    $("#boot-bomb").replaceWith($("#submit-bomb"));
                });
            });
            activateBomb(code);
        }).done();
        return false;
    });

    function activateBomb(code) {
        $("#submit-bomb").click(code, function() {
            var code_converted = code.split('&');
            var a_code = code_converted[0].split('=')[1];
            var d_code = code_converted[1].split('=')[1];
            var activate = $('input[name=activate]').val();
            console.log(activate);
            $.ajax({
                type: "POST",
                url: '/activate',
                data: {
                    a_code, activate, d_code, code
                },
            }).success(function(data) {
                $.get('/activate', function(activate_status) {
                    $("#activate-bomb").hide('slide', function() {
                        $("#submit-bomb").hide('slide', function() {
                            if (activate_status == "true") {
                                $(".bomb-deactivated").show('slide');
                                $("#countdown").show('slide').delay(20000).hide('slide', function() {
                                    var status =  $(".status-exploded").show('slide');
                                    bombStatus(status);
                                });
                                $(".status-booted").hide('slide');
                                $(".status-activated").show('slide');
                            } else {
                                $("#activate-bomb").show('slide');
                                $("#submit-bomb").show('slide');
                                activateBomb(code);
                            }
                        });
                    });
                });
                deactivateBomb(0);
            }).done();
            return false;
        });
    }

    function deactivateBomb(numberOftries) {
        $("#try-bomb").click(function() {
            var deactivate = $('input[name=deactivate]').val();
            $.ajax({
                type: "POST",
                url: '/deactivate',
                data: {deactivate},
            }).success(function(data) {
                $.get('/deactivate', function(deactivate_status) {
                    deact_status = deactivate_status.split("&")[0];
                    exploded_status = deactivate_status.split("&")[1];
                    count = "Tries: " + deactivate_status.split("&")[2];
                    $(".count").html(count);
                    if (deact_status == "true" && exploded_status == "false") {
                        var status = $(".status-deactivated").show('slide');
                        bombStatus(status);
                    } else if (deact_status == "false" && exploded_status == "true") {
                        var status =  $(".status-exploded").show('slide');
                        bombStatus(status);
                    } else {
                        deactivateBomb(numberOftries);
                    }
                });
            }).done();
            return false;
        });
    }

    function bombStatus(status) {
        $(".status-activated").hide('slide');
        $(".bomb-activated").hide('slide');
        $(".bomb-deactivated").hide('hide');
        status.show('slide');
    }
});
