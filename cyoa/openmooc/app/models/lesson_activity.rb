class LessonActivity < ActiveRecord::Base
  has_one :page, as: :activity
  belongs_to :page_content, dependent: :destroy
  has_one :section, through: :page
  accepts_nested_attributes_for :page_content
  after_initialize :init

  private

  def init
    self.page_content ||= PageContent.new
  end
end
