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

  def representation_tag(legislator, options = {})
    state = States.abbr_to_state(legislator.state)
    text = [legislator.long_title, "for", state].join(' ')
    text = if legislator.senator?
      [legislator.state_rank.titleize, text].join(' ')
    else
      [text, legislator.readable_district, 'District'].join(' ')
    end

    content_tag(:div, text, options)
  end

  def party_tag(legislator, options = {})
    party = [legislator.long_party, "Party"].join(" ")
    content_tag(:div, party, options)
  end

  def link_to_facebook(legislator, options = {})
    return if legislator.facebook_id.blank?
    facebook_url = "http://facebook.com/#{legislator.facebook_id}"
    options.merge!(target: '_blank')
    link_to(legislator.facebook_id, facebook_url, options)
  end

  def link_to_twitter(legislator, options = {})
    return if legislator.twitter_id.blank?
    twitter_url = "http://twitter.com/#{legislator.twitter_id}"
    options.merge!(target: '_blank')
    link_to("@#{legislator.twitter_id}", twitter_url, options)
  end

  def link_to_youtube(legislator, options = {})
    return if legislator.youtube_id.blank?
    youtube_url = "http://youtube.com/#{legislator.youtube_id}"
    options.merge!(target: '_blank')
    link_to(legislator.youtube_id, youtube_url, options)
  end
end
