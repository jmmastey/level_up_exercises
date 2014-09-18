
class Task
  attr_reader :keyword, :callback, :description

  def initialize(keyword, callback, description)
    @keyword     = keyword
    @callback    = callback
    @description = description
  end

  def invoke(argument = "")
    if @callback.arity == 0
      @callback.call
    else
      @callback.call(argument)
    end
  end
end



class Tasks
  def initialize
    @tasks = []
    @max_key_length = 5
  end

  def add(keyword, callback, description)
    @tasks << Task.new(keyword, callback, description)
    @max_key_length = keyword.length if keyword.length > @max_key_length
  end
    
  def fire(choice)
    selection = choice.split.first
    find = @tasks.index { |task| task.keyword == selection }

    if !find.nil?
      @tasks[find].invoke(choice)
    else
      puts "Invalid Option: ".red + choice + "\n\n"
    end
  end

  def right_pad(str, width)
    format = "\%-#{width}s"
    sprintf(format, str)
  end
  
  def menu
    result = "Task-Menu\n-----------------------------------\n".yellow

    @tasks.each do |task|
      result += right_pad(task.keyword, @max_key_length).white
      result += (" - " + task.description).light_blue + "\n"
    end

    result + "\n"
  end
end
