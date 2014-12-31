module FormFillHelpers
  # Coming soon (maybe): FactoryGirl Bombs!

  def create_bomb(args = {})
    fill_in "create_activation_code", with: args[:create_activation_code]
    fill_in "create_deactivation_code", with: args[:create_deactivation_code]
    fill_in "create_fuse", with: args[:create_fuse]
    click_button('Create!')
  end

  def activate_bomb(args = {})
    fill_in "activation_code", with: args[:activation_code]
    click_button('Activate!')
  end

  def deactivate_bomb(args = {})
    fill_in "deactivation_code", with: args[:deactivation_code]
    click_button('Deactivate!')
  end
end
