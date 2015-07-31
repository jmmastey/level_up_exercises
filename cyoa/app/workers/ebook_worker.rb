require 'fuck_yeah_markdown'
class EbookWorker
  include Sidekiq::Worker

  def perform(ebook_id)
    ebook = Ebook.find(ebook_id)
    return unless ebook

    update_markdown ebook if ebook.markdown.blank?

    Dir.mktmpdir do |dir|
      ebook.generate_epub(dir, jid)

      results = Dir.glob("#{dir}/*.epub")
      unless results.empty?
        ebook.update(epub: File.open(results[0], "rb").read,
                     generated: true)
      end
    end
  end

  private

  def update_markdown ebook
    md = FuckYeahMarkdown.request(ebook.url, ebook.readability)
    ebook.update(markdown: md)
  end
end
