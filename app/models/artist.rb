class Artist < ActiveRecord::Base

  def full_name
    "#{first_name} #{last_name}"
  end
end
