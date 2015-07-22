class ProvisionPage < SitePrism::Page
  set_url '/'

  element :activation_code, 'input[id=activation-code]'
  element :deactivation_code, 'input[id=deactivation-code]'
  element :countdown_value, 'input[id=countdown-value]'
  element :provision_bomb, 'input[id=provision-bomb]'
  element :provision_error, 'span[id=provision-error]'

  def create_bomb(options = {})
    activation_code.set(options[:activate]) if options[:activate]
    deactivation_code.set(options[:deactivate]) if options[:deactivate]
    provision_bomb.click
  end

  def provision_error_message
    provision_error.text
  end
end
