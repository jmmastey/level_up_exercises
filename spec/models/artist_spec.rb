require 'rails_helper'

RSpec.describe Artist, type: :model do
  # merge

  it 'two empty' do
    quick_merge_expectation({},{},{})
  end

  it 'right empty' do
    quick_merge_expectation({'first' => 1},{},{'first' => 1})
  end

  it 'left empty' do
    quick_merge_expectation({},{'first' => 1},{'first' => 1})
  end

  it 'none empty, none coincide' do
    quick_merge_expectation({'first' => 1},{'second' => 2},{'first' => 1, 'second' => 2})
  end

  it 'none empty, one coincides (eq val)' do
    quick_merge_expectation({'1' => 1}, {'1' => 1}, {'1' => 1})
  end

  it 'none empty, one coincides (min left val)' do
    quick_merge_expectation({'1' => 0}, {'1' => 1}, {'1' => 1})
  end

  it 'none empty, one coincides (min right val)' do
    quick_merge_expectation({'1' => 1}, {'1' => 0}, {'1' => 1})
  end

  it 'multiple coincide (avg use)' do
    hash_1 = {
        'a' => 1,
        'b' => 2,
        'c' => 3,
        'd' => 4,
        'e' => 5,
    }

    hash_2 = {
        'a' => 4,
        'b' => 3,
        'c' => 2,
        'd' => 1,
        'e' => 7,
    }
    result = {
        'a' => 4,
        'b' => 3,
        'c' => 3,
        'd' => 4,
        'e' => 7,
    }
    quick_merge_expectation(hash_1, hash_2, result)
  end

  it 'multiple coincide with nil (avg use)' do
    hash_1 = {
        'a' => 1,
        'b' => 2,
        'c' => nil,
        'd' => 4,
        'e' => 5,
    }

    hash_2 = {
        'a' => 4,
        'b' => 3,
        'c' => 2,
        'd' => 1,
        'e' => nil,
    }
    result = {
        'a' => 4,
        'b' => 3,
        'c' => 2,
        'd' => 4,
        'e' => 5,
    }
    quick_merge_expectation(hash_1, hash_2, result)
  end

  it 'searches stuff' do
    Artist.create(name: "Black Sabbath",json: "Black Sabbath", related: ["Black Sabbath"])
    art = Artist.first
    puts art
  end

  def quick_merge_expectation(hash_1, hash_2, merged)
    expect(Artist.depth_merge!(hash_1, hash_2)).to eq(merged)
  end
end
