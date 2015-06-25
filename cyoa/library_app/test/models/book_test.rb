require 'test_helper'

class BookTest < ActiveSupport::TestCase

  def setup 
    @book = Book.new(author: "Erik Larson", title: "Isaac's Storm")
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "title should be present" do
    @book.title = "   "
    assert_not @book.valid?
  end
end
