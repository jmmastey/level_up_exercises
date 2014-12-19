# Bills helper module
module BillsHelper
  def self.sort_options
    [["Newly Added", "created_at"],
     ["Congress", "congress"],
     ["Introduction Date", "introduced_on"],
     ["Title", "short_title"]]
  end
end
