require "app_config"

module EventAggregator
  AppConfig.setup!(
    yaml: "#{Rails.root}/config/#{self.name.underscore}.yml"
  )

  contacts = AppConfig.contacts['customer_service']
  self.customer_service_telno = contacts['telephone']
  self.customer_service_email = contacts['email']
  self.customer_service_mail = contacts['mail']
end

