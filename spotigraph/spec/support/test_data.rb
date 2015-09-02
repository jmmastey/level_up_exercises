class TestData
  # These are generally artists that will be found when searching spotify
  # If you add an artist here, ensure you add the related artists of that artist
  # below, and add the artist information to the seed data.
  def self.valid_artists
    [
        'Black Sabbath',
        'Radiohead',
    ]
  end

  # For each artist in valid_artists there must exist an entry in
  # valid_artists_related which matches the entry in db/seeds.rb
  def self.valid_artists_related
    {
      'Black Sabbath' => [
          'Ozzy Osbourne',
          'Judas Priest',
          'Dio',
          'Iron Maiden',
          'Motörhead',
          'Danzig',
          'Deep Purple',
          'Thin Lizzy',
          'KISS',
          'Saxon',
          'Heaven & Hell',
          'AC/DC',
          'Rainbow',
          'Metallica',
          'Bruce Dickinson',
          'Tony Iommi',
          'UFO',
          'Diamond Head',
          'Alice Cooper',
          'Uriah Heep',
      ],
      'Radiohead' => [
        'Thom Yorke',
        'Portishead',
        'Björk',
        'Muse',
        'Pixies',
        'Interpol',
        'Atoms For Peace',
        'Beck',
        'Joy Division',
        'Four Tet',
        'The National',
        'The Flaming Lips',
        'Grizzly Bear',
        'The xx',
        'The Smiths',
        'Burial',
        'R.E.M.',
        'Placebo',
        'Liars',
        'St. Vincent',
      ],
    }
  end

  def self.not_seeded_artists
    [
        'Mixtapes',
        'Blink-182'
    ]
  end


  # These are generally artists that will not end up being found on search
  # Avoid adding names similar to Faker::Name.name whenever possible.
  def self.invalid_artists
    [
        'Bak Sabat',
        'sPUKslXlnz',
        'pdbPxLK7rt',
        'w8yUJnC171',
        'mLvr4IaeC8',
        '',
        '; DROP TABLE graph;',
        "<script>alert('alert');</script>",
    ]
  end

  def self.valid_depths
    [

    ]
  end

  def self.invalid_depths
    [
        'words',
        '',
        nil,
        '-1',
        -1,
        -2,
        -3,
        10,
        11,
    ]
  end
end