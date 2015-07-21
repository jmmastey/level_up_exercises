class DinoCompare

  def self.compare(dino_val, compare_to)
    int = /^[0-9]+/
    if dino_val.nil? || compare_to.nil?
      dino_val.__id__ <=> compare_to.__id__
    elsif dino_val[int] && compare_to[int]
      dino_val.to_i <=> compare_to.to_i
    else
      dino_val.downcase <=> compare_to.downcase
    end
  end

  def self.like?(dino_val, compare_val)
    if dino_val.nil? || compare_val.nil?
      dino_val.nil? && compare_val.nil?
    else
      !!(dino_val.downcase =~ /#{compare_val.downcase}/)
    end
  end

  def self.less_than?(dino_val, compare_val)
    compare(dino_val, compare_val) < 0
  end

  def self.greater_than?(dino_val, compare_val)
    compare(dino_val, compare_val) > 0
  end

  def self.equal?(dino_val, compare_val)
    compare(dino_val, compare_val) == 0
  end

  def self.less_or_equal?(dino_val, compare_val)
    !greater_than?(dino_val, compare_val)
  end

  def self.greater_or_equal?(dino_val, compare_val)
    !less_than?(dino_val, compare_val)
  end

  def self.not_equal?(dino_val, compare_val)
    !equal?(dino_val, compare_val)
  end

  def self.not_like?(dino_val, compare_val)
    !like?(dino_val, compare_val)
  end
end
