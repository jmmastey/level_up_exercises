module FlashHelper
end

class Private
  def self.convert_value_to_array(flash, *keys)
    keys.each do |key|
      flash.now[key] = Array(flash[key])
    end
  end

  def self.concat_values(flash, opts)
    from, to = opts[:from], opts[:to]
    flash.now[to] = flash[to] + flash[from]
  end
end
