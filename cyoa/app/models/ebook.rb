class Ebook < ActiveRecord::Base
  belongs_to :user
  def generate_epub(dir, filename)
    dump_markdown("#{dir}/#{filename}.md")
    dump_config(dir + "/config.yml")
    Dir.chdir(dir) { %x[rpub compile] }
  end

  def dump_config dest
    file = File.open(dest, "w")
    file.puts "---"
    file.puts "creator: " + user.full_name unless user.blank?
    file.puts "language: " + language unless language.blank?
    file.puts "title: " + title unless language.blank?
    file.puts "publisher: " + publisher unless publisher.blank?
    file.puts "subject: " + subject unless subject.blank?
    file.puts "rights: " + rights unless rights.blank?
    file.puts "description: " + description unless description.blank?
    file.close
  end

  def dump_markdown dest
    file = File.open(dest, "w")
    file.puts markdown
    file.close
  end
end
