
module Distance
  def self::similarity(unknown, valid)
    distance = edit_distance(unknown, valid)
    distance.to_f / unknown.size
  end

  def self::edit_distance(s1, s2)
    edit_distance_rec(s1, s1.size, s2, s2.size)
  end

  def self::edit_distance_rec(str1, len1, str2, len2)
    return len2 if len1 == 0
    return len1 if len2 == 0

    cost = (str1[len1 - 1] == str2[len2 - 1]) ? 0 : 1

    [
      edit_distance_rec(str1, len1 - 1, str2, len2) + 1,
      edit_distance_rec(str1, len1, str2, len2 - 1) + 1,
      edit_distance_rec(str1, len1 - 1, str2, len2 - 1) + cost
    ].min
  end
end
