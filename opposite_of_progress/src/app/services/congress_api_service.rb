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

  BILL_FIELDS_STR = %w(
    bill_id
    bill_type
    official_title
    chamber
    congress
    number
    urls.congress
    history.active
    history.enacted
    history.enacted_at
    enacted_as
    introduced_on
    last_action_at
    last_version.urls.pdf
    summary
    summary_short
    sponsor_id
    cosponsors
    cosponsors.legislator.bioguide_id
    cosponsors.sponsored_on
    actions
  )

  def self.search_by_address(address)
    results = Congress.legislators_locate(address, fields: 'bioguide_id')
    results[:results].map { |legislator| legislator[:bioguide_id] }
  end

  def self.sync_legislators
    pages = (legislators_total / 20.0).ceil;
    pages.times.each do |i|
      legislator_params_collection = legislators_page((i+1), 20)
      update_or_create_legislators(legislator_params_collection)
    end
  end

  def self.sync_bills
    pages = (bills_total / 20.0).ceil;
    pages.times.each do |i|
      bills_params_collection = bills_page((i+1), 20)
      update_or_create_bills(bills_params_collection)
    end
  end


  def self.legislators_page(page = 1, per_page = 20)
    options = {
      fields: LEGISLATOR_FIELDS_STR,
      page: page,
      per_page: per_page
    }

    results = Congress.legislators(options)
    results[:results]
  end

  def self.bills_page(page = 1, per_page = 20)
    options = {
      fields: BILL_FIELDS_STR,
      'congress' => 114,
      page: page,
      per_page: per_page
    }

    results = Congress.bills(options)
    results[:results]
  end

  def self.legislators_total
    options = { fields: 'bioguide_id' }
    results = Congress.legislators(options)
    results[:count]
  end

  def self.bills_total
    options = {
      fields: 'bill_id',
      'congress' => 114,
    }

    results = Congress.bills(options)
    results[:count]
  end

  def self.update_or_create_legislators(legislator_params_collection)
    legislator_params_collection.each do |legislator_params|
      bioguide_id = legislator_params[:bioguide_id]
      legislator = Legislator.find_or_initialize_by(bioguide_id: bioguide_id)
      # Congress API retursn Hashie::Rash, which gives mass assignment errors
      legislator.update_attributes(legislator_params.to_hash)
    end
  end

  def self.update_or_create_bills(bills_params_collection)
    bills_params_collection.each do |bill_params|
      bill_id = update_or_create_bill(bill_params)
      delete_all_actions(bill_id)
      create_sponsorships(bill_params, bill_id)
      create_cosponsorships(bill_params, bill_id)
      create_actions(bill_params, bill_id)
    end
  end

  def self.update_or_create_bill(bill_params)
    bill_params_t = transform_bill(bill_params)
    official_id = bill_params_t["official_id"]
    bill = Bill.find_or_initialize_by(official_id: official_id)
    bill.update_attributes(bill_params_t)
    bill.id
  end

  def self.transform_bill(bill_params)
    bill_params_t = bill_params.slice(
      :bill_type,
      :official_title,
      :chamber,
      :congress,
      :number,
      :enacted_as,
      :introduced_on,
      :summary,
      :last_action_at
    )

    bill_params_t.merge!(bill_params.history.to_hash)
    bill_params_t[:official_id] = bill_params[:bill_id]
    bill_params_t[:url] = bill_params[:urls][:congress] if bill_params[:urls].presence
    bill_params_t[:enacted_as] = enacted_as(bill_params[:enacted_as])

    if bill_params[:last_version] && bill_params[:last_version][:urls]
      bill_params_t[:latest_version_pdf] = bill_params[:last_version][:urls][:pdf]
    end

    bill_params_t.to_hash
  end

  def self.enacted_as(e)
    return unless e.present?
    "#{e.law_type} Law #{e.congress}-#{e.number}"
  end

  def self.delete_all_actions(bill_id)
    GoodDeed.delete_all(bill_id: bill_id)
  end

  def self.create_sponsorships(bill_params, bill_id)
    legislator_id = legislator_id_by_bioguide(bill_params[:sponsor_id])
    return if legislator_id.nil?

    GoodDeed.create(
      action: 'sponsored',
      legislator_id: legislator_id,
      bill_id: bill_id,
      acted_at: bill_params[:introduced_on],
      chamber: bill_params[:chamber]
    )
  end

  def self.create_cosponsorships(bill_params, bill_id)
    bill_params[:cosponsors].each do |c|
      legislator_id = legislator_id_by_bioguide(c[:legislator][:bioguide_id])
      next if legislator_id.nil?

      GoodDeed.create(
        action: 'cosponsored',
        legislator_id: legislator_id,
        bill_id: bill_id,
        acted_at: c[:sponsored_on],
        chamber: bill_params[:chamber]
      )
    end
  end

  def self.create_actions(bill_params, bill_id)
    bill_params[:actions].each do |a|
      if a[:type] == 'vote' && a[:results] == 'pass'
        action = 'voted'
        chamber = a[:chamber]
      elsif a[:type] == 'enacted'
        action = 'enacted'
        chamber = nil
      else
        next
      end

      GoodDeed.create(
        action: action,
        legislator_id: nil,
        bill_id: bill_id,
        chamber: chamber,
        text: a[:text],
        acted_at: a[:acted_at]
      )
    end
  end

  def self.legislator_id_by_bioguide(bioguide_id)
    Legislator.where(bioguide_id: bioguide_id).first.try(:id)
  end

  private_class_method :legislators_page
  private_class_method :legislators_total
  private_class_method :update_or_create_legislators
end
