module NavigationHelpers
  def path_to(page_name)
    if page_name =~ /home/ || page_name =~ /character selection/
      '/'
    elsif page_name =~ /registration/
      '/users/sign_up'
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n"
    end
  end
end

World(NavigationHelpers)
