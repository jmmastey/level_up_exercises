class Hash
  def compact
    delete_if { |k, v| v.nil? }
  end
end