class CongressApiService
  LEGISLATOR_FIELDS_STR = %w(
    first_name
    last_name
    middle_name
    name_suffix
    title
    chamber
    party
    state
    congress
    district
    state_rank
    bioguide_id
    phone
    website
    youtube_id
    facebook_id
    twitter_id
    updated_at
  ).join(',')

  def self.search_by_address(address)
    results = Congress.legislators_locate(address, fields: 'bioguide_id')
    results[:results].map { |legislator| legislator[:bioguide_id] }
  end

  def self.sync_legislators
    pages = legislators_total / 20;
    pages.times.each do |i|
      legislator_page((i+1), 20).each do |legislator_params|
        Legislator.create(legislator_params.to_hash)
      end
    end
  end

  def self.legislator_page(page = 1, per_page = 20)
    options = { fields: LEGISLATOR_FIELDS_STR }
      .merge(page: page, per_page: per_page)
    results = Congress.legislators(options)
    results[:results]
  end

  def self.legislators_total
    options = { fields: 'bioguide_id' }
    results = Congress.legislators(options)
    results[:count]
  end

end
