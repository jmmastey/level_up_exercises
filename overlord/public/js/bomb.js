var currentTime = 10000;
var timer = null;

$(document).ready(function(){
    $("#btn-submit-code").on('click',function(event){
        event.preventDefault();
        code_type = $(this).text();
        code = $('#code').val();
        $('#code').val('');  
        makeAjaxCall(code_type, code);
    });

    $('#code').on('click', function(){
        $('.alert').css('display', 'none');
    });
})


function makeAjaxCall(code_type, code){
    $.ajax({
        url: '/submit_code',
        type: "POST",
        data: { code_type: code_type, code: code }, 
        success:function(data){
            if(data == 'exploded'){
                bootbox.alert('The bomb is already exploded.\n You have to reboot the bomb again.', function(){
                    window.location = '/';
                });
                return;
            }

            var obj = JSON.parse(data);
            if(!obj['result']){
                if(obj['bomb_state'] == 'exploded'){
                    window.location = '/detonate';
                }
                code_type = code_type.substring(0, code_type.length - 1) + 'ion';
                displayAlertMessage(code_type + " code does not match");
            }else{
                $('#bomb-state').text(obj['bomb_state']);
                if(code_type == 'Activate'){
                    bomb_activated();
                }else{
                    bomb_deactivated();
                }
            }      
        },
    });
}
function bomb_activated(){
    $('#btn-submit-code').text('Deactivate');
    $('h4').css('color', 'red');
    currentTime = 10000;
    timer = $.timer(updateTimer, 70, false);
    $("#bomb-timer").css("display", "block");
    timer.toggle();
}
function bomb_deactivated(){
    timer.toggle();
    $('#btn-submit-code').text('Activate');
    $('h4').css('color', 'white');
}
function displayAlertMessage(message){
    $('#alert-message').text(message);
    $('#alert-message').css("display","block");
}
function updateTimer(){
    $("#bomb-timer").html(formatTime(currentTime));
    if(currentTime == 0){
        timer.stop();
        window.location = '/detonate';
        return;
    }
    currentTime -= 70 / 10;
    if(currentTime < 0) currentTime = 0;

}

function pad(number , length){
    var str = '' + number;
    while (str.length < length){
        str = '0' + str;
    }
    return str;
}
function formatTime(time) {
    var min = parseInt(time / 60000);
        min = (min > 0 ? pad(min, 2) : '00');

    var sec = parseInt(time / 1000) - (min * 60);
        sec = pad(sec, 2);

    var millisecond = time - (sec * 1000) - (min * 60000);
        millisecond = pad(millisecond, 3);

    return min + ":" + sec + ":" + millisecond;
}

