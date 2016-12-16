module BillHelper
  def bill_title
    content_tag(:h5) do
      concat @bill.type_and_num
      concat ': '
      titles = [@bill.popular_title, @bill.short_title, @bill.official_title]
      concat titles.compact.first
    end
  end

  def bill_current_status
    actions = @bill.bill_actions

    if (enacted_action = actions.enacted.first)
      return enacted_action.text
    elsif (signed_action = actions.signed.first)
      return signed_action.text
    elsif (vetoed_action = actions.vetoed.first)
      return vetoed_action.text
    end

    house_action = actions.passed_house.first
    senate_action = actions.passed_senate.first
    determine_bill_state(house_action, senate_action)
  end

  def determine_bill_state(house_action, senate_action)
    senate_bill_passed_senate_and_house = (@bill.bill_type == 's' && senate_action && house_action)
    house_bill_only_passed_house = (%w(hr hconres).include?(@bill.bill_type) && house_action && senate_action.nil?)
    house_bill_passed_house_and_senate = (@bill.bill_type == 'hr' && senate_action && house_action)
    senate_bill_only_passed_senate = (%w(s sconres).include?(@bill.bill_type) && senate_action && house_action.nil?)
    no_houses_passed = house_action.nil? && senate_action.nil?

    if (@bill.bill_type == 'sres' && senate_action) || (@bill.bill_type == 'hres' && house_action)
      'Agreed To Simple Resolution'
    elsif %w(sconres hconres).include?(@bill.bill_type) && house_action && senate_action
      'Agreed To Concurrent Resolution'
    elsif senate_bill_passed_senate_and_house || house_bill_only_passed_house
      "Passed House on #{house_action.date.strftime('%b %-d, %Y')}"
    elsif senate_bill_only_passed_senate || house_bill_passed_house_and_senate
      "Passed Senate on #{senate_action.date.strftime('%b %-d, %Y')}"
    elsif no_houses_passed
      "Introduced to #{@bill.chamber.capitalize}"
    end
  end

  def bookmark_options
    return unless current_user
    if UserBill.exists?(user_id: current_user.id, bill_id: @bill.id)
      already_bookmarked
    else
      allow_bookmark_action
    end
  end

  def already_bookmarked
    content_tag(:p) do
      concat icon('bookmark')
      concat 'Bookmarked!'
    end
  end

  def allow_bookmark_action
    content_tag(:p) do
      link_text = icon('bookmark_border') << 'Add to bookmarks'
      link_to(link_text, bookmarks_path(bill_id: @bill.id), method: :post)
    end
  end

  def icon(text)
    content_tag(:i, text, class: 'material-icons')
  end

  def bill_action_text(action)
    date = action.date.strftime('%B %-d, %Y')
    date_class = 'col s3'
    text_class = 'col s9'
    date_class << ' bold' if @important_actions.include?(action)
    text_class << ' bold' if @important_actions.include?(action)
    content_tag(:tr) do
      concat content_tag(:td, date, class: date_class)
      concat content_tag(:td, action.text, class: text_class)
    end
  end
end
