require 'rails_helper'
require 'anime_service'

RSpec.describe AnimeService, type: :lib do
  let(:service) { AnimeService.new }
  let(:gits) { 'Ghost in the shell' }
  let(:gits_id) { 3732 }

  describe '#search' do
    it 'should return a list of anime based on search title' do
      result = service.search(gits)
      expect(result).to be_an(Array)
    end

    it 'should contain certain keys' do
      result = service.search(gits)[0]
      expect(result).to include('id', 'cover_image', 'status', 'title')
    end

    it 'should not have an error key' do
      result = service.search(gits)
      expect(result).not_to be_a(Hash)
      expect(result[0]).not_to include('error')
    end
  end

  describe '#find_by_id' do
    it 'should return an anime hash based on the anime id' do
      result = service.find_by_id(gits_id)
      expect(result).to be_a(Hash)
      expect(result).not_to include('error')
    end

    it 'should return the correct anime from the anime id' do
      result = service.find_by_id(gits_id)
      expect(result['id']).to eq(gits_id)
    end
  end
end
