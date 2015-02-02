module PrivateAttrAccessor
  def private_attr_accessor(*names)
    private
    attr_accessor *names
  end
end