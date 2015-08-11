module LegislatorHelper
  def verbose_summary
    land = STATES.key(@legislator.state)
    title = @legislator.title
    district = @legislator.district
    if title == 'Del' || title == 'Com' || district == '0'
      "#{legislator_full_title} for #{land} At Large"
    elsif title == 'Rep' && district != '0'
      "#{legislator_full_title} for #{land}'s #{district.to_i.ordinalize} " \
      'congressional district'
    else
      "#{legislator_full_title} from #{land}"
    end
  end

  def full_leadership_role
    return unless @legislator.leadership_role
    if @legislator.leadership_role == 'Speaker'
      'Speaker of the House'
    else
      "House #{@legislator.leadership_role}"
    end
  end

  def bioguide_url
    return '#' unless @legislator.bioguide_id
    'http://bioguide.congress.gov/scripts/biodisplay.pl?' \
    "index=#{@legislator.bioguide_id}"
  end

  def votesmart_url
    return '#' unless @legislator.votesmart_id
    'http://votesmart.org/candidate/' \
    "#{@legislator.votesmart_id}/#{@legislator.first_name}-#{@legislator.last_name}"
  end

  def age
    return 'n/a' unless @legislator.birthday
    dob = Date.parse(@legislator.birthday)
    now = Time.zone.now.utc.to_date
    num_years = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    "#{num_years} years old"
  end

  def legislator_full_title
    title_hash = { 'Sen' => 'Senator', 'Rep' => 'Representative',
                   'Del' => 'Delegate', 'Com' => 'Commissioner' }
    title_hash[@legislator.title]
  end

  def full_party
    party_hash = { 'D' => 'Democrat', 'R' => 'Republican',
                   'I' => 'Independent' }
    party_hash[@legislator.party]
  end

  def legislator_name
    [:first_name, :middle_name, :last_name].map { |attr| @legislator.send(attr) }
      .compact.join(' ')
  end
end
