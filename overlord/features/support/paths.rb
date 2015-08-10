# Taken from the cucumber-rails project.

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
      when /the home\s?page/
        '/'
      when /configure_bomb\s?page/
        '/configure_bomb'
      when /disarm_bomb\s?page/
        '/disarm_bomb'
      else
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" /
          "Now, go and add a mapping in #{__FILE__}"
      end
  end
end

World(NavigationHelpers)
