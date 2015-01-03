def visit_home
  visit("/")
end

def visit_good_deeds
  visit("/good_deeds")
end

def visit_good_deed(id)
  visit("/good_deeds/#{id}")
end

def visit_bills
  visit("/bills")
end

def visit_bill(id)
  visit("/bills/#{id}")
end

def visit_legislators
  visit("/legislators")
end

def visit_legislator(id)
  visit("/legislators/#{id}")
end
