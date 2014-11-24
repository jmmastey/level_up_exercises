class Course < ActiveRecord::Base
  belongs_to :page_content
  has_many :sections, dependent: :destroy
  validates_length_of :description, maximum: 400
  accepts_nested_attributes_for :page_content
  after_initialize :init

  private

  def init
    self.page_content ||= PageContent.new(content: '')
  end
end
