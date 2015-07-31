class Hash
  def compact
    delete_if { |_, v| v.nil? }
  end
end
