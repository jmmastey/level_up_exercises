class LegislatorQuery
  attr_reader :relation, :query, :params, :full_search_term,
              :current_search_term

  def initialize(relation, search_term)
    @relation = relation
    @query = []
    @params = []
    @full_search_term = search_term.strip.downcase.titleize
    @current_search_term = ''
  end

  def execute
    if full_search_term.count(' ') == 0
      single_keyword_search
    else
      multi_keyword_search
    end

    relation.where(query.join(' AND '), *params)
  end

  private

  def build_query(*parameters)
    parameters.each { |param| send("handle_#{param}") }
  end

  def single_keyword_search
    @current_search_term = full_search_term
    build_query(:zipcode, :party, :title, :state)
    handle_names if query.empty?
  end

  def multi_keyword_search
    state = handle_multi_word_state
    search_terms = full_search_term.gsub(state.to_s, '').strip.split(' ')

    search_terms.each_with_index do |term, index|
      @current_search_term = term
      build_query(:zipcode, :party, :title, :state)
      handle_names unless query[index]
    end

    return unless state
    @params.push(STATES[state])
    @query << 'state = ?'
  end

  def handle_multi_word_state
    STATES.keys.find { |key| full_search_term.include?(key) }
  end

  def handle_zipcode
    return unless current_search_term =~ /^\d{5}$/
    state = current_search_term.to_region(state: true)

    return unless state

    @params.push(state)
    district_ids = CongressionalDistrict.where(zipcode: current_search_term)
                                        .map(&:congressional_district_id)
                                        .map(&:to_s)
    @params.push(district_ids)
    @query << '(state = ? AND district IN (?))'
  end

  def handle_party
    parties = %w(Republican Democratic Indepedent)
    return unless parties.include?(current_search_term)
    party_param = current_search_term[0]
    @params.push(party_param)
    @query << 'party = ?'
  end

  def handle_state
    normalized_full_state_name = current_search_term
    noramlized_state_abbreviation = current_search_term.upcase

    return unless STATES[normalized_full_state_name] ||
                  STATES.values.include?(noramlized_state_abbreviation)

    if STATES[normalized_full_state_name]
      @params.push(STATES[normalized_full_state_name])
    else
      @params.push(noramlized_state_abbreviation)
    end
    @query << 'state = ?'
  end

  def handle_title
    titles = %w(Representative Senator Delegate Commissioner Rep Sen Del Com)
    return unless titles.include?(current_search_term)
    title_param = current_search_term[0..2]
    @params.push(title_param)
    @query << 'title = ?'
  end

  def handle_names
    normalized_name = current_search_term
    @params.push(normalized_name, normalized_name)
    @query << '(first_name LIKE ? OR last_name LIKE ?)'
  end
end
