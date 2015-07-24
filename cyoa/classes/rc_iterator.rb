class RCIterator  
  include Enumerable
  attr_accessor :listings, :original_queries, :listing_number

  def next_listing?
    false
  end

  def prev_listing?
    false
  end

  def next_listing
    return unless next_listing?

    @listing_number += 1
    change_listing(to: 'next')
    current_listing
  end

  def prev_listing
    return unless prev_listing?

    @listing_number  -= 1
    change_listing(to: 'prev')
    current_listing
  end

  def current_listing
    @listings[@listing_number]
  end

  def each(&block)
    @listings.each(&block)
  end

  def [](idx)
    @listings[idx]
  end

  def list
    each_with_index do |post, idx|
      next if post.nsfw?
      puts "[ #{idx} ] #{post}\n"
    end
  end

  def inspect
    to_s
  end

  private

  def change_listing(to: 'next')
    false
  end

  # Children override the following public methods:
  # - next_listing?
  # - prev_listing?
  # - to_s

  # Children override the following private methods:
  # - change_listing
end