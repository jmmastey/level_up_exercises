require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BillsHelper. For example:
#
# describe BillsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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
end
