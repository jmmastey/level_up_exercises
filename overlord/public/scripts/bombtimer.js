function explode(){
  document.getElementById("bomb_inactive").src ="images/inactive_bomb.jpg";
  setTimeout("document.getElementById('bomb_inactive').src ='images/exploded_bomb.jpg';",
 30000);
}
