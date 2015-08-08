module NavigationHelpers
  def path_to(page_name)
    if page_name =~ /the home\s?page/ || page_name =~ /my bomb/
      '/'
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n"
    end
  end
end

World(NavigationHelpers)
