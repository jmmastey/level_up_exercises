
function validateForm(e) {
  var valid = true;
  var validationMessage = "";

  //Validate activation code
  if (isNaN(document.getElementById('activation_code').value)){
    validationMessage = validationMessage + 'activation code is not a number\r\n';
    valid = false;
  }

  //Validate reactivation code
  if (isNaN(document.getElementById('reactivation_code').value)){
    validationMessage = validationMessage + 'reactivation code is not a number\r\n';
    valid = false;
  }

  //Validate deactivation code
  if (isNaN(document.getElementById('deactivation_code').value)){
    validationMessage = validationMessage + 'deactivation code is not a number\r\n';
    valid = false
  }

  //Check if activation codes match
  if (document.getElementById('activation_code').value != document.getElementById('reactivation_code').value){
    validationMessage = validationMessage + 'activation codes do not match\r\n';
    valid = false
  }

  if (valid == false){
    console.log(validationMessage)
    alert(validationMessage)
    e.preventDefault();
  }

  return valid
}

