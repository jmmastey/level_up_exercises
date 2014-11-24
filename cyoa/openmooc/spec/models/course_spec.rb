require 'rails_helper'
require 'rspec/collection_matchers'

describe Course do
  subject(:course) do
    FactoryGirl.create(:course_with_sections)
  end

  describe '#destroy' do
    it 'deletes all sections of the course' do
      ids = course.sections.map(&:id)
      course.destroy
      ids.each do |id|
        expect(Section.exists?(id: id)).to be false
      end
    end
  end

  describe '::new' do
    it 'creates a new course_page' do
      expect(described_class.new.page_content).not_to be_nil
    end

    it 'creates a empty list of sections' do
      expect(described_class.new).to have(0).sections
    end
  end
end
