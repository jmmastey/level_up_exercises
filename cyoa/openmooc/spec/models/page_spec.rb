require 'rails_helper'

RSpec.describe Page, type: :model do
  subject(:page) do
    described_class.new
  end

  let(:lesson_page) do
    FactoryGirl.create(:example_lesson_page)
  end

  let(:section) do
    FactoryGirl.create(:section_with_pages)
  end

  describe '#section=' do
    it 'sets the #postion as the size of the section.activities' do
      expect { page.update(section: section) }.to change { page.position }.from(nil).to(4)
    end
  end

  describe '#destroy' do
    it 'destory the activity associated' do
      lesson_activity = lesson_page.activity
      lesson_page.destroy
      expect(LessonActivity.exists?(id: lesson_activity.id)).to be false
    end
  end
end
