require 'rails_helper'
require 'rspec/collection_matchers'

describe Course do
  subject(:course) do
    FactoryGirl.create(:course_with_lessons)
  end

  describe '#destroy' do
    it 'deletes all lessons of the course' do
      ids = course.lessons.map(&:id)
      course.destroy
      ids.each do |id|
        expect(Lesson.exists?(id: id)).to be false
      end
    end
  end

  describe '::default' do
    it 'creates a new course_page' do
      expect(described_class.default.page_content).not_to be_nil
      expect(described_class.default.page_content).to be_a PageContent
    end

    it 'creates a empty list of lessons' do
      expect(described_class.new).to have(0).lessons
    end
  end
end
