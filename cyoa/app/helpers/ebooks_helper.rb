require 'pry'
module EbooksHelper
  def locked
    (defined?(locals) && locals[:locked]).present?
  end
end
