class SearchIterator  
  include Enumerable
  attr_accessor :posts, :original_queries, :page_number

  def next_page?
    false
  end

  def prev_page?
    false
  end

  def next_page
    return unless next_page?

    @page_number += 1
    change_page(to: 'next')
  end

  def prev_page
    return unless prev_page?

    @page_number  = [@page_number - 1, 0].max
    change_page(to: 'prev')
  end

  def each(&block)
    @posts.each(&block)
  end

  def list
    each_with_index do |post, idx|
      next if post.nsfw?
      puts "[ #{idx + @posts.count * @page_number} ] #{post}"
    end
  end

  def inspect
    to_s
  end

  private

  def change_page(to: 'next')
    false
  end

  # Children override the following public methods:
  # - next_page?
  # - prev_page?
  # - to_s

  # Children override the following private methods:
  # - change_page
end