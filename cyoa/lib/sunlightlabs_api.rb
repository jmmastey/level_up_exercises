require 'json'
require 'open-uri'

module SunlightlabsApi
  ENDPOINT = 'https://congress.api.sunlightfoundation.com'
  PER_PAGE = 50
  BILL_FIELDS = %w(actions bill_id bill_type chamber congress cosponsors_count
                   introduced_on keywords last_action.acted_at
                   last_version.urls.pdf official_title popular_title
                   summary_short short_title sponsor.first_name
                   sponsor.last_name sponsor.title urls.govtrack)

  def get_bills_from_api
    page = 1
    other_parameters = 'history.active=true&order=last_action_at&' \
                       'introduced_on__gt="2015-01-01"'

    fields = BILL_FIELDS.join(',')
    loop do
      url = "#{ENDPOINT}/bills?fields=#{fields}&#{other_parameters}&per_page=#{PER_PAGE}&page=#{page}&apikey=#{ENV['SUNLIGHTLABS_APIKEY']}"
      data = JSON.parse(open(url).read)
      results = data['results']
      page_count = data['page']['count']
      parse_bill_results(results)
      page += 1
      break if page_count < PER_PAGE
    end
  end

  def get_legislators_from_api
    url = "#{ENDPOINT}/legislators?per_page=all&apikey=#{ENV['SUNLIGHTLABS_APIKEY']}"
    legislators = JSON.parse(open(url).read)['results']
    direct_attributes = %w(bioguide_id birthday contact_form district oc_email
                           facebook_id fax first_name gender fax in_office
                           last_name leadership_role middle_name name_suffix
                           nickname office party phone state term_end term_start
                           title twitter_id votesmart_id website youtube_id)
    legislators.each do |row|
      values = direct_attributes.map { |attribute| row.fetch(attribute, nil) }
      legislator_attributes = Hash[direct_attributes.zip(values)]
      Legislator.create(legislator_attributes)
    end
  end

  private

  def parse_bill_results(results)
    direct_attributes = %w(bill_id bill_type chamber congress cosponsors_count
                           introduced_on official_title popular_title
                           short_title summary_short)

    results.each do |row|
      values = direct_attributes.map { |attribute| row.fetch(attribute, nil) }
      bill_attributes = Hash[direct_attributes.zip(values)]
      bill_attributes['legislator_id'] = handle_sponsor(row)
      bill_attributes['url'] = row['urls']['govtrack'] if row['urls']
      bill_attributes['last_action_at'] = handle_last_action_at(row)

      bill_attributes['introduced_on'] = handle_introduced_on(bill_attributes)
      bill_attributes['last_version_pdf'] = handle_last_version_pdf(row)

      bill = Bill.where(bill_attributes).first_or_create
      create_bill_associations(bill, row['actions'], row['keywords'])
    end
  end

  def handle_introduced_on(bill_attributes)
    return nil unless bill_attributes['introduced_on']
    Date.parse(bill_attributes['introduced_on'])
  end

  def handle_last_action_at(row)
    return nil unless row['last_action'] && row['last_action']['acted_at']
    Date.parse(row['last_action']['acted_at'])
  end

  def handle_sponsor(row)
    return nil unless row['sponsor']
    sponsor = row['sponsor']
    legislator = Legislator.where(first_name: sponsor['first_name'],
                                  last_name: sponsor['last_name']).first
    return nil unless legislator

    legislator.id
  end

  def handle_last_version_pdf(row)
    return nil unless row['last_version'] && row['last_version']['urls']
    row['last_version']['urls']['pdf']
  end

  def create_bill_associations(bill, actions, keywords)
    return unless actions
    actions.each do |action|
      BillAction.create(text: action['text'],
                        date: Date.parse(action['acted_at']),
                        bill_id: bill.id,
                        result: action['result'],
                        chamber: action['chamber'])
    end

    return unless keywords
    keywords.each do |keyword|
      tag = Tag.where(name: keyword).first_or_create
      BillTag.create(tag_id: tag.id, bill_id: bill.id)
    end
  end
end
