module LegislatorsHelper
  def legislator_image_tag(legislator)
    images = Dir.glob('app/assets/images/legislators/150/*.jpg')
    index  = legislator.id % images.length
    image  = images[index].sub('app/assets/images/', '')

    image_tag(image)
  end

  def link_to_legislator(legislator, options = {})
    name_with_title = [legislator.title, legislator.name].join('. ');
    link_to(name_with_title, legislator, options)
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
end
