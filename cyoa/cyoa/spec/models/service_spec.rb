require "spec_helper"

describe Service do
  subject(:service) { Service.new(name: "Grooveshark", url: "http://grooveshark.com") }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:url) }
  it { should respond_to(:charts) }

  describe "#name" do
    it "must have a unique name" do
      service.save
      same_service = service.dup
      same_service.name = service.name.downcase
      same_service.save

      expect(same_service).not_to be_valid
    end
  end

  describe "#url" do
    xit "must have a url leading with http:// or https://" do
      pending
    end

    it "must have a unique url" do
      service.save
      same_service = service.dup
      same_service.url = service.url.downcase
      same_service.save

      expect(same_service).not_to be_valid
    end
  end
end
