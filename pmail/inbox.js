document.addEventListener('DOMContentLoaded', init, false);

function elementById(id) { document.getElementById(id)[0] }
function setupEvent(id, eventname, handler) {
  elementById(id).addEventListener(eventname, handler, false)
}

function init()
{

}
