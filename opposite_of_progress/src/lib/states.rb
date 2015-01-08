class States
  STATES_AND_TERRITORIES = {
    AK: "Alaska",
    AL: "Alabama",
    AR: "Arkansas",
    AS: "American Samoa",
    AZ: "Arizona",
    CA: "California",
    CO: "Colorado",
    CT: "Connecticut",
    DC: "District of Columbia",
    DE: "Delaware",
    FL: "Florida",
    GA: "Georgia",
    GU: "Guam",
    HI: "Hawaii",
    IA: "Iowa",
    ID: "Idaho",
    IL: "Illinois",
    IN: "Indiana",
    KS: "Kansas",
    KY: "Kentucky",
    LA: "Louisiana",
    MA: "Massachusetts",
    MD: "Maryland",
    ME: "Maine",
    MI: "Michigan",
    MN: "Minnesota",
    MO: "Missouri",
    MP: "Northern Mariana Islands",
    MS: "Mississippi",
    MT: "Montana",
    NC: "North Carolina",
    ND: "North Dakota",
    NE: "Nebraska",
    NH: "New Hampshire",
    NJ: "New Jersey",
    NM: "New Mexico",
    NV: "Nevada",
    NY: "New York",
    OH: "Ohio",
    OK: "Oklahoma",
    OR: "Oregon",
    PA: "Pennsylvania",
    PR: "Puerto Rico",
    RI: "Rhode Island",
    SC: "South Carolina",
    SD: "South Dakota",
    TN: "Tennessee",
    TX: "Texas",
    UT: "Utah",
    VA: "Virginia",
    VI: "U.S. Virgin Islands",
    VT: "Vermont",
    WA: "Washington",
    WI: "Wisconsin",
    WV: "West Virginia",
    WY: "Wyoming"
  }

  def self.abbr_to_state(abbr)
    STATES_AND_TERRITORIES[abbr.to_sym]
  end

  def self.state_to_abbr(state, as_sym = false)
    abbr = STATES_AND_TERRITORIES.key(state)
    as_sym ? abbr : abbr.try(:to_s)
  end
end
