# File capybara_helpers.rb
module XPath::HTML
  def fillable_field(locator)
    locator = locator.to_s
    xpath = descendant(:input, :textarea, :a)[~attr(:type).one_of('submit', 'image', 'radio', 'checkbox', 'hidden', 'file')]
    xpath = locate_field(xpath, locator)
    xpath
  end

  def field(locator)
    locator = locator.to_s
    xpath = descendant(:input, :textarea, :select, :a, :div)[~attr(:type).one_of('submit', 'image', 'hidden')]
    xpath = locate_field(xpath, locator)
    xpath
  end
end

# module Capybara::Node::Actions
#   def click_on(locator, options={})
#     find(:field, locator, options).click
#   end
# end