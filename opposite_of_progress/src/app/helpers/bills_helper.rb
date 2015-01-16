module BillsHelper
  def link_to_bill(bill, options = {})
    bill_name = bill.official_title
    bill_name = "#{bill.official_id.upcase}: #{bill_name}" if options[:without_id].blank?
    link_to(bill_name, bill, options)
  end

  def link_to_bill_pdf(bill, options = {})
    return unless bill.latest_version_pdf?
    pdf = bill.latest_version_pdf.sub(/.*\//, '')
    link_to(pdf, bill.latest_version_pdf)
  end

  def link_to_bill_favorite(bill, favorited_ids, options = {})
    return unless user_signed_in?

    if favorited_ids.include? bill.id
      icon = 'star'
      action = 'unfavorite'
    else
      icon = 'star-o'
      action = 'favorite'
    end

    favorite_link = "/user/#{action}/bill/#{bill.id}"
    options.merge!(method: :post, title: "#{action.titleize} this Bill")
    link_to(fa_icon(icon), favorite_link, options)
  end
end
