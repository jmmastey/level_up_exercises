require "rails_helper"

describe SearchLocuVenues, type: :interactor do
  let(:postal_code) { "60604" }

  let(:search_result) do
    contents = File.open("#{fixture_path}/search_venues_60604.json", &:read)
    JSON.parse(contents)
  end

  let(:locu_client) do
    instance_double(Locu::Client).tap do |client|
      allow(client).to receive(:search_venues)
        .and_return(search_result)
    end
  end

  subject(:search) do
    described_class.call(client: locu_client, postal_code: postal_code)
  end

  it "searches through Locu" do
    expect(locu_client).to receive(:search_venues).with(
      hash_including(location: { postal_code: "60604" })
    )

    search
  end

  it "creates merchants" do
    expect { search }.to change { Merchant.count }.by(25)
  end
end
