require 'rails_helper'

RSpec.describe Ebook, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:ebook)).to be_valid
  end

  it "generates an epub" do
    ebook = FactoryGirl.create(:ebook)
    allow(ebook).to receive(:dump_config)
    allow(ebook).to receive(:dump_markdown)

    stub_const("Dir", double(Dir))
    allow(Dir).to receive(:chdir)

    ebook.generate_epub("/this/is/a/path", "filename")

    expect(ebook).to have_received(:dump_config).with("/this/is/a/path/config.yml")
    expect(ebook).to have_received(:dump_markdown).with("/this/is/a/path/filename.md")
    expect(Dir).to have_received(:chdir).with("/this/is/a/path")
  end

  it "dumps markdown to disk" do
    ebook = FactoryGirl.create(:ebook, markdown: "short\nmarkdown")
    Dir.mktmpdir do |dir|
      filename = dir + "/test.md"
      ebook.dump_markdown(filename)

      expect(File.exist?(filename)).to eq(true)

      lines = IO.readlines(filename)
      expect(lines[0]).to include("short")
      expect(lines[1]).to include("markdown")
      expect(lines.size).to eq(2)
    end
  end

  it "dumps config to disk" do
    ebook = FactoryGirl.create(:ebook,
                               user: nil,
                               language: "en",
                               title: "TEST book",
                               publisher: "",
                               subject: "fiction",
                               rights: "none",
                               description: "")
    Dir.mktmpdir do |dir|
      filename = dir + "/test.yml"
      ebook.dump_config(filename)

      expect(File.exist?(filename)).to eq(true)

      lines = IO.readlines(filename)
      expect(lines[0]).to include("---")
      expect(lines[1]).to include("language: en")
      expect(lines[2]).to include("title: TEST book")
      expect(lines[3]).to include("subject: fiction")
      expect(lines[4]).to include("rights: none")
      expect(lines.size).to eq(5)
    end
  end
end
