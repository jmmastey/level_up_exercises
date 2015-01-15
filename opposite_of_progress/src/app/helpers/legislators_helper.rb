module LegislatorsHelper
  def legislator_image_tag(legislator)
    image_path = "legislators/150/#{legislator.bioguide_id.capitalize}.jpg"
    dir_path = 'app/assets/images'
    return unless FileTest.exist? Rails.root.join(dir_path, image_path).to_s
    image_tag(image_path)
  end

  def link_to_legislator(legislator, options = {})
    name = [legislator.title, legislator.name].join('. ');
    link_to(name, legislator, options)
  end

  def link_to_legislator_with_representation(legislator, options = {})
    name = [legislator.title, legislator.name].join('. ');
    representation = [legislator.party, legislator.state].join('-')
    name_with_representation = "#{name} (#{representation})"
    link_to(name_with_representation, legislator, options)
  end

  def representation(legislator)
    state = States.abbr_to_state(legislator.state)
    text = [legislator.long_title, "for", state].join(' ')

    if legislator.senator?
      [legislator.state_rank.titleize, text].join(' ')
    else
      [text, legislator.readable_district, 'District'].join(' ')
    end
  end

  def representation_tag(legislator, options = {})
    content_tag(:div, representation(legislator), options)
  end

  def party_tag(legislator, options = {})
    party = legislator.long_party
    options[:class] = [options[:class], party.downcase].compact.join(' ')
    content_tag(:div, legislator.long_party, options)
  end

  def facebook_url(legislator)
    "http://facebook.com/#{legislator.facebook_id}"
  end

  def youtube_url(legislator)
    "http://youtube.com/#{legislator.youtube_id}"
  end

  def twitter_url(legislator)
    "http://twitter.com/#{legislator.twitter_id}"
  end

  def link_to_facebook(legislator, options = {})
    return if legislator.facebook_id.blank?
    options.merge!(target: '_blank')
    link_to(legislator.facebook_id, facebook_url(legislator), options)
  end

  def link_to_twitter(legislator, options = {})
    return if legislator.twitter_id.blank?
    options.merge!(target: '_blank')
    link_to("@#{legislator.twitter_id}", twitter_url(legislator), options)
  end

  def link_to_youtube(legislator, options = {})
    return if legislator.youtube_id.blank?
    options.merge!(target: '_blank')
    link_to(legislator.youtube_id, youtube_url(legislator), options)
  end

  def link_to_legislator_favorite(legislator, favorited_ids, options = {})
    return unless user_signed_in?

    if favorited_ids.include? legislator.id
      icon = 'star'
      action = 'unfavorite'
    else
      icon = 'star-o'
      action = 'favorite'
    end

    favorite_link = "/user/#{action}/legislator/#{legislator.id}"
    options.merge!(method: :post, title: "#{action.titleize} this Legislator")
    link_to(fa_icon(icon), favorite_link, options)
  end
end
