require 'rails_helper'

RSpec.describe Content, type: :model do
  subject(:content) do
    FactoryGirl.create(:content)
  end

  describe '#destroy' do
    it 'destroys page content as well' do
      page_content = content.page_content
      content.destroy
      expect(PageContent.exists?(id: page_content.id)).to be false
    end
  end

  describe '::default' do
    it 'defaults with a new page_content' do
      expect(described_class.default.page_content).to be_a PageContent
    end
  end
end
