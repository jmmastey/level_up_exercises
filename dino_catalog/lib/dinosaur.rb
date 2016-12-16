require 'ostruct'
class Dinosaur < OpenStruct
  def to_s
    valid_fields = to_h.reject { |_k, v| v.nil? }
    valid_fields.each_with_object("") do |(k, v), output|
      output << "#{k.capitalize}: #{v}"
      output << " lbs" if k == :weight
      output << "\n"
    end
  end
end
