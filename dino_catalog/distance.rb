
module Distance
  def Distance::similarity(unknown, valid)
    distance = edit_distance(unknown, valid)
    distance.to_f / unknown.size
  end

  def Distance::edit_distance(s1, s2)
    edit_distance_rec(s1, s1.size, s2, s2.size)
  end

  def Distance::edit_distance_rec(str1, len1, str2, len2)
    return len2 if len1 == 0 
    return len1 if len2 == 0
 
    cost = if str1[len1 - 1] == str2[len2 - 1] then 0 else 1 end

    return [
      edit_distance_rec(str1,len1 - 1,str2,len2) + 1,
      edit_distance_rec(str1, len1, str2, len2 - 1) + 1,
      edit_distance_rec(str1, len1 - 1, str2, len2 - 1) + cost
    ].min
  end
end

