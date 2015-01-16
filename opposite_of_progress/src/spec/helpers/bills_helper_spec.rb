require 'rails_helper'

RSpec.describe BillsHelper, :type => :helper do
  context '#link_to_bill_pdf' do
    let(:pdf) { "http://example.com/docs/test_doc.pdf" }
    let(:bill) { double('bill', latest_version_pdf: pdf)}

    it 'returns correct link' do
      allow(bill).to receive(:latest_version_pdf?).and_return(true)
      output = helper.link_to_bill_pdf(bill)
      link = Capybara.string(output).find('a')
      expect(link.text).to eq('test_doc.pdf')
      expect(link[:href]).to eq(pdf)
    end
  end

  context '#link_to_bill_favorite' do
    let(:favorite_bill) { double('favorite_bill', id: 1) }
    let(:bill) { double('bill', id: 2) }
    let(:favorite_ids) { [1] }

    it 'returns nil when user is not signed in' do
      allow(view).to receive(:user_signed_in?).and_return(false)
      output = helper.link_to_bill_favorite(favorite_bill, favorite_ids)
      expect(output).to be_nil
    end

    it 'renders correct link for favorite bill when user is signed in' do
      allow(view).to receive(:user_signed_in?).and_return(true)
      output = helper.link_to_bill_favorite(favorite_bill, favorite_ids)
      match_str = "/user/unfavorite/bill/#{favorite_bill.id}"
      expect(output).to match(match_str)
      expect(output).to match('fa-star')
    end

    it 'renders correct link for non-favorited bill when user is signed in' do
      allow(view).to receive(:user_signed_in?).and_return(true)
      output = helper.link_to_bill_favorite(bill, favorite_ids)
      match_str = "/user/favorite/bill/#{bill.id}"
      expect(output).to match(match_str)
      expect(output).to match('fa-star-o')
    end
  end
end
