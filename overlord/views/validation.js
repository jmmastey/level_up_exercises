function validate_digit() {
    if ((event.keyCode >= 48 && event.keyCode <= 57)) {
        return true;
    }
    return false;
}

function validate() {
    // check if input is bigger than 3
    var actcode = document.getElementById('actcode').value || document.getElementById('actcode').placeholder;
    var deactcode = document.getElementById('deactcode').value || document.getElementById('deactcode').placeholder;
    if (actcode.length == 4 && deactcode.length == 4) {
        return true; // keep form from submitting
    }
    alert('Please enter four digit codes.')
    return false;
}