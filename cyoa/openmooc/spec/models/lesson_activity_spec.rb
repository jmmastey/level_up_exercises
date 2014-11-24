require 'rails_helper'

RSpec.describe LessonActivity, type: :model do
  subject(:activity) do
    FactoryGirl.create(:lesson_activity_with_content)
  end

  describe '#destroy' do
    it 'destroys page content as well' do
      page_content = activity.page_content
      activity.destroy
      expect(PageContent.exists?(id: page_content.id)).to be false
    end
  end

  describe '::new' do
    it 'defaults with a new page_content' do
      expect(described_class.new.page_content).to be_a PageContent
    end
  end
end
