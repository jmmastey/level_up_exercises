# Taken from the cucumber-rails project.

module NavigationHelpers
  def path_to(page_name)
    case page_name
      when /home\s?page/
        '/'
      when /bomb\s?activation\s?page/
        '/boot_device'
      when /bomb\s?creation\s?page/
        '/create_bomb'
      when /bomb\s?disarming\s?page/
        '/disarm_bomb'
      when /bomb\s?disarmed\s?page/
        '/disarmed_bomb'
      when /bomb\s?detonated\s?page/
        '/detonated_bomb'
      else
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
            "Now, go and add a mapping in #{__FILE__}"
      end
    end
end

World(NavigationHelpers)
