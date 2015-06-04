class Comment < ActiveRecord::Base
  belongs_to :books
  belongs_to :users
end
