class Index < SitePrism::Page
  set_url "/"

  element :title_head, "span.navtitle"
  element :welcome_link, "span.navlink a"
end
