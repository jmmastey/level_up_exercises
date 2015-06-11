class Book < ActiveRecord::Base
  validates(:title, presence: true)
  has_and_belongs_to_many :users
  has_many :comments
  has_many :recommendations

  def self.in_database?(oclc_num)
    self.where(oclc: oclc_num).length == 1
  end

  def self.find_by_oclc(oclc_num)
    self.where(oclc: oclc_num).first
  end

  def self.book_in_library?(current_user, book)
    current_user.books.where(oclc: book.oclc).length == 1
  end
    


end
