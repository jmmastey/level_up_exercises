var confirmed = false;

function check_confirmation() {
    if (confirmed) {
        return true;
    } else {
        document.getElementById("code").readOnly = 'readOnly';
        document.getElementById("codeSubmit").disabled = 'disabled';
        document.getElementById("codeSubmit").style.display = 'none';
        document.getElementById("activationConfirm").style.display = 'inline-block';
        document.getElementById("activationCancel").style.display = 'inline-block';
        return false;
    }
}

function confirmAndSubmit() {
    confirmed = true;
    document.forms["enterCodeForm"].submit();
    return true;
}

function cancelActivation() {
    document.getElementById("code").removeAttribute("readOnly");
    document.getElementById("codeSubmit").removeAttribute("disabled");
    document.getElementById("codeSubmit").style.display = 'inline-block';
    document.getElementById("activationConfirm").style.display = 'none';
    document.getElementById("activationCancel").style.display = 'none';
    return false;
}

function updateTimeRemaining() {
    if (total_seconds_remaining <= 1) {
        document.getElementById("timer").innerHTML = '0:00';
        location.reload();
    } else {
        total_seconds_remaining -= 1;
        var minutes_remaining = Math.floor(total_seconds_remaining / 60);
        var seconds_remaining = total_seconds_remaining % 60;
        var time = minutes_remaining + ":" + (seconds_remaining > 9 ? "" : "0") + seconds_remaining;
        document.getElementById("timer").innerHTML = time
    }
}

if (typeof total_seconds_remaining !== 'undefined') {
    window.setInterval(updateTimeRemaining, 1000);
}
