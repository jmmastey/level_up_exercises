module Helpers
  def attempt_bad_deactivation
    fill_in("deactivation_code", with: "5678")
    click_button("Deactivate")
  end

  def attempt_bad_deactivations
    Bomb::MAX_ATTEMPTS.times do
      attempt_bad_deactivation
    end
  end

  def activate(act, deact)
    visit path_to("the inactivated page")
    page.should have_content("Enter your activation code")
    fill_in("activation_code", with: act)
    fill_in("deactivation_code", with: deact)
    click_button("Arm the bomb")
  end
end