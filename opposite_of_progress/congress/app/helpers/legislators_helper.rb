# Legislators helper module
module LegislatorsHelper
  def self.sort_options
    [["Newly Added", "created_at"],
     ["Term Start", "term_start"],
     ["Last Name", "last_name"],
     ["First Name", "first_name"]]
  end
end
