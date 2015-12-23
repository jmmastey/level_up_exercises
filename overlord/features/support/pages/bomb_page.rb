class BombPage < SitePrism::Page
  set_url "/bomb"

  element :instructions, "div.instructions"
  element :submit_button, "button[name='whitebutton']"

end
