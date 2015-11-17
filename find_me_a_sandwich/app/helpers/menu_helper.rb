module MenuHelper
  def each_column(menu, &block)
    groups = menu.menu_items.group_by(&:menu_group)
    groups.each_slice((groups.count / 2.0).round, &block)
  end

  def menu_heading_id(menu)
    "menu#{menu.id}-#{menu.name.camelize}"
  end

  def menu_collapse_id(menu)
    "menuCollapse#{menu.id}-#{menu.name.camelize}"
  end
end
