class ProvisionPage < SitePrism::Page
  set_url '/'

  element :activation_code, 'input[id=activation-code]'
  element :deactivation_code, 'input[id=deactivation-code]'
  element :provision_bomb, 'input[id=provision-bomb]'

  def create_bomb(options = {})
    activation_code.set(options[:activate]) if options[:activate]
    provision_bomb.click
  end
end
