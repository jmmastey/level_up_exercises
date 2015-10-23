class DeliverySandbox < OmniAuth::Strategies::OAuth2
  # Give your strategy a name.
  option :name, "delivery_sandbox"

  # This is where you pass the options you would pass when
  # initializing your consumer from the OAuth gem.
  option :client_options, {:site => "http://sandbox.delivery.com"}

  # These are called after authentication has succeeded. If
  # possible, you should try to set the UID without making
  # additional calls (if the user id is returned with the token
  # or as a URI parameter). This may not be possible with all
  # providers.
  uid{ raw_info['id'] }

  def raw_info
    @raw_info ||= access_token.get('/me').parsed
  end
end
