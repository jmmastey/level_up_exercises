json.array!(@ebooks) do |ebook|
  json.extract! ebook, :id, :user_id, :title, :description, :version, :url, :generated, :language, :publisher, :subject, :rights, :readability, :markdown, :epub
  json.url ebook_url(ebook, format: :json)
end
