
def create_content_page
  @page ||=
    FactoryGirl.create(:page_with_content)
end

Given(/^I am on a lesson content page$/) do
  visit(page_path(create_content_page))
end
