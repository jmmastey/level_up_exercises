require_relative('../../lib/graph_json')
require('faker')

describe GraphJSON do
  describe '.to_json' do
    let(:graph_json) { GraphJSON.new }
    let(:max_size) { 200 }

    # nodes_to_json
    it 'returns empty for an empty graph' do
      result = %w([] [])
      expect(graph_json.to_json({}, 0)).to eq(result)
    end

    it 'converts one node correctly' do
      one_node = { 'Black Sabbath' => [] }
      depths = { 'Black Sabbath' => 1 }
      result = [
        "[{\"id\":1,\"label\":\"Black Sabbath\",\"color\":\"#7F825f\"}]",
        '[]'
      ]
      expect(graph_json.to_json(one_node, depths)).to eq(result)
    end

    it 'converts two nodes correctly' do
      two_nodes = {
        'Black Sabbath' => [],
        'Radiohead' => []
      }
      depths = { 'Black Sabbath' => 1, 'Radiohead' => 2 }
      result = [
        "[{\"id\":1,\"label\":\"Black Sabbath\",\"color\":\"#7F825f\"}," \
        "{\"id\":2,\"label\":\"Radiohead\",\"color\":\"#C2AE95\"}]",
        '[]'
      ]
      expect(graph_json.to_json(two_nodes, depths)).to eq(result)
    end

    it 'converts cycles correctly' do
      cycle = {
        'Black Sabbath' => ['Radiohead'],
        'Radiohead' => ['Black Sabbath']
      }
      depths = { 'Black Sabbath' => 1, 'Radiohead' => 2 }
      result = [
        "[{\"id\":1,\"label\":\"Black Sabbath\",\"color\":\"#7F825f\"}," \
         "{\"id\":2,\"label\":\"Radiohead\",\"color\":\"#C2AE95\"}]",
        "[{\"from\":1,\"to\":2},{\"from\":2,\"to\":1}]"
      ]
      expect(graph_json.to_json(cycle, depths)).to eq(result)
    end

    it 'converts self-edge nodes successfully' do
      self_edge = { 'Black Sabbath' => ['Black Sabbath'] }
      depths = { 'Black Sabbath' => 1 }
      result = [
        "[{\"id\":1,\"label\":\"Black Sabbath\",\"color\":\"#7F825f\"}]",
        "[{\"from\":1,\"to\":1}]"
      ]
      expect(graph_json.to_json(self_edge, depths)).to eq(result)
    end

    it 'converts trees properly' do
      tree = {
        'Black Sabbath' => %w(Ozzy Dio),
        'Ozzy' => %w(Radiohead Nirvana),
        'Dio' => %w(Kendrick Lamar)
      }
      depths = {
        'Black Sabbath' => 1,
        'Ozzy' => 2,
        'Dio' => 2,
        'Radiohead' => 3,
        'Nirvana' => 3,
        'Kendrick' => 3,
        'Lamar' => 3
      }
      result = [
        "[{\"id\":1,\"label\":\"Black Sabbath\",\"color\":\"#7F825f\"}," \
         "{\"id\":2,\"label\":\"Ozzy\",\"color\":\"#C2AE95\"}," \
         "{\"id\":3,\"label\":\"Dio\",\"color\":\"#C2AE95\"}]",
        "[{\"from\":1,\"to\":2},{\"from\":1,\"to\":3}]"
      ]
      expect(graph_json.to_json(tree, depths)).to eq(result)
    end

    it 'gives nodes unique id numbers' do
      random_graph_depth = generate_random_graph(max_size)
      random_graph_json = graph_json.to_json(random_graph_depth[0], random_graph_depth[1])
      random_graph = JSON.parse(random_graph_json[0])
      node_ids = []
      random_graph.each do |node|
        node_ids << node['id']
      end
      expect(node_ids).to eq(node_ids.uniq)
    end

    def generate_random_graph(size)
      graph = {}
      depths = {}
      size.times do
        name = Faker::Name.name
        graph[name] = generate_random_artist_array(20)
        depths[name] = rand(1...10)
      end
      [graph, depths]
    end

    def generate_random_artist_array(size)
      artists = []
      size.times do
        artists << Faker::Name.name
      end
      artists
    end
  end
end
