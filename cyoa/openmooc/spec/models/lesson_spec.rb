require 'rails_helper'

RSpec.describe Lesson, type: :model do
  subject(:lesson) do
    FactoryGirl.create(:lesson_with_pages)
  end

  subject(:new_lesson) do
    described_class.new
  end

  let(:course) do
    FactoryGirl.create(:course_with_lessons)
  end

  describe '#destroy' do
    it 'deletes all lessons of the course' do
      ids = lesson.pages.map(&:id)
      lesson.destroy
      ids.each do |id|
        expect(Page.exists?(id: id)).to be false
      end
    end
  end

  describe '::new' do
    it 'is initialized with an empty array of activities' do
      expect(described_class.new.pages).to eq([])
    end
  end

  describe '#update' do
    it 'sets the #postion as the size of the lesson.activities' do
      expect do
        new_lesson.update(course: course)
      end.to change { new_lesson.position }.from(nil).to(4)
    end
  end
end
