describe GraphGeneration do
  let(:generator) { GraphGeneration.new }
  let(:test_artists) {[
      'Radiohead',
      'Arctic Monkeys',
      'Black Sabbath',
      'Green Day',
      'Led Zeppelin',
      'Operation Ivy',
      'Rancid',
      'NOFX',
      'Mixtapes',
      'Direct Hit!',
  ]}
  let(:black_sabbath_rel) {[
      'Rainbow'
  ]}

  let(:bad_artist_names) {[
      '2CBuQyXRmt',
      'qHJcgm6IAy',
      'ZRE2LKOIpn',
      'nXVUPo86ZP',
      '3Vb5glXigX',
      'MnnSL548U4',
      '1D16pRHaWH',
      '8rUkuBkdcE',
      'aU9Spg28K7',
      'CR2TTLBMgg',
      'Bak Sabat',
      'DirectHit',
      'raydiohead',
      'Arktik Monkies',
      'Greenday',
      'Lead Zepellin',
      '',
  ]}

  let(:bad_depths) {[
      '1',
      'one',
      '',
      1.0,
      0.5,
      -1,
      -2,
      0,
  ]}

  it 'captures the minimal depth correctly (color issue)' do
    graph = generator.search('Black Sabbath', 3)
    black_sabbath_rel.each
    expect(generator.depth['Rainbow']).to eq(2)
  end


  # search_wrapper
  it 'should have 1 entry for depth 1' do
    test_artists.each do |artist|
      assert_size_at_depth(artist, 1, 1)
    end
  end



  it 'should have 21 entries for depth 2' do
    test_artists.each do |artist|
      assert_size_at_depth(artist, 2, 21)
    end
  end

  it 'should fail to find artists that are garbage or misspelled for arbitrary depth.' do
    bad_artist_names.each do |bad|
      assert_size_at_depth(bad, rand(1...10), 0)
    end
  end

  it 'should accept troublesome depths' do
    bad_depths.each do |depth|
      assert_size_at_depth(test_artists[0], depth, depth.to_i <= 0 ? 0 : 1)
    end
  end

  def assert_size_at_depth(artist, depth, size)
      graph = generator.search(artist, depth)
      expect(graph.size).to eq(size), lambda { "expected #{artist} to have #{size} entries at depth #{depth} got #{graph.size}" }
  end
end