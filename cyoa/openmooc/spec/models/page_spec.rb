require 'rails_helper'

RSpec.describe Page, type: :model do
  subject(:page) do
    described_class.new
  end

  let(:example_page) do
    FactoryGirl.create(:example_page)
  end

  let(:lesson) do
    FactoryGirl.create(:lesson_with_pages)
  end

  describe '#lesson=' do
    it 'sets the #postion as the size of the lesson.activities' do
      expect { page.update(lesson: lesson) }.to change { page.position }
        .from(nil).to(4)
    end
  end

  describe '#destroy' do
    it 'destory the content associated' do
      content = example_page.content
      example_page.destroy
      expect(Content.exists?(id: content.id)).to be false
    end
  end
end
