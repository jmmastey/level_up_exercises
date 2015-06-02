class Book < ActiveRecord::Base
  validates(:title, presence: true)

  attr_reader :title
  attr_reader :author
  attr_reader :oclc_num
  attr_reader :work_format
  attr_reader :year_published
end
