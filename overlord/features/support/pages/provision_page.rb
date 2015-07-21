class ProvisionPage < SitePrism::Page
  set_url '/'

  element :activation_code, 'input[id=activation-code]'
  element :deactivation_code, 'input[id=deactivation-code]'
  element :provision_bomb, 'input[id=provision-bomb]'
  element :code_error, 'span[id=code-error]'

  def create_bomb(options = {})
    activation_code.set(options[:activate]) if options[:activate]
    provision_bomb.click
  end

  def code_error_message
    code_error.text
  end
end
