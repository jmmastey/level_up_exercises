class Users::SessionsController < Devise::SessionsController
  layout 'login'

  # before_filter do
  #  params.each do |p, v|
  #    puts "P: #{p} V: #{v}"
  #  end
  # end

  protected

  #def after_sign_in_path_for(resource_or_scope)
  #  root_path
  #end
end
