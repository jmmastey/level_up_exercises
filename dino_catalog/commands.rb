module Commands
  COMMANDS = %w(help list export exit manual)

  FLAGS = {
    list: %w(-c -d -f -h -n -p -s -w),
    export: %w(-n),
  }

  def self.err_cmd(cmd)
    "> Unrecognized command: #{cmd}\n\n"
  end

  def self.err_flag(param)
    "> Invalid flag: #{param.first}\n\n"
  end

  def self.err_hash(hash)
    "> Invalid hash: #{hash}\n\n"
  end

  def self.err_params(params)
    "> Unrecognized parameters: #{params}\n\n"
  end

  def self.valid_cmd?(cmd)
    COMMANDS.include?(cmd.downcase)
  end

  def self.validate_hash_flags(flags)
    flags.reduce(true) do |_m, (k, v)|
      return puts err_hash(v) unless k
      true
    end
  end
end
