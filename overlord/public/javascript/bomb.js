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
            console.log(code);
            $("#input-deactivate").hide('slide', function() {
                $("#input-activate").hide('slide', function(){
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
            if (a_code == "" || a_code == null){
                a_code = 1234;
            }
            if (d_code == "" || d_code == null){
                d_code = "0000";
            }
            $.ajax({
                type: "POST",
                url: '/activate',
                data: {a_code, activate, d_code},
            }).success(function(data) {
                console.log(a_code);
                console.log(d_code);
                $("#activate-bomb").hide('slide', function() {
                    $("#submit-bomb").hide('slide', function() {
                       if (activate == a_code) {
                        console.log(activate);
                        $(".bomb-deactivated").show('slide');
                        $("#countdown").show('slide');
                       } else {
                        $("#activate-bomb").show('slide');
                        $("#submit-bomb").show('slide');
                       }
                    });
                });
            }).done(deactivateBomb(0, a_code, d_code));
            return false;
        });
    }
    function deactivateBomb(numberOftries, a_code, d_code) {
        $("#try-bomb").click({a_code, d_code}, function() {
            // var a_code = $('input[name=a_code]').val();
            var deactivate = $('input[name=deactivate]').val();
            console.log("a_code", a_code);
            console.log(d_code);
            // console.log(d_code);
            // console.log(deactivate);
            $.ajax({
                type: "POST",
                url: '/deactivate',
                data: {d_code, deactivate},
            }).success(function(data) {
                // console.log(d_code);
                if (numberOftries <= 3) {
                    if (d_code != deactivate){
                        numberOftries += 1;
                        deactivateBomb(numberOftries, d_code);
                    } else if (d_code == deactivate){
                        $("#countdown").hide('slide');
                    }
                } else {
                    explodeBomb();
                }
            }).done();
            return false;
        });
    }

    function explodeBomb(){
        alert("The Bomb Exploded");
    }
});
// $(".bomb-wrapper").show();
// $('#buttonTwo').hide('slide', {direction: 'left'}, 1000);