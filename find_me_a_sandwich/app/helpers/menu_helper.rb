module MenuHelper
  def menu_heading_id(menu)
    "menu#{menu.id}-#{menu.name.camelize}"
  end

  def menu_collapse_id(menu)
    "menuCollapse#{menu.id}-#{menu.name.camelize}"
  end
end
