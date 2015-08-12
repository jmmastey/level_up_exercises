require('rspotify')
require('json')
class GraphGeneration
  attr_reader :depth
  def initialize
  end

  def search(name, depth)
    return {} if name == ''
    artist = find_artist(RSpotify::Artist.search(name), name)
    @depth = {}
    generate_network(artist, depth.to_i)
  end

  def nodes_to_json(network)
    nodes = []
    id = 1
    @visited_nodes = {}
    network.each do |key, value|
      next if @visited_nodes.key?(key)
      nodes << {id: id, label: key, color: colors(@depth[key])}
      @visited_nodes[key] = id
      id += 1
      value.each do |val|
        next if @visited_nodes.key?(key)
        nodes << {id: id, label: val, color: colors(@depth[val])}
        @visited_nodes[val] = id
        id += 1
      end
    end
    nodes.to_json
  end

  def edges_to_json(network)
    edges = []
    network.each do |key, value|
      value.each do |related|
        edges << {from:  @visited_nodes[key], to: @visited_nodes[related]}
      end
    end
    edges.to_json
  end

  private

  def generate_network(artist, depth)
    return {} if artist.nil? || depth <= 0
    if @depth.has_key?(artist.name)
      @depth[artist.name] = depth if @depth[artist.name] < depth
      return {}
    else
      @depth[artist.name] = depth
    end
    network = { artist.name => generate_related_artists(artist.related_artists) }
    artist.related_artists.each do |related|
      network.merge!(generate_network(related, depth - 1))
    end
    network
  end

  def generate_related_artists(related_artists)
    names = []
    related_artists.each do |artist|
      names << artist.name
    end
    names
  end

  # Filter the artist search. Do it this way because we expect nil if we don't find the artist
  def find_artist(artist_array, name)
    return nil if artist_array.size == 0
    artist_array.each do |artist|
      return artist if artist.name.downcase == name.downcase
    end
    nil
  end

  def colors(depth)
    %w(#4A5F70 #7F825f #C2AE95 #824E4E #66777D)[depth % 5]
  end
end