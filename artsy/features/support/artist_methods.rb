def create_artist(name)
  fill_in("Add a New Artist", with: name)
  click_button("Add Artist")
end
